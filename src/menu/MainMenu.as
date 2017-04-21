package menu 
{
	import com.bit101.components.Panel;
	import com.bit101.components.PushButton;
	import com.bit101.utils.MinimalConfigurator;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 *
	 * @author 
	 */
	public class MainMenu extends Sprite 
	{
		private var config:MinimalConfigurator;
		
		private var submenuContainer:Panel;
		
		private var characterMenu:Sprite;
		private var graphicsMenu:Sprite;
		private var musicMenu:Sprite;
		private var loadMenu:Sprite;
		private var animationMenu:Sprite;
		private var developerMenu:Sprite;
		public function MainMenu(app:AppCore) 
		{
			var tabsList:Vector.<String> = Vector.<String>(["Characters", "Customization", "Music", "Load" , "Animations"]);
			CONFIG::debug
			{
				tabsList[tabsList.length] = "Development";
			}
			//var SPACE_AWAY_FROM_EDGE:Number = 10;
			var WIDTH:Number = 480;
			var HEIGHT:Number = 720;
			//this.width = WIDTH;
			//this.height = 720;
			var panel:Panel = new Panel(this);
			
			panel.name = "MainPanel";
			
			var BUTTON_HEIGHT:Number = 20;
			for (var i:int = 0, l:int = tabsList.length; i < l; i++) 
			{
				var buttonWidth:Number = (WIDTH / l);
				var x:Number = buttonWidth * i;
				var label:String = tabsList[i];
				
				var button:PushButton = new PushButton(panel, x, 0, label);
				button.width = buttonWidth;
				button.name = label + "Tab";
			}
			panel.width = WIDTH; panel.height = HEIGHT;
			
			submenuContainer = new Panel(this, 0, BUTTON_HEIGHT);
			submenuContainer.height = HEIGHT - BUTTON_HEIGHT;
			submenuContainer.width = WIDTH;
			/*config = new MinimalConfigurator(this);
			config.addEventListener(Event.COMPLETE, FinishedLoadingXML);
			config.loadXML("MainMenuDefinition.xml");*/
		}
		
		/*public function FinishedLoadingXML(e:Event):void
		{
			config.removeEventListener(Event.COMPLETE, FinishedLoadingXML);
		}*/
		
	}

}