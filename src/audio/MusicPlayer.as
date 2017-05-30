package audio
{
	import audio.Music;
	import flash.media.Sound;
	import flash.media.SoundMixer;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.events.Event; 
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	//import mx.logging.*;
	import flash.events.UncaughtErrorEvent;
	
	public class MusicPlayer 
	{
		private var canPlayMusic:Boolean = true; //If music is allowed to play at all
		//private var m_characterMusic:Vector.<Sound>; //Holds the various Sound objects that are used as a character's background music.
		
		//Holds various, unique Music objects that contain a character's background music and the logic needed to play it.
		private var musicCollection:Vector.<Music>; 
		//Keep track of the name - Id relation of the music added to the player
		private var musicIdLookup:Dictionary;
		//private var initialMusicSetUsed:Boolean = false;
		
		private var currentlyPlayingMusicId:int = -1; //-1 means no song has been played yet, any other corresponds to an index for an object in m_characterMusic
		private var mainSoundChannel:SoundChannel; //Sound channel used by the currently playing Sound

		private var bgmSoundTransform:SoundTransform = new SoundTransform();
		
		//Time in milliseconds between the character switch transition. Used for music time rounding purposes to keep it in sync with the animation.
		private const MUSICSEGMENTTIMEMILLI:int = 4000;
		
		
		
		//The logging object for this class
		//private var logger:ILogger;
		
		//SMLSE: String to customize fade pattern for linked scene bgm, not fully implemented and may need to be moved elsewhere (e.g., defined for each linked scene and passed as argument)
		private var fadeType:String = "linear";
		
		//Sets up the vectors in the music manager. This should be done after all characters have been added and locked in.
		public function MusicPlayer()
		{
			//Create the logger object that's used by this class to output messages.
			//logger = Log.getLogger("MusicPlayer");
			//logger.info("Initializing Music Player");
			musicCollection = new Vector.<Music>();

			musicIdLookup = new Dictionary();
		}
		
		public function AddMusic(soundData:Sound, musicName:String, musicInfo:String, loopStartTimeMs:Number=0, loopEndTimeMs:Number=0, musicStartTimeMs:Number=0):Boolean
		{
			if(soundData != null)
			{
				if(soundData.bytesTotal == 0)
				{
					//logger.warn("Music \"" + musicName + "\" was not added as it contained no data");
					return false;//Sound did not load, do not add it to the character music vector
				}
				
				//Values lower than 0 mean to calculate the loop end point by adding the [negative] given loop end point's value to the bgm's length.
				if (loopEndTimeMs < 0.0)
				{
					loopEndTimeMs = soundData.length + loopEndTimeMs;
				}
				var MusicObj:Music = new Music(soundData, musicName, musicInfo, loopStartTimeMs, loopEndTimeMs, musicStartTimeMs);
				var musicNum:int = musicCollection.length;	// SMLSE OPTIMIZE ATTEMPT
				for (var i:int = 0; i < musicNum; ++i)
				{
					if (musicCollection[i] != null)
					{
						//Music checking only cares that 2 songs don't have to same name.
						if (musicCollection[i].GetMusicInfo().toLowerCase() == musicName.toLowerCase())
						{
							//logger.warn("Music \"" + musicName + "\" was not added as music with the same name was already added.");
							return false;
						}
					}
				}
				
				var musicId:int = musicCollection.length;
				musicCollection[musicId] = MusicObj;
				musicIdLookup[musicName] = musicId;
				return true;
			}
			//logger.warn("Music \"" + musicName + "\" was not added as it contained no data");
			return false;
		}
		
		CONFIG::NX
		{
		//Changes the music without playing it.
		public function ChangeMusicToPlay(musicId:int):void
		{
			if (musicId != currentlyPlayingMusicId)
			{
				currentlyPlayingMusicId = musicId;
			}
		}
		}
		
		/*Attempts to play a certain music track based on it's id.
		 * currentTimeIntoAnimation - the amount of time that the current animation has completed in milliseconds. Expects animations to last for 4 seconds.
		 * if musicId is -2 then it invokes a context based action involving whether music can play or not.
		 * if Music can play then it will resume playing music based on the currentplayingmusicid. If music playing isn't allowed then it'll
		 * stop playing the currently selected music but not set it to -1, which indicates that no music has been selected.
		 * */
		
		//public function PlayMusic( musicId:int, currentFrame:uint /*, characterId:int=-1,*/):String
		public function PlayMusic(musicId:int, currentTimeIntoAnimation:Number):String
		{
			//trace("time:" + currentTimeIntoAnimation);
			//If music is allowed to play and the music id given is already playing then exit the function.
			//Return null as there were no changes to the music 
			if (musicId == -1) { return null;}
			if (musicId == currentlyPlayingMusicId && musicId > -1 && canPlayMusic == true) { return null; }
			
			var bgm:Music;
			var playheadPosition:Number;
			
			if (musicId > -1 && musicId < musicCollection.length && canPlayMusic == true)
			{
				//stop music
				if (currentlyPlayingMusicId > -1)
				{
					StopMusic();

					//currentlyPlayingMusicId = -1;
				}
				
				bgm = musicCollection[musicId];
				
				//currentAnimationFrame = currentFrame;
				/*To keep the animation and music synced, do a check to see what part of the 4 second "block"
				 * the music was stopped on. If it was before the frame (out of 120) that the animation is on now, just set the music forward a bit to match the position.
				 * If it was on or after the frame the animation is on, move to the next "block" for the music and then set the playhead's position to match that position.
				 * [1][2][3][4][5][6]
				 * If animation was on frame 4 when music changed, music's last frame was 4. 
				 * Later on, the music is set back when the animation is on frame 2.
				 * Because of this, the music will advance 118 frames worth of time to be in the right place
				 * If the animation was instead on frame 6, the music would only need to advance 2 frames worth of time.*/
				
				//last frame the music was played is less than the frame the animation is in, advance the music just enough to match
				playheadPosition = bgm.GetPlayheadPosition();
				//Round down the playhead position to the last frame.
				var musicPositionInAnimation:Number = playheadPosition % MUSICSEGMENTTIMEMILLI;
				//Here's how to visualize how animation and music timing works. [] represents a 4 second blocks of time for the music
				//[0-4][4-8][8-12][12-16][16-20]
				//Animation time is how far into a 4 second block that an animation is in.
				if (musicPositionInAnimation <= currentTimeIntoAnimation)
				{
					//Music's (last) position into the animation is less than the current time the animation is into.
					//Only need to move up the music's position a bit. To help visualize:
					//[0-4][4-8][8-12][12-16][16-20]
					//Music was last at 2.5s when the play was requested, animation is 3 seconds done.
					//Music just needs to be set to be in the same time as the animation in it's current block
					//so music is set to be at 3 seconds in (this does not include the time skipped due to the start point for music)
					bgm.SetPlayheadPosition(playheadPosition + (currentTimeIntoAnimation - musicPositionInAnimation));
				}
				else
				{
					//Music's (last) position is after the time that the animation is in. Need to skip to the next 4 second
					//section for the music then set it to match the time into animation. To help visualize:
					//[0-4][4-8][8-12][12-16][16-20]
					//Music was last at 2.5 seconds, Animation is 1.5 seconds done
					//The music should not rewind to match the position of the animation. So it must be set to its next block.
					//Music is now changed to the 4-8 second block, starting at 4 seconds. Then the amount of time the animation
					//has completed is added, making the music be 5.5 seconds in.
					//playheadPosition = (Math.ceil(playheadPosition / 4.0) * 4.0) + currentTimeIntoAnimation;
					bgm.SetPlayheadPosition((Math.round(playheadPosition / MUSICSEGMENTTIMEMILLI) * MUSICSEGMENTTIMEMILLI) + currentTimeIntoAnimation);
				}
				mainSoundChannel = bgm.Play();
				currentlyPlayingMusicId = musicId;	
			}
			else if(musicId == -2)
			{
				//resuming the last music that played
				if (canPlayMusic && currentlyPlayingMusicId > -1)
				{
					bgm = musicCollection[currentlyPlayingMusicId];

					playheadPosition = bgm.GetPlayheadPosition();
					var musicPositionInAnimationAlt:Number = playheadPosition % MUSICSEGMENTTIMEMILLI;
					if (musicPositionInAnimationAlt <= currentTimeIntoAnimation)
					{
						bgm.SetPlayheadPosition(playheadPosition + (currentTimeIntoAnimation - musicPositionInAnimationAlt));
					}
					else
					{
						bgm.SetPlayheadPosition((Math.round(playheadPosition / MUSICSEGMENTTIMEMILLI) * MUSICSEGMENTTIMEMILLI) + currentTimeIntoAnimation);
					}
					mainSoundChannel = bgm.Play();
				}
				else //Stop the currently playing song but don't change m_currentlyPlayingMusicId
				{
					if (currentlyPlayingMusicId > -1)
					{
						musicCollection[currentlyPlayingMusicId].Stop();
					}
					if (mainSoundChannel)
					{
						mainSoundChannel.stop();
						mainSoundChannel = null;
					}
				}
			}
			else 
			{
				if (currentlyPlayingMusicId > -1)
				{
					musicCollection[currentlyPlayingMusicId].Stop();
				}
				if (mainSoundChannel != null)
				{
					mainSoundChannel.stop();
					mainSoundChannel = null;
				}
				//If music can't play then don't change the currently playing music
				//m_currentlyPlayingMusicId = -1;
			}
			if (mainSoundChannel)
			{
				mainSoundChannel.soundTransform = bgmSoundTransform;
			}

			if (canPlayMusic == true)
			{
				if (currentlyPlayingMusicId == -1)
				{
					return "No Music Selected";
				}
				else
				{
					return musicCollection[currentlyPlayingMusicId].GetMusicInfo();
				}
			}
			else
			{
				return "Music Off";
			}
		}
		
		//public function StopMusic(currentFrame:uint):void
		public function StopMusic():void
		{
			if (currentlyPlayingMusicId > -1 )
			{
				if (mainSoundChannel != null)
				{
					mainSoundChannel.stop();
				}
				musicCollection[currentlyPlayingMusicId].Stop();
				mainSoundChannel = null;
				currentlyPlayingMusicId = -1;
			}
		}
		
		public function PauseMusic():void
		{
			if (currentlyPlayingMusicId > -1 )
			{
				musicCollection[currentlyPlayingMusicId].Stop();
				if (mainSoundChannel != null)
				{
					mainSoundChannel.stop();
					mainSoundChannel = null;
				}
				
				//trace(musicCollection[currentlyPlayingMusicId].GetPlayheadPosition());
			}
		}
		
		public function ResumeMusic(currentTimeIntoAnimation:Number=0.0):void
		{
			if (currentlyPlayingMusicId > -1)
			{
				if (mainSoundChannel != null){
					mainSoundChannel.stop;
				}
				var bgm:Music = musicCollection[currentlyPlayingMusicId];
				var playheadPosition:Number = bgm.GetPlayheadPosition();
				//Round down the playhead position to the last frame.
				var musicPositionInAnimation:Number = playheadPosition % MUSICSEGMENTTIMEMILLI;

				/*if (musicPositionInAnimation <= currentTimeIntoAnimation){
					bgm.SetPlayheadPosition(playheadPosition + (currentTimeIntoAnimation - musicPositionInAnimation));
				}
				else{
					bgm.SetPlayheadPosition(playheadPosition + (currentTimeIntoAnimation - musicPositionInAnimation));
				}*/
				/*if (musicPositionInAnimation <= currentTimeIntoAnimation){
					bgm.SetPlayheadPosition(playheadPosition + (currentTimeIntoAnimation - musicPositionInAnimation));
				}
				else */if (musicPositionInAnimation > currentTimeIntoAnimation)
				{
					bgm.SetPlayheadPosition(playheadPosition - (musicPositionInAnimation - currentTimeIntoAnimation));
				}
				//trace(bgm.GetPlayheadPosition());
				mainSoundChannel = bgm.Play();
				
			}
		}
		
		[inline]
		private function AlignMusicToAnimationPosition(currentTimeIntoAnimation:Number):void
		{
			
		}
		
		//Adjusts the volume of the sound globally.
		public function ControlVolume(musicVolume:Number):void
		{
			var soundT:SoundTransform = new SoundTransform();
			soundT.volume = musicVolume;
			SoundMixer.soundTransform = soundT;
		}
		
		//SMLSE: Adjusts volume of only BGM (other audio, such as sounds from characters, left at full volume)
		public function ControlBGMVolume(musicVolume:Number):void
		{
			//var soundT:SoundTransform = new SoundTransform();
			bgmSoundTransform.volume = musicVolume
			if (mainSoundChannel)
			{
			mainSoundChannel.soundTransform = bgmSoundTransform;
			}
		}
		
		public function ChangeToPrevMusic(animationTime:Number):String
		{
			var prevMusicId:int = currentlyPlayingMusicId - 1;
			if (prevMusicId < 0) { prevMusicId = musicCollection.length - 1; }
			
			return PlayMusic(prevMusicId, animationTime);
		}
		
		public function ChangeToNextMusic(animationTime:Number):String
		{
			var nextMusicId:int = currentlyPlayingMusicId + 1;
			if (nextMusicId >= musicCollection.length) { nextMusicId = 0; }
			
			return PlayMusic(nextMusicId, animationTime);
		}
		
		public function GetMusicIdByName(name:String):int
		{
			var musicNum:int = musicCollection.length;	// SMLSE OPTIMIZE ATTEMPT
			for (var i:int = 0; i < musicNum; ++i)
			{
				if (name == musicCollection[i].GetMusicName())
				{
					return i;
				}
			}
			//Didn't find the name
			return -1;
		}
		
		//returns whether any music is allowed to be played/heard
		public function IsMusicPlaying():Boolean
		{
			return canPlayMusic;
		}
		
		public function SetIfMusicIsEnabled(musicEnabled:Boolean):Boolean
		{
			canPlayMusic = musicEnabled;
			return canPlayMusic;
		}
		
		public function GetNameOfCurrentMusic():String
		{
			if (currentlyPlayingMusicId < 0 || currentlyPlayingMusicId > musicCollection.length){return "Music not found";}
			return musicCollection[currentlyPlayingMusicId].GetMusicName();
		}
		
		public function GetCurrentlyPlayingMusicInformation():String
		{
			if (currentlyPlayingMusicId < 0 || currentlyPlayingMusicId > musicCollection.length){return "Music not found";}
			return musicCollection[currentlyPlayingMusicId].GetMusicInfo();
		}
		
		//SMLSE: added to adjust audio level with certain pattern
		public function FadeLinkedSceneAudio(currentFrame:uint, fadeBounds:Vector.<int>):void
		{
			// Unless re-used elsewhere, should not be accessed if BGM off, so no IsMusicPlaying() check needed here
			if (currentFrame >= fadeBounds[1])
			{
				StopMusic();
			}
			else if (currentFrame > fadeBounds[0] && currentFrame < fadeBounds[1])
			{
				var frameFraction:Number = (currentFrame - fadeBounds[0]) / (fadeBounds[1] - fadeBounds[0]);
				switch(fadeType)
				{
					case "linear":
						var volumeFraction:Number = 1 - frameFraction;
						ControlBGMVolume(volumeFraction);
						break;
					default:
						//logger.error(fadeType + " is an unrecognized audio fade type.");
						break;
				}
			}
		}
		
		//SMLSE: check whether BGM (main audio) is stopped (TODO: use in other MusicPlayer functions)
		public function IsBGMStopped():Boolean
		{
			return (mainSoundChannel == null);
		}
		
		//Debug functions
		public function PreviewMusic(musicId:int):void
		{
			if (!IsBGMStopped())
			{
				StopMusic();
			}
			if (musicId > -1)
			{
				//var loopTestMusic:Sound = musicCollection[musicId].GetMusicCopyForLoopPointTesting();
				mainSoundChannel = musicCollection[musicId].Play();
				mainSoundChannel.soundTransform = bgmSoundTransform;
				currentlyPlayingMusicId = musicId;
				//trace(bgm.GetPlayheadPosition());
				//trace(m_mainSoundChannel.position);
			}
		}
		//Creates a temporary Music object that contains 8 seconds of audio, 4 before the loop point and 4 after, and plays it.
		public function TestMusicLoop(musicId:int):void
		{
			if (!IsBGMStopped())
			{
				StopMusic();
			}
			if (musicId > -1)
			{
				//var loopTestMusic:Sound = musicCollection[musicId].GetMusicCopyForLoopPointTesting();
				mainSoundChannel = musicCollection[musicId].GetMusicCopyForLoopPointTesting().Play();
				currentlyPlayingMusicId = musicId;
				mainSoundChannel.soundTransform = bgmSoundTransform;
				//trace(bgm.GetPlayheadPosition());
				//trace(m_mainSoundChannel.position);
			}
		}
	}
}