package Mod 
{
	import flash.media.Sound;
	import Mod.ppppuMod;
	/**
	 * ...
	 * @author 
	 */
	public class MusicMod extends ppppuMod
	{
		//Contains the audio data that will be played.
		protected var musicFile:Sound=null;
		//Where to start playing the music from on the inital playback.
		protected var startTime:int=0;
		//Time in milliseconds of where to set the playhead when the endLoopTime is reached.
		protected var startLoopTime:int = 0;
		//Time in milliseconds of where  the end loop of the music is. Upon reaching this, the playhead will be set to the start loop time.
		protected var endLoopTime:int = -1;
		protected var musicName:String = "";
		
		public function MusicMod() 
		{
			modType = ppppuMod.MOD_MUSIC;
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