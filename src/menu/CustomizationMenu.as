package menu 
{
	import animations.Director;
	import com.bit101.components.Panel;
	import com.bit101.components.PushButton;
	import com.bit101.utils.MinimalConfigurator;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.errors.IOError;
	import flash.events.IOErrorEvent;
	import com.jacksondunstan.signals.Signal2;
	import com.jacksondunstan.signals.Slot2;
	/**
	 *
	 * @author 
	 */
	public class CustomizationMenu extends Sprite  implements Slot2
	{
		private var config:MinimalConfigurator;
		private var signal2:Signal2;
		
		public function CustomizationMenu(/*app:AppCore, director:Director*/) 
		{
			name = "Customization Menu";
			signal2 = new Signal2;
			/*config = new MinimalConfigurator(this);
			config.addEventListener(Event.COMPLETE, FinishedLoadingXML);
			config.loadXML("MainMenuDefinition.xml");*/
		}
				
		public function InitializeMenu(app:AppCore, director:Director):void
		{
			config = new MinimalConfigurator(this);
			app.SetupMenuHooks(null, this);
			director.RegisterMenuForMessaging(this);
			config.addEventListener(Event.COMPLETE, FinishedLoadingXML);
			config.addEventListener(IOErrorEvent.IO_ERROR, FailedLoadingXML);
			config.loadXML("CustomMenuDefinition.xml");
		}
		
		public function onSignal2(targetName:*, value:*):void
		{
			
		}
		
		private function FinishedLoadingXML(e:Event):void
		{
			config.removeEventListener(Event.COMPLETE, FinishedLoadingXML);
			config.removeEventListener(IOErrorEvent.IO_ERROR, FailedLoadingXML);
			dispatchEvent(e);
		}
		
		private function FailedLoadingXML(e:IOErrorEvent):void
		{
			config.removeEventListener(Event.COMPLETE, FinishedLoadingXML);
			config.removeEventListener(IOErrorEvent.IO_ERROR, FailedLoadingXML);
			signal2.removeAllSlots();
			signal2 = null;
			config = null;
			dispatchEvent(e);
		}
		
	}

}