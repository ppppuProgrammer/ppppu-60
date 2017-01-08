package modifications 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * Base class to be used for any class that will load in new content into ppppu.
	 * @author 
	 */
	public class Mod extends Sprite
	{
		/*Constants*/
		//The mod type is undefined. If this value is returned then a sub class did not properly set its type. 
		public static const MOD_UNDEFINED:int = -1;
		//The mod will add in an animation
		public static const MOD_ARCHIVE:int = 0;
		//The mod will add in a character
		public static const MOD_CHARACTER:int = 1;
		//The mod will add in music
		public static const MOD_MUSIC:int = 2;
		//The mod will add in new graphics, such as background, character parts, clothing, and more.
		public static const MOD_ASSETS:int = 3;
		//This mod is actually an archive and contains multiple mods of possibly various types.
		public static const MOD_ANIMATION:int = 4;
		
		protected var modType:int = MOD_UNDEFINED;
		//Upon creation, a ppppuMod will listen for an added to stage event and when added to the stage will invoke the first frame function.
		//That function is where the content will be generated for use then added into the main program.
		public function Mod() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, FirstFrame);
		}
		
		//Function to be implemented by any sub classes. This is where the subclass will do any work necessary to get the data ready to
		//be read by the ppppu program
		protected function FirstFrame(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, FirstFrame);
		}
		
		public function GetModType():int { return modType;}
		
	}

}