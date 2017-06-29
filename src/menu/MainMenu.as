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
	import flash.text.TextField;
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
		CONFIG::debug 
		{
		private var developerMenu:DeveloperMenu;
		}
		private var creditsMenu:CreditsMenu;
		private var currentSubmenu:Sprite;
		
		//private 
		private var submenuLoadFinishedCount:int = 0;
		private var submenuCreated:int;
		private var creatingSubmenus:Boolean = false;
		
		private var buttonGroup:Vector.<PushButton> = new Vector.<PushButton>();
		private var signal1:Signal1;
		private var signal2:Signal2;
		public function MainMenu() 
		{
			name = "Main Menu";
			
			
			var tabsList:Vector.<String> = Vector.<String>(["Characters", "Customization", "Animations", "Music", "Load", "Credits"]);
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
				//These menus are NYI so don't allow their buttons to be enabled.
				/*if (tabsList[i].search(/Load/) > -1)
				{
					button.enabled = false;
				}*/
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
			
			addEventListener(IOErrorEvent.IO_ERROR, MenuLoadFailed, true);
			addEventListener(Event.COMPLETE, MenusReadyCheck, true);
			
			
			addEventListener(MouseEvent.CLICK, ClickEventHandler);
			addEventListener(Event.CHANGE, ChangeEventHandler, true);
			addEventListener(Event.SELECT, SelectEventHandler, true);
			
			
		}
		
		public function InitializeMainMenu(app:AppCore, director:Director):void
		{
			app.addChild(this);

			signal1 = new Signal1;
			signal1.addSlot(app);
			signal2 = new Signal2;
			CreateSubmenus(app, director);
			
		}
		
		
		private function CreateSubmenus(app:AppCore, director:Director):void
		{
			creatingSubmenus = true;
			CONFIG::debug 
			{
				developerMenu = CreateSubmenu(DeveloperMenu) as DeveloperMenu;
				addChild(developerMenu);
			}
			
			animationMenu = CreateSubmenu(AnimationMenu) as AnimationMenu;
			addChild(animationMenu);
			
			customizationMenu = CreateSubmenu(CustomizationMenu) as CustomizationMenu;
			addChild(customizationMenu);
			
			loadMenu = CreateSubmenu(LoadMenu) as LoadMenu;
			addChild(loadMenu);
			
			musicMenu = CreateSubmenu(MusicMenu) as MusicMenu;
			addChild(musicMenu);
			
			characterMenu = CreateSubmenu(CharacterMenu) as CharacterMenu;
			addChild(characterMenu);
			
			creditsMenu = CreateSubmenu(CreditsMenu) as CreditsMenu;
			addChild(creditsMenu);
			
			InitializeAllSubmenus(app, director);
		}
		
		private function ClickEventHandler(e:MouseEvent):void
		{
			var eventTarget:Object = e.target as Object;
			if (eventTarget is TextField && (eventTarget as TextField).selectable == true)
			{
				stage.focus = eventTarget as TextField;
			}
			else
			{
				stage.focus = null;
			}
			if (buttonGroup.indexOf(eventTarget as PushButton) > -1)
			{
				var eventButton:PushButton = eventTarget as PushButton;
				if (eventButton == null) { return;}
				
				switch(e.target.name)
				{
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
						
					case "DevelopmentTab":
						CONFIG::debug
						{
						SwitchSubmenu(developerMenu);
						}
						break;
					case "CreditsTab":
						SwitchSubmenu(creditsMenu);
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
				submenuContainer.addChild(currentSubmenu);
			}
		}
		
		private function InitializeAllSubmenus(app:AppCore, director:Director):void
		{
			if (characterMenu != null) { characterMenu.InitializeMenu(app); RegisterSubmenu(characterMenu); }
			if (musicMenu != null) { musicMenu.InitializeMenu(app); RegisterSubmenu(musicMenu); }
			CONFIG::debug 
			{
			if (developerMenu != null) { developerMenu.InitializeMenu(app); developerMenu.RegisterDirectorForMessages(director); RegisterSubmenu(developerMenu); } 
			}
			if (animationMenu != null) {animationMenu.InitializeMenu(app); RegisterSubmenu(animationMenu);}
			if (customizationMenu != null) { customizationMenu.InitializeMenu(app); customizationMenu.RegisterDirectorForMessages(director); RegisterSubmenu(customizationMenu); }
			if (loadMenu != null) { loadMenu.InitializeMenu(app); RegisterSubmenu(loadMenu); }
			if (creditsMenu != null) {creditsMenu.InitializeMenu(app);}	
		}
		
		[inline]
		private function RegisterSubmenu(menu:Slot2):void
		{
			signal2.addSlot(menu);
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

				case animationMenu: 
					animationMenu = null;
					break;
				case customizationMenu:
					customizationMenu = null;
					break;
				case loadMenu: 
					loadMenu = null;
					break;
					
				case creditsMenu: 
					creditsMenu = null;
					break;
					
				
			}
			CONFIG::debug
			{
				if(e.target == developerMenu){
					developerMenu = null;}
			}
			
			if (submenuLoadFinishedCount >= submenuCreated)
			{
				RemoveEventListeners(false);
			}
		}
		
		private function MenusReadyCheck(e:Event):void
		{
			++submenuLoadFinishedCount;
			this.removeChild(e.target as DisplayObject);
			if (submenuLoadFinishedCount >= submenuCreated)
			{
				RemoveEventListeners(false);
			}
		}	
		
		private function RemoveEventListeners(reloadVersion:Boolean):void
		{
			this.visible = true;
			creatingSubmenus = false;			
			
			if (reloadVersion)
			{
				CONFIG::debug
				{
					removeEventListener(Event.COMPLETE, MenusReloadReadyCheck, true);
					removeEventListener(IOErrorEvent.IO_ERROR, MenuReloadFailed, true);
					SwitchSubmenu(currentSubmenu);
					signal1.dispatch("MainMenu_MenuReloadFinished");
				}
			}
			else
			{
				removeEventListener(Event.COMPLETE, MenusReadyCheck, true);
				removeEventListener(IOErrorEvent.IO_ERROR, MenuLoadFailed, true);
				signal1.dispatch("MenuFinishedInitializing");
			}
		}
		
		private function CreateSubmenu(menuClass:Class):ISubMenu
		{
			submenuCreated++;
			var submenu:ISubMenu = new menuClass() as ISubMenu;
			if (!submenu)
			{
				--submenuCreated;
			}
			return submenu;
		}
		
		//Menu reloading related functions. Only available in debug mode.
		CONFIG::debug {
			public function ReloadSubMenus(app:AppCore):void
			{
				if (creatingSubmenus) { return; }
				ResetSubMenus();
				addEventListener(IOErrorEvent.IO_ERROR, MenuReloadFailed, true);
				addEventListener(Event.COMPLETE, MenusReloadReadyCheck, true);
				InitializeAllSubmenus(app, null);
			}
			
			private function ResetSubMenus():void
			{
				submenuLoadFinishedCount = 0;
				ResetSubMenu(characterMenu);
				ResetSubMenu(customizationMenu);
				ResetSubMenu(musicMenu);
				ResetSubMenu(loadMenu);
				ResetSubMenu(animationMenu);
				ResetSubMenu(developerMenu);
				ResetSubMenu(creditsMenu);
			}
			
			private function ResetSubMenu(submenu:ISubMenu):void
			{
				if (submenu)
				{
					submenu.Reset();
					//Need submenu to be on the display list for events
					addChild(submenu as DisplayObject);
				}
			}	
			
			private function MenuReloadFailed(e:IOErrorEvent):void
			{
				++submenuLoadFinishedCount;
				DidSubmenuReloadSuccessfully(e.target as ISubMenu, false);
				removeChild(e.target as DisplayObject);
				if (submenuLoadFinishedCount >= submenuCreated)	{
					RemoveEventListeners(true);
				}
			}
			
			private function DidSubmenuReloadSuccessfully(submenu:ISubMenu, success:Boolean):void
			{
				switch(submenu)
				{
					case characterMenu:
						buttonGroup[0].enabled = success;					
						break;
					case musicMenu: 
						buttonGroup[1].enabled = success;	
						break;
					case animationMenu: 
						buttonGroup[2].enabled = success;	
						break;
					case customizationMenu:
						buttonGroup[3].enabled = success;	
						break;
					case loadMenu: 
						buttonGroup[4].enabled = success;	
						break;
					case creditsMenu:
						buttonGroup[5].enabled = success;	
						break;	
					case developerMenu:
						buttonGroup[6].enabled = success;	
						break;	
					
				}
			}
			
			private function MenusReloadReadyCheck(e:Event):void
			{
				++submenuLoadFinishedCount;
				var subMenu:DisplayObject = (e.target as DisplayObject);
				DidSubmenuReloadSuccessfully(subMenu as ISubMenu, true);
				if (subMenu.parent != null){
					subMenu.parent.removeChild(subMenu);
				}
				if (submenuLoadFinishedCount >= submenuCreated)
				{
					RemoveEventListeners(true);
				}
			}
			
			//private function RemoveReloadEventListeners():void
			//{
				//removeEventListener(Event.COMPLETE, MenusReloadReadyCheck, true);
				//removeEventListener(IOErrorEvent.IO_ERROR, MenuReloadFailed, true);
				//this.visible = true;
				//creatingSubmenus = false;
				//SwitchSubmenu(currentSubmenu);
				//signal1.dispatch("MainMenu_MenuReloadFinished");
			//}
		}
	}

}