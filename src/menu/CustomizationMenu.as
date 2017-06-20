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
			signal2.addSlot(app);
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
			if (director == null) { return;}
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
			var messageData:MessageData = value as MessageData;
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
			else if (command == "CustomMenu_AddActorNames")
			{
				var actorList:Vector.<String> = (value as MessageData).stringData;
				for (var i:int = 0, l:int = actorList.length; i < l; i++) 
				{
					AddNewActor(actorList[i]);
				}
			}
			else if (command == "CustomMenu_AddGraphicSetNames")
			{
				var gfxSetNameList:Vector.<String> = (value as MessageData).stringData;
				for (var i:int = 0, l:int = gfxSetNameList.length; i < l; i++) 
				{
					AddNewGraphicSet(gfxSetNameList[i]);
				}
			}
			else if (command == "AssetListDelivery")
			{
				
				//Got the asset list from the actor that was selected by the actorSelector combo box.
				var assetGuiSlider:HGUISlider = config.getCompById("assetSelectSlider") as HGUISlider;	
				
				//var assetList:Vector.<Object> = value as Vector.<Object>;
				//var assetListSprites:Vector.<Sprite> = new Vector.<Sprite>;
				if (!assetGuiSlider) { return; }
				assetGuiSlider.removeAll();
				//var items:Array = [];
				
				var previews:Vector.<Sprite> = RetrieveListOfPreviewSprites(messageData.spriteData);
				for (var y:int = 0, z:int = messageData.stringData.length; y < z; y++) 
				{

					var item:Object = { };
					item.displayImage = previews[y];
					item.displayName = messageData.stringData[y];
					//item.layer = (assetList[y] as Object).AssetLayer as int;
					assetGuiSlider.addItem(item);
				}
				if (messageData.intData.length > 0)
				{
					assetGuiSlider.value = messageData.intData[0];
					var assetText:TextArea = config.getCompById("assetInformation") as TextArea;
					if (assetGuiSlider.value == -1) {
						
						assetText.text = "Disabled";
					}
					else {
						assetText.text = assetGuiSlider.selectedItem.displayName as String;
					}
				}
				
				//var previews:Vector.<Sprite> = RetrieveListOfPreviewSprites(assetList);
				/*for (var y:int = 0, z:int = assetList.length; y < z; y++) 
				{
					
					if (assetList[y] != null)
					{
						var item:Object = { };
						item.displayImage = CreateSpritePreview((assetList[y] as Object).AssetClass);
						item.displayName = (assetList[y] as Object).AssetSet as String;
						item.layer = (assetList[y] as Object).AssetLayer as int;
						assetGuiSlider.addItem(item);
					}
				}*/
				//assetGuiSlider.selectedIndex = (assetGuiSlider.items.length > 0) ? 0 : -1;
			}
			else if (command == "AddedAssetToActorResult")
			{
				
				AddNewGraphicSet(value[1] as String);
			}
			else if (command == "CustomMenu_GetBackgroundLayerAssetsResponse")
			{
				var bgAssets:Vector.<Sprite> = messageData.spriteData;
				var assetGuiSlider:HGUISlider = config.getCompById("backgroundAssetSelectSlider") as HGUISlider;
				if (!assetGuiSlider || !bgAssets) { return; }
				assetGuiSlider.removeAll();
				
				var previews:Vector.<Sprite> = RetrieveListOfPreviewSprites(bgAssets);
				
				for (var i:int = 0,l:int = bgAssets.length; i < l; i++) 
				{
					var item:Object = { };
					item.displayImage = previews[i];
					item.displayName = bgAssets[i].name;
					assetGuiSlider.addItem(item);
				}
				assetGuiSlider.value = messageData.intData[0];
			}
			else if (command == "CustomMenu_CharacterHasChanged")
			{
				SendActorAssetListRequest();
				//var actorSelector:ComboBox = config.getCompById("actorSelector") as ComboBox;
				//actorSelector.draw();
				//actorSelector.selectedIndex = -1;
			}
			else if (command == "CustomMenu_AddedBackgroundLayers")
			{
				//var bgLayerSelector:ComboBox = config.getCompById("backgroundSelector") as ComboBox;
				//if (bgLayerSelector == null) { return; }
				//var currentSelectedIndex:int = bgLayerSelector.selectedIndex;
				SendBackgroundAssetsRequest();

			}
			
		}
		
		
		private function ClickEventHandler(target:Object):void
		{
			var targetName:String = target["name"];
			/*if (targetName == "applyAssetToActorButton")
			{				
				//var gfxSetCBox:ComboBox = config.getCompById("gfxSetSelector") as ComboBox;
				var assetSlider:HGUISlider = config.getCompById("assetSelectSlider") as HGUISlider;
				var actorCBox:ComboBox = config.getCompById("actorSelector") as ComboBox;
				//var gfxSetList:List = config.getCompById("gfxSetList") as List;
				if (assetSlider && actorCBox)
				{
					var messageData:MessageData = new MessageData;
					//Asset slider needs to have an item to select.
					if (assetSlider.selectedIndex > -1 && actorCBox.selectedIndex > -1)
					{
						messageData.stringData[0] = actorCBox.selectedItem as String;
						messageData.intData[0] = GetSelectedAssetLayerNumber();
						messageData.intData[1] = assetSlider.selectedIndex;
						signal2.dispatch("ApplyAssetToActor", messageData);
						//signal2.dispatch("ApplyAssetToActor", [actorCBox.selectedItem ,assetSlider.selectedIndex]);
					}
				}
				
				//UpdateGraphicSetsUsed();
			}
			else */if (targetName.search(/applySetToAllActorsButton|removeSetToAllActorsButton/) > -1)
			{
				var gfxSetCBox:ComboBox = config.getCompById("gfxSetSelector") as ComboBox;
				//var gfxSetList:List = config.getCompById("gfxSetList") as List;
				if (gfxSetCBox)
				{
					if (gfxSetCBox.selectedIndex != -1)
					{
						var applyingSet:Boolean = (targetName == "applySetToAllActorsButton") ? true : false;
						var messageData:MessageData = new MessageData;
						messageData.stringData[0] = gfxSetCBox.selectedItem as String;
						messageData.boolData[0] = applyingSet;
						signal2.dispatch("ApplySetToAllActors", messageData);
						//signal2.dispatch("ApplySetToAllActors", [gfxSetCBox.selectedItem, applyingSet]);
					}
				}
				
				//UpdateGraphicSetsUsed();
			}
			else if (targetName.search(/bottomLayerAssetsButton|mainLayerAssetsButton|topLayerAssetsButton/) > -1)
			{
				SendActorAssetListRequest();
			}
		}
		
		public function ChangeEventHandler(target:Object):void
		{
			if (target.name == "assetSelectSlider")
			{
				var assetText:TextArea = config.getCompById("assetInformation") as TextArea;
				var assetSlider:HGUISlider = config.getCompById("assetSelectSlider") as HGUISlider;
				var item:Object;
				if ((target as HGUISlider).selectedItem != null)
				{
					item = assetSlider.selectedItem;
				}
				
				//var gfxSetCBox:ComboBox = config.getCompById("gfxSetSelector") as ComboBox;
				/*var assetSlider:HGUISlider = config.getCompById("assetSelectSlider") as HGUISlider;
				var actorCBox:ComboBox = config.getCompById("actorSelector") as ComboBox;
				//var gfxSetList:List = config.getCompById("gfxSetList") as List;
				if (assetSlider && actorCBox)
				{
					var messageData:MessageData = new MessageData;
					//Asset slider needs to have an item to select.
					if (assetSlider.selectedIndex > -1 && actorCBox.selectedIndex > -1)
					{
						messageData.stringData[0] = actorCBox.selectedItem as String;
						messageData.intData[0] = GetSelectedAssetLayerNumber();
						messageData.intData[1] = assetSlider.selectedIndex;
						signal2.dispatch("ApplyAssetToActor", messageData);
						//signal2.dispatch("ApplyAssetToActor", [actorCBox.selectedItem ,assetSlider.selectedIndex]);
					}
				}*/
				var actorCBox:ComboBox = config.getCompById("actorSelector") as ComboBox;
				var messageData:MessageData = new MessageData;
				if (item)
				{
					assetText.text = StringUtil.substitute("Set: {0}", item.displayName);
					messageData.stringData[0] = actorCBox.selectedItem as String;
					messageData.intData[0] = GetSelectedAssetLayerNumber();
					messageData.intData[1] = assetSlider.selectedIndex;
				}
				else
				{
					assetText.text = "Disabled";
					messageData.stringData[0] = actorCBox.selectedItem as String;
					messageData.intData[0] = GetSelectedAssetLayerNumber();
					messageData.intData[1] = -1;
				}
				signal2.dispatch("ApplyAssetToActor", messageData);
				
			}
			else if (target.name == "backgroundAssetSelectSlider")
			{
				var assetText:TextArea = config.getCompById("backgroundAssetInformation") as TextArea;
				var bgLayerSelector:ComboBox = config.getCompById("backgroundSelector") as ComboBox;
				if (bgLayerSelector == null) { return; }
				
				var item:Object;
				var hguiSlider:HGUISlider = (target as HGUISlider);
				if (hguiSlider.selectedItem != null)
				{
					item = hguiSlider.selectedItem;
				}
				var messageData:MessageData = new MessageData;
				if (item)
				{
					assetText.text = StringUtil.substitute("Name: {0}", item.displayName);
					
					messageData.intData[0] = bgLayerSelector.selectedIndex;
					messageData.intData[1] = hguiSlider.selectedIndex;					
				}
				else
				{
					assetText.text = "Disabled";
					messageData.intData[0] = bgLayerSelector.selectedIndex;
					messageData.intData[1] = -1;
				}
				signal2.dispatch("CustomMenu_ChangeBackgroundAsset", messageData);
			}
			
		}
		
		public function SelectEventHandler(target:Object):void
		{
			if(target.name == "actorSelector")
			{
				SendActorAssetListRequest();		
			}
			else if (target.name == "backgroundSelector")
			{	
				SendBackgroundAssetsRequest();
				
			}
			
		}
		
		private function SendActorAssetListRequest():void
		{
			var actorName:String = (config.getCompById("actorSelector") as ComboBox).selectedItem as String;
			if (actorName && actorName.length > 0)
			{
				var messageData:MessageData = new MessageData;					
				
				messageData.stringData[0] = actorName;
				messageData.intData[0] = GetSelectedAssetLayerNumber();
				signal2.dispatch("ActorAssetListRequest", messageData);
			}
		}
		
		private function GetSelectedAssetLayerNumber():int
		{
			var bottomButton:RadioButton;
			bottomButton = (config.getCompById("bottomLayerAssetsButton") as RadioButton);
			if (bottomButton && bottomButton.selected) return 0;
			var mainButton:RadioButton;
			mainButton = (config.getCompById("mainLayerAssetsButton") as RadioButton);
			if (mainButton && mainButton.selected) return 1;
			var topButton:RadioButton;
			topButton = (config.getCompById("topLayerAssetsButton") as RadioButton);
			if (topButton && topButton.selected) return 2;
			
			return -1;
			
		}
		
		private function FinishedLoadingXML(e:Event):void
		{
			config.removeEventListener(Event.COMPLETE, FinishedLoadingXML);
			config.removeEventListener(IOErrorEvent.IO_ERROR, FailedLoadingXML);
			var backgroundSelector:ComboBox = config.getCompById("backgroundSelector") as ComboBox;
			if (backgroundSelector)
			{
				backgroundSelector.addItem("BGLayer0");
				backgroundSelector.addItem("BGLayer1");
				backgroundSelector.addItem("BGLayer2");
				backgroundSelector.addItem("BGLayer3");
				backgroundSelector.addItem("BGLayer4");
				//backgroundSelector.addItem("BG Layer 0");
				//backgroundSelector.addItem("InnerDiam");
				//backgroundSelector.addItem("InnerDiam");
				//backgroundSelector.addItem("InnerDiam");
				//backgroundSelector.addItem("InnerDiam");
			}
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
		
		private function CreateSpritePreview(spriteClass:Class):Sprite
		{
			if (!(spriteClass in assetPreviewSprites))
			{
				var previewSprite:Sprite = new spriteClass();

				assetPreviewSprites[spriteClass] = previewSprite;
				
				//the preview sprite isn't (or at least shouldn't be) subject to changes it can be cached as a bitmap for performance.
				previewSprite.cacheAsBitmap = true;
				previewSprite.mouseEnabled = previewSprite.mouseChildren = false;
				return previewSprite;
			}
			return assetPreviewSprites[spriteClass];
		}
		
		private function RetrieveListOfPreviewSprites(displayObjects:Vector.<Sprite>):Vector.<Sprite>
		{
			var previewList:Vector.<Sprite> = new Vector.<Sprite>;
			var displayObject:DisplayObject;
			for (var y:int = 0, z:int = displayObjects.length; y < z; y++) 
			{
				displayObject = displayObjects[y] as DisplayObject;
				if (displayObject != null)
				{
					var item:Object = { };
					var spriteClass:Class = (displayObject as Object).constructor as Class;					
					
					
					previewList[previewList.length] = CreateSpritePreview(spriteClass);
				}
			}
			return previewList;
		}
		
		private function SendBackgroundAssetsRequest():void 
		{
			var backgroundSelector:ComboBox = config.getCompById("backgroundSelector") as ComboBox;
			if (backgroundSelector)
			{
				var bgSelectData:MessageData = new MessageData();
				bgSelectData.intData[0] = backgroundSelector.selectedIndex;
				signal2.dispatch("CustomMenu_GetBackgroundLayerAssetsRequest", bgSelectData);
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