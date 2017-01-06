package
{
	import flash.display.Sprite;
	import ppppu.AppCore;
	import flash.events.Event;
	
	/**
	 * Main entryway into the program. Creates an instance of ppppuCore, adds it 
	 * @author ppppuProgrammer
	 */
	
	public class Main extends Sprite
	{
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			var ppppuApp:ppppu.AppCore = new ppppu.AppCore();
			addChild(ppppuApp);
			removeEventListener(Event.ADDED_TO_STAGE, init);
			ppppuApp.Initialize();
			
		}
	}
}