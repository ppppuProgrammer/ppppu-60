package menu 
{
	import animations.Director;
	import com.bit101.components.*;
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
	import mx.utils.StringUtil;
	import flash.utils.Dictionary;
	import flash.utils.ByteArray;
	/**
	 *
	 * @author 
	 */
	public class CustomizationMenu extends Sprite  implements Slot2, ISubMenu
	{
		private var config:MinimalConfigurator;
		private var signal2:Signal2;
		
		private var assetPreviewSprites:Dictionary = new Dictionary();
		
		CONFIG::release {
			[Embed(source="CustomMenuDefinition.xml",mimeType="application/octet-stream")]
			private var menuDefinitionClass:Class;
		}
		
		public function CustomizationMenu(/*app:AppCore, director:Director*/) 
		{
			name = "Customization Menu";
			signal2 = new Signal2;
			/*config = new MinimalConfigurator(this);
			config.addEventListener(Event.COMPLETE, FinishedLoadingXML);
			config.loadXML("MainMenuDefinition.xml");*/
		}
				
		public function InitializeMenu(app:AppCore):void
		{
			config = new MinimalConfigurator(this);
			app.SetupMenuHooks(null, this);
			config.addEventListener(Event.COMPLETE, FinishedLoadingXML);
			config.addEventListener(IOErrorEvent.IO_ERROR, FailedLoadingXML);
			CONFIG::debug {
				config.loadXML("../src/menu/CustomMenuDefinition.xml");
			}
			
			CONFIG::release
			{
				var xmlByteArray:ByteArray = new menuDefinitionClass() as ByteArray;
				config.parseXMLString(xmlByteArray.readUTFBytes(xmlByteArray.length));
			}
		}
		
		public function RegisterDirectorForMessages(director:Director):void
		{
			//Allow the director and menu to communicate with each other
			signal2.addSlot(director);
			director.RegisterMenuForMessaging(this);
		}
		
		private function UpdateGraphicSetsUsed():void
		{
			var gfxSetList:List = config.getCompById("gfxSetList") as List;
			if (gfxSetList)
			{
				var gfxSetNames:Vector.<String> = new Vector.<String>();
				for (var i:int = 0, l:int = gfxSetList.items.length; i < l; i++) 
				{
					gfxSetNames[gfxSetNames.length] = gfxSetList.items[i];
				}
				signal2.dispatch("UpdateGraphicSetsUsed", gfxSetNames);
			}
		}
		
		[inline]
		private function AddNewActor(name:String):void
		{
			var cbox:ComboBox = config.getCompById("actorSelector") as ComboBox;
			if (cbox)
			{
				cbox.addItem(name);
				cbox.items.sort();
			}
		}
		
		public function AddNewGraphicSet(name:String):void
		{
			var cbox:ComboBox = config.getCompById("gfxSetSelector") as ComboBox;
			if (cbox && cbox.items.indexOf(name) == -1)
			{
				cbox.addItem(name);
				cbox.items.sort();
			}
		}
		
		public function onSignal2(targetName:*, value:*):void
		{
			var command:String = targetName as String;
			if (command == "ClickEvent")
			{
				var compName:String = (value as Object)["name"];
				if (config.getCompById(compName) != null)
				{
					ClickEventHandler(value as Object);
				}
			}
			else if (command == "ChangeEvent")
			{
				var compName:String = (value as Object)["name"];
				if (config.getCompById(compName) != null)
				{
					ChangeEventHandler(value as Object);
				}
			}
			else if (command == "SelectEvent")
			{
				var compName:String = (value as Object)["name"];
				if (config.getCompById(compName) != null)
				{
					SelectEventHandler(value as Object);
				}
			}
			else if (command == "NewActorRegistered") //Add shards that were referred in an animation list
			{
				var actorName:String = value as String;
				if (actorName)
				{
					AddNewActor(actorName);
				}
			}
			else if (command == "AssetListDelivery")
			{
				
				//Got the asset list from the actor that was selected by the actorSelector combo box.
				var assetGuiSlider:HGUISlider = config.getCompById("assetSelectSlider") as HGUISlider;	
				
				var assetList:Vector.<Object> = value as Vector.<Object>;
				if (!assetGuiSlider || !assetList) { return; }
				assetGuiSlider.removeAll();
				var items:Array = [];
				
				for (var y:int = 0, z:int = assetList.length; y < z; y++) 
				{
					if (assetList[y] != null)
					{
						var item:Object = { };
						var spriteClass:Class = (assetList[y] as Object).AssetClass as Class;
						if (!(spriteClass in assetPreviewSprites))
						{
							var previewSprite:Sprite = new spriteClass();

							assetPreviewSprites[spriteClass] = previewSprite;
							
							//the preview sprite isn't (or at least shouldn't be) subject to changes it can be cached as a bitmap for performance.
							previewSprite.cacheAsBitmap = true;
							previewSprite.mouseEnabled = previewSprite.mouseChildren = false;
						}
						item.displayImage = assetPreviewSprites[spriteClass];
						item.displayName = (assetList[y] as Object).AssetSet as String;
						item.layer = (assetList[y] as Object).AssetLayer as int;
						assetGuiSlider.addItem(item);
					}
				}
				assetGuiSlider.selectedIndex = (assetGuiSlider.items.length > 0) ? 0 : -1;
			}
			else if (command == "AddedAssetToActorResult")
			{
				
				AddNewGraphicSet(value[1] as String);
			}
			
		}
		
		
		private function ClickEventHandler(target:Object):void
		{
			var targetName:String = target["name"];
			if (targetName == "applyAssetToActorButton")
			{
				//var gfxSetCBox:ComboBox = config.getCompById("gfxSetSelector") as ComboBox;
				var assetSlider:HGUISlider = config.getCompById("assetSelectSlider") as HGUISlider;
				var actorCBox:ComboBox = config.getCompById("actorSelector") as ComboBox;
				//var gfxSetList:List = config.getCompById("gfxSetList") as List;
				if (assetSlider && actorCBox)
				{
					//Asset slider needs to have an item to select.
					if (assetSlider.selectedIndex > -1 && actorCBox.selectedIndex > -1)
					{
						signal2.dispatch("ApplyAssetToActor", [actorCBox.selectedItem ,assetSlider.selectedIndex]);
					}
				}
				
				//UpdateGraphicSetsUsed();
			}
			else if (targetName.search(/applySetToAllActorsButton|removeSetToAllActorsButton/) > -1)
			{
				var gfxSetCBox:ComboBox = config.getCompById("gfxSetSelector") as ComboBox;
				//var gfxSetList:List = config.getCompById("gfxSetList") as List;
				if (gfxSetCBox)
				{
					if (gfxSetCBox.selectedIndex != -1)
					{
						var applyingSet:Boolean = (targetName == "applySetToAllActorsButton") ? true : false;
						signal2.dispatch("ApplySetToAllActors", [gfxSetCBox.selectedItem, applyingSet]);
					}
				}
				
				//UpdateGraphicSetsUsed();
			}
		}
		
		public function ChangeEventHandler(target:Object):void
		{
			if (target.name == "assetSelectSlider")
			{
				var assetText:TextArea = config.getCompById("assetInformation") as TextArea;
				
				var item:Object;
				if ((target as HGUISlider).selectedItem != null)
				{
					item = (target as HGUISlider).selectedItem;
				}
				if (item)
				{
					var layerText:String;
					switch(item.layer)
					{
						case 0:
							layerText = "Bottom";
							break;
						case 1:
							layerText = "Main";
							break;
						case 2:
							layerText = "Top";
							break;
						default:
							layerText = "Invalid";
					}
					assetText.text = StringUtil.substitute("Set: {0}\nLayer: {1}", item.displayName, layerText);
				}
				else
				{
					assetText.text = "Information unavailable";
				}
				
			}
			
		}
		
		public function SelectEventHandler(target:Object):void
		{
			if(target.name == "actorSelector")
			{
				
				var actorName:String = (config.getCompById("actorSelector") as ComboBox).selectedItem as String;
				if (actorName && actorName.length > 0)
				{
					signal2.dispatch("ActorAssetListRequest", actorName);
				}			
			}
			
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