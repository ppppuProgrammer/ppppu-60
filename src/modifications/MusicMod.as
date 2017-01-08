package modifications 
{
	import flash.media.Sound;
	import modifications.Mod;
	/**
	 * ...
	 * @author 
	 */
	public class MusicMod extends Mod
	{
		//Contains the audio data that will be played.
		protected var musicFile:Sound=null;
		//Where to start playing the music from on the inital playback.
		protected var startTime:Number=0;
		//Time in milliseconds of where to set the playhead when the endLoopTime is reached.
		protected var startLoopTime:Number = 0;
		//Time in milliseconds of where  the end loop of the music is. Upon reaching this, the playhead will be set to the start loop time.
		protected var endLoopTime:Number = -1;
		protected var musicName:String = "";
		
		public function MusicMod() 
		{
			modType = Mod.MOD_MUSIC;
		}
		
		public function GetMusicData():Sound
		{
			return musicFile;
		}
		public function GetStartTime():Number
		{
			return startTime;
		}
		public function GetStartLoopTime():Number
		{
			return startLoopTime;
		}
		public function GetEndLoopTime():Number
		{
			return endLoopTime;
		}
		public function GetName():String
		{
			return musicName;
		}
	}
}