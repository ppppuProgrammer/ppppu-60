package 
{
	import flash.display.Sprite;
	import AppCore;
	import flash.events.Event;
	
	/**
	 * Main entryway into the program. Creates an instance of appCore, which handles running the program, and adds it as a child
	 * @author ppppuProgrammer
	 */
	//Adds a preloader instance to the first frame of the last.
	[Frame(factoryClass = "Preloader")]
	public class Main extends Sprite
	{
		//Array that holds all the mods loaded at startup by the preloader.
		private var loadedModsContent:Array = null;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			var ppppuApp:AppCore = new AppCore();
			addChild(ppppuApp);
			removeEventListener(Event.ADDED_TO_STAGE, init);
			ppppuApp.Initialize(loadedModsContent);
			loadedModsContent = null;
			
		}
		
		public function SetModsContent(mods:Array):void
		{
			loadedModsContent = mods;
		}
	}
}