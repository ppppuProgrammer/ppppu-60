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
				var lockRadioBtn:RadioButton = config.getCompById("lockBtn") as RadioButton;
				var unlockRadioBtn:RadioButton = config.getCompById("unlockBtn") as RadioButton;
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
		}
		
		public function ClickEventHandler(target:String):void
		{
			
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