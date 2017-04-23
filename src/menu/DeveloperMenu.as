package menu
{
	import adobe.utils.CustomActions;
	import com.greensock.motionPaths.RectanglePath2D;
	import flash.errors.IOError;
	import flash.geom.Point;
	
	//import animations.AnimateShard;
	
	import animations.Director;
	import com.bit101.components.*;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.bit101.utils.MinimalConfigurator;
	import com.jacksondunstan.signals.*;
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import mx.utils.StringUtil;
	import org.libspark.betweenas3.core.tweens.AbstractTween;
	import org.libspark.betweenas3.core.tweens.ObjectTween;
	import org.libspark.betweenas3.core.tweens.groups.SerialTween;
	import org.libspark.betweenas3.tweens.ITween;
	
	import flash.errors.IOError;
	import flash.events.IOErrorEvent;
	import AppCore;

	//[SWF(backgroundColor=0xeeeeee, width=480, height=720)]
	public class DeveloperMenu extends Sprite implements /*Slot1,*/Slot2
	{
		/*private var animProgressSlider:HUISlider;
		private var animationLabel:Label;
		private var animDropListPH:ComboBox;
		private var frameLabel:Label;
		private var frameText:Label;
		private var animPlayButton:PushButton;
		private var setFrameButton:PushButton;
		private var frameSlider:HUISlider;
		private var bodyLabel:Label;
		private var bodyDropListPH:ComboBox;
		private var charLabel:Label;
		private var charDropListPH:ComboBox;
		private var frameForwardButton:PushButton;
		private var frameBackButton:PushButton;
		private var frameSettingLabel:Label;*/
		
		
		
		private var signal1:Signal1 = new Signal1();
		private var signal2:Signal2 = new Signal2();
		private var config:MinimalConfigurator;
		private var waitingForComponentsCreation:Boolean = true;
		
		
		
		//var currentTimelineSet:Vector.<SerialTween>;
		private var serialTweenDict:Dictionary = new Dictionary();
		private var assetPreviewSprites:Dictionary = new Dictionary();
		public function DeveloperMenu(/*app:AppCore, director:Director*/) 
		{			
			name = "Developer Menu";	
			
			//addEventListener(MouseEvent.CLICK, ClickEventHandler, true);
			//addEventListener(Event.CHANGE, ChangeEventHandler, true);
			//addEventListener(Event.SELECT, SelectEventHandler, true);
		}
		
		public function InitializeMenu(app:AppCore, director:Director):void
		{
			config = new MinimalConfigurator(this);
			config.addEventListener(Event.COMPLETE, FinishedLoadingXML);
			
			signal1.addSlot(app);
			signal2.addSlot(app);
			
			//Allow the director and dev menu to communicate with each other
			signal2.addSlot(director);
			director.RegisterMenuForMessaging(this);
			config.loadXML("DevMenuDefinition.xml");
		}

		public function ReadyCheck():Boolean
		{
			return !waitingForComponentsCreation;
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
		
		/*public function SetupHooksToApp(app:AppCore):void
		{
			signal1.addSlot(app);
			addEventListener(MouseEvent.CLICK, ClickEventHandler, true);
			
			
			signal2.addSlot(app);
			addEventListener(Event.SELECT, SelectEventHandler, true);
			
			addEventListener(Event.CHANGE, ChangeEventHandler, true);
		}*/
		
		public function ClickEventHandler(targetName:String/*e:MouseEvent*/):void
		{
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
			else if (targetName == "applySetToAllActorsButton" || targetName =="removeSetToAllActorsButton")
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
			else if (targetName != "setFrameButton" /*&& (config.getCompById("elementSelector") as ComboBox).selectedIndex > -1*/)
			{
				signal1.dispatch(targetName);
			}		
			else
			{
				//setFrameButton needs to also send data on what frame to go to.
				signal2.dispatch(targetName, int((config.getCompById("frameSlider") as HUISlider).value));
			}
			
		}
		
		public function ChangeEventHandler(e:Event):void
		{
			if (e.target.name == "assetSelectSlider")
			{
				var assetText:TextArea = config.getCompById("assetInformation") as TextArea;
				
				var item:Object;
				if ((e.target as HGUISlider).selectedItem != null)
				{
					item = (e.target as HGUISlider).selectedItem;
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
			/*if (e.target.name == "tweenSelectSlider")
			{
				var serialTweenForElement:SerialTween = serialTweenDict[(config.getCompById("elementSelector") as ComboBox).selectedItem];
				var tween:ITween = serialTweenForElement.getTweenAt(int(e.target.value));
				trace(e.target.value + " " + int(e.target.value));
				var editor:TextArea = (config.getCompById("tweenEditor") as TextArea);
				if (tween is ObjectTween)
				{
					var objTween:ObjectTween = tween as ObjectTween;
					var pos:Number = objTween.position;
					if (pos < 0)
					{
						pos = pos;
					}
					editor.text = "Duration:" + objTween.time + "\nPosition: " + pos;
					//signal2.dispatch("setAnimationTime", pos);
				}
				else if (tween == null)
				{
					signal1.dispatch("Tween #" + e.target.value + "was not found");
				}
				
			}*/
		}
		
		public function SelectEventHandler(e:Event):void
		{
			
			
			if(e.target.name == "actorSelector")
			{
				
				var actorName:String = (config.getCompById("actorSelector") as ComboBox).selectedItem as String;
				if (actorName && actorName.length > 0)
				{
					signal2.dispatch("ActorAssetListRequest", actorName);
				}
				//var tweenSlider:HUISlider = (config.getCompById("tweenSelectSlider") as HUISlider);
				
				
			}
			else
			{
				try
				{
				signal2.dispatch(e.target.name, e.target.selectedIndex);
				}
				catch (e:Error){}
			}
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
		
		
		
		/*public function CompileShardsIntoAnimation():void
		{
			var shardsToCompile:Vector.<AnimateShard> = new Vector.<AnimateShard>();
			var animList:List = config.getCompById("animList") as List
			//Check to make sure the shard isn't already on the list.
			var listItems:Array = animList.items;
			
			for (var i:int = 0, l:int = listItems.length; i < l; i++) 
			{
				shardsToCompile[shardsToCompile.length] = listItems[i].shard;
			}
			signal2.dispatch("CompileShards", shardsToCompile);
		}*/
		
		public function FinishedLoadingXML(e:Event):void
		{
			waitingForComponentsCreation = false;
			config.removeEventListener(Event.COMPLETE, FinishedLoadingXML);
			config.removeEventListener(IOErrorEvent.IO_ERROR, FailedLoadingXML, true);
			
			
			
			var guiSlider:HGUISlider = config.getCompById("assetSelectSlider") as HGUISlider;
			//guiSlider.listItemClass = GUISliderItem;
			
			//var window:Window = config.getCompById("mainWindow") as Window;
			//window.title += " v" + AppVersion.VERSION;//window.title + 
			
			dispatchEvent(e);
			
			//signal1.dispatch("MenuFinishedInitializing");
		}
		
		
		/*public function AddNewBodyType(name:String):void
		{
			var cbox:ComboBox = config.getCompById("bodyTypeSelector") as ComboBox;
			if (cbox)
			{
				cbox.addItem(name);
			}
		}*/
		
		public function AddNewCharacter(name:String):void
		{
			var cbox:ComboBox = config.getCompById("characterSelector") as ComboBox;
			if (cbox)
			{
				cbox.addItem(name);
			}
		}
		
		[inline]
		private function AddNewActor(name:String):void
		{
			var cbox:ComboBox = config.getCompById("actorSelector") as ComboBox;
			if (cbox)
			{
				cbox.addItem(name);
			}
		}
		
		public function AddNewGraphicSet(name:String):void
		{
			var cbox:ComboBox = config.getCompById("gfxSetSelector") as ComboBox;
			if (cbox && cbox.items.indexOf(name) == -1)
			{
				cbox.addItem(name);
			}
		}
		
		
		
		private function WriteToDebugOutput(textToAdd:String):void
		{
			var output:TextArea = config.getCompById("debugOutput") as TextArea;
			output.text += (output.text.length > 0 ? "\n" : "") + textToAdd as String;
		}
		
		//private function Update
		
		//Used exclusively for debug messages.
		/*public function onSignal1(string:*):void
		{
			WriteToDebugOutput(string as String);
		}*/
		
		public function onSignal2(targetName:*, value:*):void
		{
			var command:String = targetName as String;
			
			if (command == "updatedAnimation")
			{
				var elementSelectBox:ComboBox = config.getCompById("elementSelector") as ComboBox;
				if (elementSelectBox)
				{
					var selectedElement:Object = elementSelectBox.selectedItem;
					if (selectedElement != null)
					{
						var element:Sprite = (value as Sprite).getChildByName(selectedElement as String) as Sprite;
						var elementInfo:TextArea = (config.getCompById("tweenEditor") as TextArea);
						
						if (element)
						{
							
							elementInfo.text = StringUtil.substitute("Pos(X,Y): {0}, {1}\nDimensions(W,H): {2}, {3}\nVisible: {4}", element.x, element.y, element.width, element.height, element.visible);
						}
						else
						{
							elementInfo.text = "";
						}
					}
				}
			}
			else if (command == "ClickEvent")
			{
				var compName:String = (value as Sprite).name;
				if (config.getCompById(compName) != null)
				{
					ClickEventHandler(compName);
				}
			}
			
			else if (command == "elementSelector")
			{
				var elementSelectBox:ComboBox = config.getCompById("elementSelector") as ComboBox;
				
				
				//Got tween data
				var timelines:Vector.<SerialTween> = value as Vector.<SerialTween>;
				elementSelectBox.removeAll();
				serialTweenDict = new Dictionary();
				if (timelines)
				{
					var objTween:ITween;
					var tweenCounter:int = -1;
					for (var i:int = 0; i < timelines.length; i++) 
					{
						while (++tweenCounter) 
						{
							objTween = timelines[i].getTweenAt(tweenCounter);
							if (objTween == null || objTween is ObjectTween)
							{
								break;
							}
						}
						if (objTween is ObjectTween)
						{
							elementSelectBox.addItem((objTween as ObjectTween).target.name);
							//serialTweenDict[(objTween as ObjectTween).target.name] = timelines[i];
						}
						//var protoTween:ITween = timelines[i].getTweenAt(0);
						//var tween:ObjectTween = timelines[i].getTweenAt(0) as ObjectTween;
						
					}
					
				}
				//currentTimelineSet = timelines;
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
							
							//var spriteBounds:Rectangle = previewSprite.getBounds(previewSprite);
							//spriteBounds.offset( -spriteBounds.left, -spriteBounds.top);
							//previewSprite.bound
							//previewSprite.transform.pixelBounds.offsetPoint(new Point(0, 0));
							assetPreviewSprites[spriteClass] = previewSprite;
							//Resize the preview sprite to fit in the preview display box.
							//var displayAreaDimension:Vector.<Number> = assetGuiSlider.GetDimensionsOfDisplayBox();
							
				
							//previewSprite.width = spriteSize[0]; previewSprite.height = spriteSize[1];
							//previewSprite.x =  32 + .15;// (spriteBounds.width - spriteBounds.right ) / 2;//  * previewSprite.scaleX;// 64 - regPoint.x;// displayAreaDimension[0] - (spriteBounds.width - spriteBounds.right) ; 
							//previewSprite.y = 32 + 1.35; //regPoint.y * previewSprite.scaleY;// (64 - previewSprite.height) / 2;// spriteBounds.bottom / 2;// (  - displayAreaDimension[1] + previewSprite.height) / 2;
							
							//the preview sprite isn't (or at least shouldn't be) subject to changes it can be cached as a bitmap for performance.
							previewSprite.cacheAsBitmap = true;
							previewSprite.mouseEnabled = previewSprite.mouseChildren = false;
						}
						item.displayImage = assetPreviewSprites[spriteClass];
						item.displayName = (assetList[y] as Object).AssetSet as String;
						item.layer = (assetList[y] as Object).AssetLayer as int;
						//slider = item;
						assetGuiSlider.addItem(item);
					}
				}
				//assetGuiSlider.value = (assetGuiSlider.items.length > 0) ? 0 : -1;
				assetGuiSlider.selectedIndex = (assetGuiSlider.items.length > 0) ? 0 : -1;
				//assetGuiSlider.items = items;
			}
			/*else
			{
				WriteToDebugOutput(StringUtil.substitute("Failed to load Animation List \"{0}\"", value[1] as String));
			}*/
		}
		
		
	}
}
