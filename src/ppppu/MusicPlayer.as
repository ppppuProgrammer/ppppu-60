package ppppu 
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.Dictionary;
	import ppppu.Music;
	/**
	 * ...
	 * @author 
	 */
	public class MusicPlayer 
	{
		private var canPlayMusic:Boolean = true; //If music is allowed to play at all
		private var updateRate:Number;
		
		//Holds various, unique ppppuMusic objects that contain a Sound object and the logic needed to play it.
		private var musicPlaylist:Vector.<ppppu.Music> = new Vector.<ppppu.Music>(); 
		private var musicIdLookup:Dictionary = new Dictionary();
		
		private var currentlyPlayingMusicId:int = -1;
		
		//Controls various properties of the music being played 
		private var musicSoundChannel:SoundChannel;
		public function MusicPlayer() 
		{
			
		}
		
		public function PlayMusic(musicId:int, secondsIntoAnimation:Number=-1, durationOfAnimation:Number=0):void
		{
			/*Fail condition check*/
			//Make sure the requested music to play is not already playing
			if (musicId == currentlyPlayingMusicId) { return; }
			if (musicId < -1 || musicId >= musicPlaylist.length) { return; }
			if (musicId == -1) 
			{ 
				if (musicSoundChannel)
				{
					musicPlaylist[currentlyPlayingMusicId].Stop();
					musicSoundChannel.stop();
					musicSoundChannel = null; 
					currentlyPlayingMusicId = -1;
				}
			}
			/*Passed the check*/
			//If secsIntoAnimation is -1 then it means to play the animation from the very beginning
			if (secondsIntoAnimation == -1)
			{
				musicSoundChannel = musicPlaylist[musicId].Play();
				currentlyPlayingMusicId = musicId;
			}
			else
			{
				/*Seconds into animation being a value greater than or equal to 0 means that the music's play position should be based
				 * off the playhead's current position and how much of the animation is done and its duration.*/
				currentlyPlayingMusicId = musicId;
			}
		}
		
		public function AddMusic(music:Sound, musicTitle:String, loopStartTimeMs:Number=0, loopEndTimeMs:Number=-1, musicStartTimeMs:Number=0):void
		{
			if (music == null || musicTitle == null) { return; }
			
			if (musicTitle.length > 0 && !(musicTitle in musicIdLookup))
			{
				//Sound did not load
				if (music.bytesTotal == 0) { return; }
				
				var ppppuMusicObj:ppppu.Music = new ppppu.Music(music, musicTitle, loopStartTimeMs, loopEndTimeMs, musicStartTimeMs);
				
				//Look through previously added music and see if there something already using the same source sounds and loop settings.
				for (var index:int = 0, l:int = musicPlaylist.length; index < l; ++index)
				{
					if (musicPlaylist[index] != null)
					{
						if (musicPlaylist[index].Equals(ppppuMusicObj) == true)
						{
							//There's already a music object with the same source sound and same loop settings. 
							return;
						}
					}
				}
				
				//Time to add the music to the playlist and to the look up table
				var musicIndex:int = musicPlaylist.length;
				musicPlaylist[musicIndex] = ppppuMusicObj;
				musicIdLookup[musicTitle] = musicIndex;
			}
		}
		
		public function SetUpdateRate(flashFrameRate:int):void
		{
			updateRate = flashFrameRate;
		}
		
		//Uses the lookup dictionary to get the id of a loaded music by its name/title.
		//Returns a value of 0 or greater if the music name was found
		//Returns -1 if no music by the given name was found.
		public function GetIdOfMusicByName(musicName:String):int
		{
			var returnIdValue:int = -1;
			if (musicName in musicIdLookup)
			{
				returnIdValue = musicIdLookup.musicName;
			}
			return returnIdValue;
		}
	}

}