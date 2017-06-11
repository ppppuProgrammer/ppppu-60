package menu 
{
	import com.bit101.components.ComboBox;
	import com.bit101.components.HUISlider;
	import com.jacksondunstan.signals.Signal2;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.bit101.utils.MinimalConfigurator;
	import flash.errors.IOError;
	import flash.events.IOErrorEvent;
	import com.jacksondunstan.signals.Slot2;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author 
	 */
	public class MusicMenu extends Sprite implements Slot2, ISubMenu
	{
		private var config:MinimalConfigurator;
		private var signal2:Signal2;
		
		CONFIG::release {
			[Embed(source="MusicMenuDefinition.xml",mimeType="application/octet-stream")]
			private var menuDefinitionClass:Class;
		}
		
		public function MusicMenu() 
		{
			name = "Music Menu";
			signal2 = new Signal2;
		}
		
		public function InitializeMenu(app:AppCore):void
		{
			config = new MinimalConfigurator(this);
			config.addEventListener(Event.COMPLETE, FinishedLoadingXML);
			config.addEventListener(IOErrorEvent.IO_ERROR, FailedLoadingXML);

			app.SetupMenuHooks(null, this);
			signal2.addSlot(app);
			
			CONFIG::debug {
				config.loadXML("../src/menu/MusicMenuDefinition.xml");
			}
			
			CONFIG::release
			{
				var xmlByteArray:ByteArray = new menuDefinitionClass() as ByteArray;
				config.parseXMLString(xmlByteArray.readUTFBytes(xmlByteArray.length));
			}

		}
		
		public function onSignal2(targetName:*, value:*):void
		{
			var command:String = targetName as String;
			if (command == "ClickEvent")
			{
				if (!value) { return;}
				var compName:String = (value as Object)["name"];
				if (config.getCompById(compName) != null)
				{
					ClickEventHandler(value as Object);
				}
			}
			else if (command == "ChangeEvent")
			{
				if (!value) { return;}
				var compName:String = (value as Object)["name"];
				if (config.getCompById(compName) != null)
				{
					ChangeEventHandler(value as Object);
				}
			}
			else if (command == "SelectEvent")
			{
				if (!value) { return;}
				var compName:String = (value as Object)["name"];
				if (config.getCompById(compName) != null)
				{
					SelectEventHandler(value as Object);
				}
			}
			else if (command == "MusicMenu_AddMusicToSelectionList")
			{
				AddMusicNameToDropList(value as String);
			}
			else if (command == "MusicMenu_ChangeSelectedMusicResult")
			{
				var musicSelectDroplist:ComboBox = config.getCompById("musicSelectDroplist") as ComboBox;
				if (musicSelectDroplist)
				{
					musicSelectDroplist.selectedIndex = value as int;
				}
			}
			else if (command == "MusicMenu_ListOfMusicToAdd")
			{
				var musicList:MessageData = value as MessageData;
				for (var i:int = 0, l:int = musicList.stringData.length; i < l; i++) 
				{
					AddMusicNameToDropList(musicList.stringData[i]);
				}
			}
		}
		
		public function ClickEventHandler(target:Object):void
		{
			//var targetName:String = target["name"];
			if (target.name == "testMusicLoopButton")
			{
				var musicSelectDroplist:ComboBox = config.getCompById("musicSelectDroplist") as ComboBox;
				if (musicSelectDroplist)
				{
					signal2.dispatch("MusicMenu_TestMusicLoopPoint", musicSelectDroplist.selectedIndex);
				}
			}
			else if (target.name == "previewMusicButton")
			{
				var musicSelectDroplist:ComboBox = config.getCompById("musicSelectDroplist") as ComboBox;
				if (musicSelectDroplist)
				{
					signal2.dispatch("MusicMenu_PreviewMusic", musicSelectDroplist.selectedIndex);
				}
			}

		}
		
		public function ChangeEventHandler(target:Object):void
		{
			//var targetName:String = target["name"];
			if (target.name == "musicVolumeSlider")
			{
				var musicSlider:HUISlider = target as HUISlider;
				signal2.dispatch("MusicMenu_ChangeMusicVolumeRequest", musicSlider.value/100.0);
			}
		}
		public function SelectEventHandler(target:Object):void
		{
			if (target.name == "musicSelectDroplist")
			{
				var musicSelectDroplist:ComboBox = target as ComboBox;
				signal2.dispatch("MusicMenu_ChangeSelectedMusicRequest", musicSelectDroplist.selectedItem);
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
		
		
		private function FinishedLoadingXML(e:Event):void
		{
			config.removeEventListener(Event.COMPLETE, FinishedLoadingXML);
			config.removeEventListener(IOErrorEvent.IO_ERROR, FailedLoadingXML);
			dispatchEvent(e);
		}
		
		[inline]
		private function AddMusicNameToDropList(musicName:String):void
		{
			var musicSelectDroplist:ComboBox = config.getCompById("musicSelectDroplist") as ComboBox;
			if (musicSelectDroplist){
				musicSelectDroplist.addItem(musicName);
			}	
		}
		
		CONFIG::debug
		{
		//Used when the reload menu button is pressed, allows the menu to clean up before it's removed and garbage collected.
		public function Reset():void
		{
			this.removeChildren();
			config = null;
		}
		}
	}

}