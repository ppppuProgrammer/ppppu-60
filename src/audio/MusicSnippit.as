package audio
{
	import flash.media.Sound;
	import flash.events.SampleDataEvent;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.ByteArray;
	/*Used to provide short, unlooping music in as3. This can be done using wav files in the fla to avoid mp3 related issues with seamless looping
	 * or by using LAME created mp3s to know the values of the encoder delay and padding, and adjusting the time related parameters to accomodate.
	 * Only music that has a sample rate of 44.1kHz and stereo channels are guaranteed to work properly*/
	public class MusicSnippit
	{
		private static const SAMPLES_PER_REQUEST:int = 8192;
		
		private var m_sourceSound:Sound; //The Sound that contains audio data needed to play music
		
		private var m_playSound:Sound = new Sound(); //The empty proxy Sound that is used to actually play audio data
		private var m_soundData:ByteArray = new ByteArray();
		private var m_extractedSamples:Number;
		private var m_currentSamplePosition:Number;
		private var soundChannel:SoundChannel;
		private var endSampleNumber:Number;
		
		public function MusicSnippit(sourceSound:Sound)
		{
			m_sourceSound = sourceSound;
			
			m_currentSamplePosition = 0;
			endSampleNumber = Music.FLASH_SOUND_OUTPUT_SAMPLE_RATE * (m_sourceSound.length / 1000.0);
			
		}
		
		public function SetPlayheadPosition(timeInMillisec:Number):void
		{
			m_currentSamplePosition = ConvertMillisecTimeToSample(timeInMillisec);
		}
		
		public function GetPlayheadPosition():Number
		{
			return ConvertSampleTimeToMillisec(m_currentSamplePosition);
		}
		
		//Returns the length of the music in milliseconds
		public function GetMusicLength():Number 
		{
			return m_sourceSound.length;
		}
		
		public function Play():SoundChannel
		{
			m_playSound.addEventListener(SampleDataEvent.SAMPLE_DATA, SendSampleData);
			m_currentSamplePosition = 0;
			
			return soundChannel = m_playSound.play();
		}
		
		public function Stop():void
		{
			m_playSound.removeEventListener(SampleDataEvent.SAMPLE_DATA, SendSampleData);
		}
		
		public function SendSampleData(event:SampleDataEvent):void
		{
			
			
			m_soundData.clear();
			var samplesToExtract:Number = SAMPLES_PER_REQUEST;
			if (m_currentSamplePosition + SAMPLES_PER_REQUEST > endSampleNumber)
			{
				samplesToExtract = endSampleNumber - m_currentSamplePosition;
			}
			m_extractedSamples = m_sourceSound.extract(m_soundData, samplesToExtract, m_currentSamplePosition);
			if (m_extractedSamples != SAMPLES_PER_REQUEST)
			{
				Stop();
			}
			m_currentSamplePosition += m_extractedSamples;
			
			//Music fade out
			var musicCompletionPercentage:Number = m_currentSamplePosition / endSampleNumber;
			var fadeOutPoint:Number = .75;
			if (musicCompletionPercentage > fadeOutPoint)
			{
				soundChannel.soundTransform = new SoundTransform(soundChannel.soundTransform.volume * (1-(musicCompletionPercentage - fadeOutPoint) / (1.0 - fadeOutPoint)));
			}
			
			event.data.writeBytes(m_soundData);
		}
		private function ConvertMillisecTimeToSample(timeMs:Number):Number
		{
			//millisecond to sample conversion: sample rate * (timeInMS / 1000)
			var retValue:Number;
			retValue = Music.FLASH_SOUND_OUTPUT_SAMPLE_RATE * (timeMs / 1000.0);
			return int(retValue);
		}
		
		private function ConvertSampleTimeToMillisec(timeSample:Number):Number
		{
			return (timeSample / Music.FLASH_SOUND_OUTPUT_SAMPLE_RATE) * 1000.0;
		}
	}
}