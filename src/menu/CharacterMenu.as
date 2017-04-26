package menu 
{
	import com.bit101.components.List;
	import com.bit101.components.RadioButton;
	import com.bit101.components.TextArea;
	import com.jacksondunstan.signals.Slot2;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.bit101.utils.MinimalConfigurator;
	import flash.errors.IOError;
	import flash.events.IOErrorEvent;
	import com.jacksondunstan.signals.Signal2;

	/**
	 * ...
	 * @author 
	 */
	public class CharacterMenu extends Sprite implements Slot2
	{
		private var config:MinimalConfigurator;
		private var signal2:Signal2;
		public function CharacterMenu() 
		{
			name = "Character Menu";
			signal2 = new Signal2;
		}
		
		public function InitializeMenu(app:AppCore):void
		{
			config = new MinimalConfigurator(this);
			config.addEventListener(Event.COMPLETE, FinishedLoadingXML);
			config.addEventListener(IOErrorEvent.IO_ERROR, FailedLoadingXML);
			config.loadXML("CharacterMenuDefinition.xml");
			app.SetupMenuHooks(null, this);
			signal2.addSlot(app);
		}
		
		private function FinishedLoadingXML(e:Event):void
		{
			config.removeEventListener(Event.COMPLETE, FinishedLoadingXML);
			config.removeEventListener(IOErrorEvent.IO_ERROR, FailedLoadingXML);
			dispatchEvent(e);
			
			var charList:List = config.getCompById("charSelectList") as List;
			if (charList)
			{
				charList.listItemClass = HorizontalListItem;
			}
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
		
		public function onSignal2(targetName:*, value:*):void
		{
			var command:String = targetName as String;
			if (command == "ClickEvent")
			{
				if (!value) { return;}
				var compName:String = (value as Sprite).name;
				if (config.getCompById(compName) != null)
				{
					ClickEventHandler(compName);
				}
			}
			else if (command == "ChangeEvent")
			{
				if (!value) { return;}
				var compName:String = (value as Sprite).name;
				if (config.getCompById(compName) != null)
				{
					ChangeEventHandler(value as Object);
				}
			}
			else if (command == "SelectEvent")
			{
				if (!value) { return;}
				var compName:String = (value as Sprite).name;
				if (config.getCompById(compName) != null)
				{
					SelectEventHandler(value as Object);
				}
			}
			else if (command == "AddNewCharacter")
			{
				var charList:List = config.getCompById("charSelectList") as List;
				charList.addItem(value as String);
			}
			else if (command == "CharMenu_CharacterInfoDelivery")
			{
				var charInfo:Array = value as Array;
				var charNameTextArea:TextArea = config.getCompById("selectedCharText") as TextArea;
				var musicNameTextArea:TextArea = config.getCompById("charMusicText") as TextArea;
				var lockRadioBtn:RadioButton = config.getCompById("lockRBtn") as RadioButton;
				var unlockRadioBtn:RadioButton = config.getCompById("unlockRBtn") as RadioButton;
				if (charInfo)
				{
					charNameTextArea.text = charInfo[0] as String;
					musicNameTextArea.text = charInfo[1] as String;
					if ((charInfo[2] as Boolean) == true)
					{
						lockRadioBtn.selected = true;
					}
					else
					{
						unlockRadioBtn.selected = true;
					}
				}
				else
				{
					charNameTextArea.text = "No Character Selected";
					musicNameTextArea.text = "Not Available";
					lockRadioBtn.selected = unlockRadioBtn.selected = false;
				}
			}
			else if (command == "CharMenu_CharacterHasChanged")
			{
				var charList:List = config.getCompById("charSelectList") as List;
				if (charList)
				{
					charList.selectedIndex = value as int;
				}
			}
			else if (command == "CharMenu_UpdateSwitchMode")
			{
				var mode:int = value as int;
				var modeRadioButton:RadioButton;
				switch(mode)
				{
					case 0:
						modeRadioButton = config.getCompById("SequentialCharRBtn") as RadioButton;
						break;
					case 1:
						modeRadioButton = config.getCompById("RandomCharRBtn") as RadioButton;
						break;
					case 2:
						modeRadioButton = config.getCompById("OneCharRBtn") as RadioButton;
						break;
				}
				if (modeRadioButton)
				{
					modeRadioButton.selected = true;
				}
			}
			else if (command == "CharMenu_CharacterWasDeleted")
			{
				var wasReallyDeleted:Boolean = value as Boolean;
				var charList:List = config.getCompById("charSelectList") as List;
				if (wasReallyDeleted)
				{
					
					charList.removeItemAt(charList.selectedIndex);
					//signal2.dispatch("CharMenu_SwitchCharacterRequest", null);
					//charList.selectedIndex = -1;
				}
				else
				{
					//"Switch" characters to update various data
					signal2.dispatch("CharMenu_SwitchCharacterRequest", charList.selectedItem);
				}
			}
		}
		
		public function ClickEventHandler(target:String):void
		{
			if (target == "SequentialCharRBtn" || "RandomCharRBtn" || "OneCharRBtn")
			{
				//var mode:int = value as int;
				//var modeRadioButton:RadioButton;
				switch(target)
				{
					case "SequentialCharRBtn":
						//modeRadioButton = config.getCompById("SequentialCharRBtn") as RadioButton;
						signal2.dispatch("CharMenu_ChangeSwitchModeRequest", 0);
						break;
					case "RandomCharRBtn":
						//modeRadioButton = config.getCompById("RandomCharRBtn") as RadioButton;
						signal2.dispatch("CharMenu_ChangeSwitchModeRequest", 1);
						break;
					case "OneCharRBtn":
						//modeRadioButton = config.getCompById("OneCharRBtn") as RadioButton;
						signal2.dispatch("CharMenu_ChangeSwitchModeRequest", 2);
						break;
				}
			}
			else if (target == "lockRBtn" || "unlockRBtn")
			{
				
				switch(target)
				{
					case "lockRBtn":
						//modeRadioButton = config.getCompById("SequentialCharRBtn") as RadioButton;
						signal2.dispatch("CharMenu_ChangeCharacterLockRequest", true);
						break;
					case "unlockRBtn":
						//modeRadioButton = config.getCompById("RandomCharRBtn") as RadioButton;
						signal2.dispatch("CharMenu_ChangeCharacterLockRequest", false);
						break;
				}
			}
			else if (target == "deleteCharButton")
			{
				var charList:List = config.getCompById("charSelectList") as List;
				if (charList.selectedItem > -1)
				{
					signal2.dispatch("CharMenu_DeleteCharacterRequest", false);
				}
			}
		}
		public function ChangeEventHandler(target:Object):void
		{
			
		}
		public function SelectEventHandler(target:Object):void
		{
			if (target.name == "charSelectList")
			{
				var charList:List = target as List;
				var charName:String = charList.selectedItem as String;
				signal2.dispatch("CharMenu_SwitchCharacterRequest", charName);
			}
		}
		
		
	}

}