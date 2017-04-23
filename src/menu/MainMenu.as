package menu 
{
	import animations.Director;
	import com.bit101.components.Panel;
	import com.bit101.components.PushButton;
	import com.bit101.components.RadioButton;
	import com.bit101.utils.MinimalConfigurator;
	import com.jacksondunstan.signals.*;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	/**
	 *
	 * @author 
	 */
	public class MainMenu extends Sprite
	{
		private var config:MinimalConfigurator;
		
		private var submenuContainer:Panel;
		
		private var characterMenu:CharacterMenu;
		private var customizationMenu:CustomizationMenu;
		private var musicMenu:MusicMenu;
		private var loadMenu:LoadMenu;
		private var animationMenu:AnimationMenu;
		private var developerMenu:DeveloperMenu;
		
		private var currentSubmenu:Sprite;
		
		//private 
		private var submenuLoadFinishedCount:int = 0;
		private var submenuCreated:int;
		
		private var buttonGroup:Vector.<PushButton> = new Vector.<PushButton>();
		private var signal1:Signal1;
		private var signal2:Signal2;
		public function MainMenu(app:AppCore, director:Director) 
		{
			name = "Main Menu";
			app.addChild(this);

			signal1 = new Signal1;
			signal1.addSlot(app);
			signal2 = new Signal2;
			
			var tabsList:Vector.<String> = Vector.<String>(["Characters", "Customization", "Music", "Load" , "Animations"]);
			CONFIG::debug
			{
				tabsList[tabsList.length] = "Development";
			}

			var WIDTH:Number = 480;
			var HEIGHT:Number = 720;

			var panel:Panel = new Panel(this);
			
			panel.name = "MainPanel";
			
			var BUTTON_HEIGHT:Number = 20;
			for (var i:int = 0, l:int = tabsList.length; i < l; i++) 
			{
				var buttonWidth:Number = (WIDTH / l);
				var x:Number = buttonWidth * i;
				var label:String = tabsList[i];
				
				var button:PushButton = new PushButton(panel, x, 0, label);
				button.toggle = true;
				button.width = buttonWidth;
				button.name = label + "Tab";
				buttonGroup[buttonGroup.length] = button;
			}
			panel.width = WIDTH; panel.height = HEIGHT;
			
			submenuContainer = new Panel(this, 0, BUTTON_HEIGHT);
			submenuContainer.name = "SubMenuPanel";
			submenuContainer.height = HEIGHT - BUTTON_HEIGHT;
			submenuContainer.width = WIDTH;
			
			this.visible = false;
 
			CONFIG::debug 
			{
				developerMenu = new DeveloperMenu();
				addChild(developerMenu);
			}
			
			animationMenu = new AnimationMenu();
			addChild(animationMenu);
			
			customizationMenu = new CustomizationMenu();
			addChild(customizationMenu);
			
			loadMenu = new LoadMenu();
			addChild(loadMenu);
			
			musicMenu = new MusicMenu();
			addChild(musicMenu);
			
			characterMenu = new CharacterMenu();
			addChild(characterMenu);
			
			addEventListener(IOErrorEvent.IO_ERROR, MenuLoadFailed, true);
			addEventListener(Event.COMPLETE, MenusReadyCheck, true);
			InitializeAllSubmenus(app, director);
			
			addEventListener(MouseEvent.CLICK, ClickEventHandler, true);
			addEventListener(Event.CHANGE, ChangeEventHandler, true);
			addEventListener(Event.SELECT, SelectEventHandler, true);
			
			
		}
		
		private function ClickEventHandler(e:MouseEvent):void
		{
			var eventTarget:Sprite = e.target as Sprite;
			if (buttonGroup.indexOf(eventTarget) > -1)
			{
				var eventButton:PushButton = eventTarget as PushButton;
				if (eventButton == null) { return;}
				
				switch(e.target.name)
				{
					case "DevelopmentTab":
						SwitchSubmenu(developerMenu);
						break;
						
					case "AnimationsTab":
						SwitchSubmenu(animationMenu);
						break;
						
					case "CustomizationTab":
						SwitchSubmenu(customizationMenu);
						break;
						
					case "MusicTab":
						SwitchSubmenu(musicMenu);
						break;
						
					case "LoadTab":
						SwitchSubmenu(loadMenu);
						break;
						
					case "CharactersTab":
						SwitchSubmenu(characterMenu);
						break;
				}
				
				for (var i:int = 0, l:int = buttonGroup.length; i < l; i++) 
				{
					if (buttonGroup[i] != eventButton)
					{
						buttonGroup[i].selected = false;
					}
				}
				
				//Make sure the target button is always selected.
				if (eventButton.selected == false)
				{
					eventButton.selected = true;
				}
				
				if (currentSubmenu != null)
				{
					submenuContainer.addChild(currentSubmenu);
				}
			}
			else
			{
				signal2.dispatch("ClickEvent", eventTarget);
				//developerMenu.ClickEventHandler(e);
			}
		}
		
		private function ChangeEventHandler(e:Event):void
		{
			signal2.dispatch("ChangeEvent", e.target);
		}
		
		private function SelectEventHandler(e:Event):void
		{
			signal2.dispatch("SelectEvent", e.target);
		}
		
		//[inline]
		private function SwitchSubmenu(submenu:Sprite):void
		{
			if (submenu != null)
			{
				if (currentSubmenu && currentSubmenu.parent != null)
				{
					currentSubmenu.parent.removeChild(currentSubmenu);
				}
				currentSubmenu = submenu;
			}
		}
		
		private function InitializeAllSubmenus(app:AppCore, director:Director):void
		{
			if (characterMenu != null) { characterMenu.InitializeMenu(app); /*signal2.addSlot(characterMenu);*/ ++submenuCreated; }
			if (musicMenu != null) { musicMenu.InitializeMenu(app); ++submenuCreated; }
			if (developerMenu != null) {developerMenu.InitializeMenu(app, director); signal2.addSlot(developerMenu); ++submenuCreated;} 
			if (animationMenu != null) {animationMenu.InitializeMenu(app); signal2.addSlot(animationMenu); ++submenuCreated;}
			if (customizationMenu != null) {customizationMenu.InitializeMenu(app, director); ++submenuCreated;}
			if (loadMenu != null) {loadMenu.InitializeMenu(app); ++submenuCreated;}
		}
		
		private function MenuLoadFailed(e:IOErrorEvent):void
		{
			++submenuLoadFinishedCount;
			var menuName:String = e.target.name;
			this.removeChild(e.target as DisplayObject);
			//Nullify the reference to the failed menu
			switch(e.target)
			{
				case characterMenu:
					characterMenu = null;
					break;
				case musicMenu: 
					musicMenu = null;
					break;
				case developerMenu: 
					developerMenu = null;
					break;
				case animationMenu: 
					animationMenu = null;
					break;
				case customizationMenu:
					customizationMenu = null;
					break;
				case loadMenu: 
					loadMenu = null;
					break;
			}
			if (submenuLoadFinishedCount >= submenuCreated)
			{
				RemoveEventListeners();
			}
		}
		
		private function MenusReadyCheck(e:Event):void
		{
			++submenuLoadFinishedCount;
			this.removeChild(e.target as DisplayObject);
			if (submenuLoadFinishedCount >= submenuCreated)
			{
				RemoveEventListeners();
			}
		}	
		
		private function RemoveEventListeners():void
		{
			removeEventListener(Event.COMPLETE, MenusReadyCheck, true);
			removeEventListener(IOErrorEvent.IO_ERROR, MenuLoadFailed, true);
			this.visible = true;
			signal1.dispatch("MenuFinishedInitializing");
		}
	}

}