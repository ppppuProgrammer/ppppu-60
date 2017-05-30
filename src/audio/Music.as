package audio
{
	import flash.media.Sound;
	import flash.events.SampleDataEvent;
	import flash.media.SoundChannel;
	import flash.utils.ByteArray;
	/*Used to provide gapless music loops in as3. This can be done using wav files in the fla to avoid mp3 related issues with seamless looping
	 * or by using LAME created mp3s to know the values of the encoder delay and padding, and adjusting the time related parameters to accomodate.
	 * Only music that has a sample rate of 44.1kHz and stereo channels are guaranteed to work properly*/
	public class Music
	{
		private static const SAMPLES_PER_REQUEST:int = 8192;
		public static const FLASH_SOUND_OUTPUT_SAMPLE_RATE:int = 44100;
		
		public var m_musicStartTime:Number; //Time position in milliseconds to start from when sound is first played.
		public var m_musicStartSampleNumber:Number;
		
		public var m_loopStartTime:Number; //Time position in milliseconds to go to when the loop end position has been reached
		public var m_loopStartSampleNumber:Number;
		
		public var m_loopEndTime:Number; //Time position in milliseconds that is considered the end of the song. Upon reaching this time, the music will jump back to the indicated loop start time
		public var m_loopEndSampleNumber:Number;
		
		private var musicName:String;	
		//Optional string that will be used instead of the name when the music player's menu gives information on the playing music.
		private var m_displayInfo:String;
		
		private var m_sourceSound:Sound; //The Sound that contains audio data needed to play music
		
		private var m_playSound:Sound = new Sound(); //The empty proxy Sound that is used to actually play audio data
		private var m_soundData:ByteArray = new ByteArray();
		private var m_extractedSamples:Number;
		private var m_currentSamplePosition:Number;
		
		private var cachedMusicForLoopTest:MusicSnippit = null;
		
		private var TEST_sampleLock:Boolean = false;
		
		public function Music(sourceSound:Sound, musicTitle:String, musicInfo:String, loopStartPoint:Number = 0, loopEndPoint:Number = -1, musicStartPoint:Number = 0)
		{
			musicName = musicTitle;
			m_displayInfo = musicInfo;
			m_sourceSound = sourceSound;
			
			if (loopEndPoint == -1)
			{
				m_loopEndTime = m_sourceSound.length;
			}
			else
			{
				m_loopEndTime = loopEndPoint;
			}
			
			m_loopEndSampleNumber = ConvertMillisecTimeToSample(m_loopEndTime);

			if (musicStartPoint >= 0)
			{
				m_musicStartTime = musicStartPoint;
			}
			else
			{
				m_musicStartTime = 0;
			}
			m_musicStartSampleNumber = ConvertMillisecTimeToSample(m_musicStartTime);
			m_currentSamplePosition = m_musicStartSampleNumber;
			
			if (loopStartPoint >= 0)
			{
				m_loopStartTime = loopStartPoint;
			}
			else
			{
				m_loopStartTime = m_musicStartTime;
			}
			m_loopStartSampleNumber = ConvertMillisecTimeToSample(m_loopStartTime);
		}
		
		public function Equals(otherMusicObject:Music):Boolean
		{
			if (this.m_sourceSound == otherMusicObject.m_sourceSound && this.m_loopStartTime == otherMusicObject.m_loopStartTime && 
				this.m_loopEndTime == otherMusicObject.m_loopEndTime && this.m_musicStartTime == otherMusicObject.m_musicStartTime)
			{
				return true;
			}
			return false;
		}
		
		public function SetPlayheadPosition(timeInMillisec:Number):void
		{
			m_currentSamplePosition = ConvertMillisecTimeToSample(timeInMillisec);
		}
		
		public function GetPlayheadPosition():Number
		{
			return ConvertSampleTimeToMillisec(m_currentSamplePosition);
		}
		
		/*public function GetSourceSound():Sound
		{
			return m_sourceSound;
		}*/
		
		/*public function GetPlaySound():Sound
		{
			return m_playSound;
		}*/
		
		//Returns the length of the music in milliseconds
		public function GetMusicLength():Number 
		{
			return m_sourceSound.length;
		}
		public function GetMusicStartTime():Number 
		{
			return m_musicStartTime;
		}
		public function GetMusicName():String
		{
			return musicName;
		}
		public function GetLoopStart():Number
		{
			return this.m_loopStartTime;
		}
		public function GetMusicInfo():String
		{
			return m_displayInfo;
		}
		public function Play():SoundChannel
		{
			TEST_sampleLock = false;
			m_playSound.addEventListener(SampleDataEvent.SAMPLE_DATA, SendSampleData);
			return m_playSound.play();
		}
		
		public function Stop():void
		{
			TEST_sampleLock = true;
			m_playSound.removeEventListener(SampleDataEvent.SAMPLE_DATA, SendSampleData);
			if (cachedMusicForLoopTest) { cachedMusicForLoopTest.Stop()};
		}
		
		public function SendSampleData(event:SampleDataEvent):void
		{
			m_soundData.clear();
			var samplesToExtract:Number = SAMPLES_PER_REQUEST;
			if (m_currentSamplePosition + SAMPLES_PER_REQUEST > this.m_loopEndSampleNumber)
			{
				samplesToExtract = this.m_loopEndSampleNumber - m_currentSamplePosition;
			}
			m_extractedSamples = m_sourceSound.extract(m_soundData, samplesToExtract, m_currentSamplePosition);
			if (m_extractedSamples != SAMPLES_PER_REQUEST)
			{
				if (m_currentSamplePosition + m_extractedSamples >= this.m_loopEndSampleNumber)
				{
					m_currentSamplePosition = this.m_loopStartSampleNumber;
				}
				m_extractedSamples +=  m_sourceSound.extract(m_soundData, SAMPLES_PER_REQUEST - m_extractedSamples, m_currentSamplePosition);
			}
			if(!TEST_sampleLock){
			m_currentSamplePosition += m_extractedSamples;}
			
			event.data.writeBytes(m_soundData);
		}
		private function ConvertMillisecTimeToSample(timeMs:Number):Number
		{
			//millisecond to sample conversion: sample rate * (timeInMS / 1000)
			var retValue:Number;
			retValue = FLASH_SOUND_OUTPUT_SAMPLE_RATE * (timeMs / 1000.0);
			return int(retValue);
		}
		
		private function ConvertSampleTimeToMillisec(timeSample:Number):Number
		{
			return (timeSample / FLASH_SOUND_OUTPUT_SAMPLE_RATE) * 1000.0;
		}
		
		//Creates a shorten copy of the current Music object for the purpose of testing the loop point.
		public function GetMusicCopyForLoopPointTesting():MusicSnippit
		{
			if (!cachedMusicForLoopTest)
			{
				var loopSoundData:ByteArray = new ByteArray();
				
				m_sourceSound.extract(loopSoundData, Music.FLASH_SOUND_OUTPUT_SAMPLE_RATE * 4, m_loopEndSampleNumber - (Music.FLASH_SOUND_OUTPUT_SAMPLE_RATE * 4));
				m_sourceSound.extract(loopSoundData, Music.FLASH_SOUND_OUTPUT_SAMPLE_RATE * 4, m_loopStartSampleNumber);
				loopSoundData.position = 0;
				var loopSound:Sound = new Sound();
				loopSound.loadPCMFromByteArray(loopSoundData, Music.FLASH_SOUND_OUTPUT_SAMPLE_RATE * 8);
				//loopSound.loadCompressedDataFromByteArray(loopSoundData, loopSoundData.length);
				cachedMusicForLoopTest = new MusicSnippit(loopSound);
				//cachedMusicForLoopTest = loopSound;// new Music(loopSound, m_title+"_LoopTest");
			}
			return cachedMusicForLoopTest;
		}
	}
}