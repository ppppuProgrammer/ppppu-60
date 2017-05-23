package menu 
{
	import com.jacksondunstan.signals.Slot2;
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.bit101.utils.MinimalConfigurator;
	import com.bit101.components.*;
	import flash.errors.IOError;
	import flash.events.IOErrorEvent;
	import com.jacksondunstan.signals.*;
	import animations.AnimationList;
	import io.FileReferenceLoadHelper;
	import io.FileReferenceSaveHelper;
	import mx.utils.StringUtil;
	import org.libspark.betweenas3.utils.TimeUtil;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author 
	 */
	public class AnimationMenu extends Sprite implements Slot2, ISubMenu
	{
		private var config:MinimalConfigurator;
		private var signal1:Signal1;
		private var signal2:Signal2;
		
		private var currentSelectedAnimationId:int;
		private var currentSelectedShardTypeIsBase:Boolean;
		private var currentSelectedShardItem:ShardItem;
		private var currentSelectedShardName:String;
		
		private var animationDuration:Number;
		
		private const INVALIDANIMATIONSTRING:String = "\" needs to be loaded";
		
		CONFIG::release {
			[Embed(source="AnimationMenuDefinition.xml",mimeType="application/octet-stream")]
			private var menuDefinitionClass:Class;
		}
		
		public function AnimationMenu() 
		{
			name = "Animation Menu";
			signal2 = new Signal2;
			signal1 = new Signal1;
		}
		
		public function InitializeMenu(app:AppCore):void
		{
			config = new MinimalConfigurator(this);
			config.addEventListener(Event.COMPLETE, FinishedLoadingXML);
			config.addEventListener(IOErrorEvent.IO_ERROR, FailedLoadingXML);
			
			CONFIG::debug
			{
				config.loadXML("../src/menu/AnimationMenuDefinition.xml");
			}
			
			CONFIG::release
			{
				var xmlByteArray:ByteArray = new menuDefinitionClass() as ByteArray;
				config.parseXMLString(xmlByteArray.readUTFBytes(xmlByteArray.length));
			}
			
			signal1.addSlot(app);
			signal2.addSlot(app);
			app.SetupMenuHooks(null, this);
		}
		
		private function CreateAnimationList():AnimationList
		{
			//Need to prepare data to create the animation list.
			var cbox:ComboBox = config.getCompById("animationSelector") as ComboBox;
			if (cbox.selectedIndex == -1) { return null; }
		
			var animList:List = config.getCompById("animList") as List;
			var shardsList:Array = animList.items;
			var listLength:int = shardsList.length;
			if (listLength == 0) { return null;}
			var shardNames:Vector.<String> = new Vector.<String>();
			var shardTypes:Vector.<Boolean> = new Vector.<Boolean>();
			for (var i:int = 0; i < listLength; i++) 
			{
				shardNames[shardNames.length] = (shardsList[i].name) as String;
				shardTypes[shardTypes.length] = (shardsList[i].type) as Boolean;
			}
			//Create the animation List.
			var list:AnimationList = new AnimationList(/*cbox.selectedItem as String, shardNames*/);
			list.TargetAnimationName = cbox.selectedItem as String;
			list.ShardNameList = shardNames;
			list.ShardTypeList = shardTypes;
			return list;
		}
		
		private function SaveAnimationListToFile():void
		{			
			//Need to ask the user where they want to save the list.
			var file:FileReferenceSaveHelper = new FileReferenceSaveHelper(null, CreateAnimationList(), "file.pasl");
			
		}
		
		private function LoadAnimationListFile():void
		{
			var file:FileReferenceLoadHelper = new FileReferenceLoadHelper(this, "ppppu animation shard list (*.pasl)", "*.pasl");
			
		}
		
		public function UpdateShardsCombobox(shardNames:Vector.<String>):void 
		{
			var cbox:ComboBox = config.getCompById("shardSelector") as ComboBox;
			cbox.removeAll();
			if (shardNames == null) { return;}
			for (var i:int = 0; i < shardNames.length; i++) 
			{
				cbox.addItem(shardNames[i]);
			}
			cbox.items.sort(Array.CASEINSENSITIVE);
			
		}
		
		public function AddNewAnimation(name:String):void
		{
			var cbox:ComboBox = config.getCompById("animationSelector") as ComboBox;
			if (cbox)
			{
				cbox.addItem(name);
			}
		}
		
		public function AddSelectedShardToAnimationList():void
		{
			//If a shard isn't selected then exit this function
			if (currentSelectedShardName == null) return;
			
			
			var animList:List = config.getCompById("animList") as List
			//Check to make sure the shard isn't already on the list.
			var listItems:Array = animList.items;
			for (var i:int = 0, l:int = listItems.length; i < l; i++) 
			{
				if (listItems[i].name == currentSelectedShardName)
					return;
			}
			
			animList.addItem({name: currentSelectedShardName/*, shard: currentSelectedShard*/, type: currentSelectedShardTypeIsBase});
			//if(animList.items.indexOf(
			
		}
		
		public function RemoveShardFromAnimationList():void
		{
			var animList:List = config.getCompById("animList") as List
			if (animList.selectedIndex > -1)
			{
				animList.removeItemAt(animList.selectedIndex);
			}
		}
		
		private function SetSelectedShard(/*shard:AnimateShard, shardName:String,*/ description:String):void
		{
			(config.getCompById("shardInfoText") as TextArea).text = description;
		}
		
		public function CompileAnimation():void
		{
			var animateList:AnimationList = CreateAnimationList();
			signal2.dispatch("AnimMenu_CompileAnimationFromAnimationList", animateList);
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
			else if (command == "UpdateShardsCombobox")
			{
				UpdateShardsCombobox(value as Vector.<String>);
			}
			/*else if (command == "SetSelectedShard")
			{
				SetSelectedShard(value as String);
			}*/
			else if (command == "timeText")
			{
				
				var position:Number = value;
				var timeStr:String = position.toFixed(2) + " / " + animationDuration.toFixed(2);
				(config.getCompById(command) as Label).text = timeStr;
				
				//Update the label that indicates the frame
				var animationTotalKeyframes:Number = TimeUtil.toFrames(animationDuration, 30.0);
				var frameStr:String = (((TimeUtil.toFrames(position, 30)+1.0)%animationTotalKeyframes).toFixed(1)) + " / " + int(animationTotalKeyframes);
				(config.getCompById("frameText") as Label).text = frameStr;
			}
			else if (command == "animationDuration")
			{
				animationDuration = value;
				if (stage)
				{
				(config.getCompById("frameSlider") as HUISlider).maximum = value * stage.frameRate;
				}
			}
			else if (command == "SetShardDescription")
			{
				SetSelectedShard(value as String/*value[0] as AnimateShard, value[1] as String*/);
			}
			else if (command == "SetupShardsList")
			{
				var shardsData:Vector.<Array> = value as Vector.<Array>;
				var animateList:List = config.getCompById("animList") as List;	
				if (shardsData)
				{
					if (animateList)
					{
						animateList.removeAll();
						//value is vector of arrays hold the following in order: shard name, shard type, shard
						//var shardsData:Vector.<Array> = value as Vector.<Array>;
						for (var j:int = 0, k:int = shardsData.length; j < k; j++) 
						{
							animateList.addItem({name: shardsData[j][0] as String, type: shardsData[j][1] as Boolean});
							//animateList.addItem(list.ShardNameList[j]);
						}
					}
				}
				else
				{
					if (animateList)	{animateList.removeAll();}
				}
			}
			else if (command == "AnimMenu_ChangeAnimationSelected")
			{
				var cbox:ComboBox = config.getCompById("animationSelector") as ComboBox;
				if (cbox)
				{
					cbox.selectedIndex = cbox.items.indexOf(value as String);					
				}
			}
			else if (command == "AddNewAnimation")
			{
				AddNewAnimation(value as String);
			}
			else if (command == "CharMenu_CharacterInfoDelivery")
			{
				//Used to update the title of the animation selection window
				var animSelectWindow:Window = config.getCompById("charAnimationsWindow") as Window;
				if (animSelectWindow)
				{
					animSelectWindow.title = (value[0] as String) + "'s animations";
				}
				var animateList:List = config.getCompById("animList") as List;	
				if (animateList)
				{
					animateList.removeAll();
				}
			}
			else if (command == "AnimMenu_AddAnimationSlotResult")
			{
				var result:Boolean = value as Boolean;
				if (result)
				{
					var charAnimationList:List = config.getCompById("charAnimationsSelector") as List;
					if (charAnimationList)
					{
						charAnimationList.addItem( { label: "Empty" } );
						ChangeDefaultLabelForAnimationSelector("");					
					}
				}
			}
			else if (command == "AnimMenu_RemoveAnimationSlotResult")
			{
				var result:Boolean = value as Boolean;
				if (result)
				{
					var charAnimationList:List = config.getCompById("charAnimationsSelector") as List;
					if (charAnimationList)
					{
						charAnimationList.removeItemAt(charAnimationList.selectedIndex);
						charAnimationList.selectedIndex = -1;
						config.getCompById("animationListButtonGroup").enabled = config.getCompById("addShardButton").enabled = false;
						var animateList:List = config.getCompById("animList") as List;	
						if (animateList)
						{
							animateList.removeAll();
						}
					}
				}
			}
			else if (command == "AnimMenu_UpdateAnimationListing")
			{
				var animationStates:Vector.<Boolean> = value as Vector.<Boolean>;
				var charAnimationList:List = config.getCompById("charAnimationsSelector") as List;
				if (charAnimationList)
				{
					charAnimationList.removeAll();
					if (animationStates)
					{
						for (var i:int = 0, l:int = animationStates.length; i < l; i++) 
						{
							if (animationStates[i] == false)
							{
								charAnimationList.addItem( { label: "Empty" } );
							}
							else
							{
								charAnimationList.addItem( { label: String(i+1) } );
							}
						}
					}
				}
			}
			else if (command == "AnimMenu_SaveAnimationResult")
			{
				var charAnimationList:List = config.getCompById("charAnimationsSelector") as List;
				var animateList:List = config.getCompById("animList") as List;	
				if (animateList && charAnimationList && charAnimationList.selectedIndex > -1)
				{
					if ((value as Boolean) == true)
					{
						if (animateList.items.length > 0)
						{
							charAnimationList.selectedItem.label = String(charAnimationList.selectedItem);
						}
						else
						{
							charAnimationList.selectedItem.label = "Empty";
						}
					}
					else
					{
						charAnimationList.selectedItem.label = "";
					}
				}
				
			}
			else if (command == "FileLoaded")
			{
				var charAnimationList:List = config.getCompById("charAnimationsSelector") as List;
				if (charAnimationList.selectedItem < 0)
				{
					return;
				}
				//value is an array, index 0 is the data from the file, index 1 is the name of the file
				//signal2.dispatch(command, value);
				var bytes:ByteArray = value[0] as ByteArray;
				//bytes.position = 0;
				var list:AnimationList = bytes.readObject() as AnimationList;
				if (list)
				{
					//WriteToDebugOutput(StringUtil.substitute("Successfully loaded Animation List \"{0}\"", value[1] as String));
					var cbox:ComboBox = config.getCompById("animationSelector") as ComboBox;
					if (cbox)
					{
						cbox.selectedIndex = cbox.items.indexOf(list.TargetAnimationName);
					}
					//Don't have direct access to the shards, send a command to AppCore to do stuff with the list. The dev menu will receive a command with the shards that the list wants.
					signal2.dispatch("ProcessAnimationList", list);
				}
			}
			else if (command == "AnimMenu_InvalidAnimationSelected")
			{
				ChangeDefaultLabelForAnimationSelector("\"" + (value as String) + INVALIDANIMATIONSTRING);
			}
			
		}

		private function ClickEventHandler(target:Object/*e:MouseEvent*/):void
		{
			var targetName:String = target["name"];
			if (targetName == "addShardButton")
			{
				AddSelectedShardToAnimationList();
			}
			else if (targetName == "finalizeButton")
			{
				CompileAnimation();
				//CompileShardsIntoAnimation();
			}
			else if (targetName == "removeShardButton")
			{
				RemoveShardFromAnimationList();
			}
			else if (targetName == "loadAnimationListButton")
			{
				LoadAnimationListFile();
			}
			else if (targetName == "saveAnimationListButton")
			{
				SaveAnimationListToFile();
			}
			else if (targetName == "addAnimationSlotBtn")
			{
				//Need to know if there is a character selected.
				signal1.dispatch("AnimMenu_AddAnimationSlotRequest");
			}
			else if (targetName == "removeAnimationSlotBtn")
			{
				var charAnimationList:List = config.getCompById("charAnimationsSelector") as List;
				if (charAnimationList)
				{
					//Need to know if there is a character selected.
					signal2.dispatch("AnimMenu_RemoveAnimationSlotRequest", charAnimationList.selectedIndex);
				}
			}
			else if (targetName == "saveAnimationListBtn")
			{
				var animateList:AnimationList = CreateAnimationList();
				var charAnimationList:List = config.getCompById("charAnimationsSelector") as List;
				if (animateList && charAnimationList)
				{
					//Need to know if there is a character selected.
					signal2.dispatch("AnimMenu_SaveAnimationForCharacterRequest", [charAnimationList.selectedIndex, animateList]);
				}
			}
			else if (targetName == "copyListToClipboardButton")
			{
				var cbox:ComboBox = config.getCompById("animationSelector") as ComboBox;
				if (cbox.selectedIndex == -1) { return; }
				var shardList:List = config.getCompById("animList") as List;
				var clipboardContents:Array = ["[\"" + cbox.selectedItem + "\""];
				//clipboardContents[0] = cbox.selectedItem;
				for (var i:int = 0, l:int = shardList.items.length; i < l; i++) 
				{
					clipboardContents[clipboardContents.length] = shardList.items[i].type.toString();
					clipboardContents[clipboardContents.length] = "\"" +shardList.items[i].name + "\"";
				}
				clipboardContents[clipboardContents.length - 1] += "]";
				
				Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, clipboardContents, true);
			}
			else if (targetName.indexOf("FrameChange") > -1 /*&& (config.getCompById("elementSelector") as ComboBox).selectedIndex > -1*/)
			{
				signal1.dispatch(targetName);
			}	
			else if (targetName.search(/animPauseButton|animPlayButton/) > -1)
			{
				signal1.dispatch(targetName);
			}
			else
			{
				//setFrameButton needs to also send data on what frame to go to.
				signal2.dispatch(targetName, int((config.getCompById("frameSlider") as HUISlider).value));
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
		
		public function SelectEventHandler(target:Object):void
		{
			
			if (target.name == "shardTypeSelector" || target.name == "animationSelector")
			{
				var cbox:ComboBox = config.getCompById("animationSelector") as ComboBox;
				var cbox2:ComboBox = config.getCompById("shardTypeSelector") as ComboBox;
				var cbox3:ComboBox = config.getCompById("shardSelector") as ComboBox;
				if (cbox.selectedIndex > -1)	{ ChangeDefaultLabelForAnimationSelector(""); }
				
				if (cbox2.selectedItem == null) { return; }
				
				//If the animation selected changes, clear the animation list so shards from different animations can't be used together.
				if (currentSelectedAnimationId != cbox.selectedIndex)
				{
					var shardList:List = config.getCompById("animList") as List;
					if (shardList)
					{
						shardList.removeAll();
					}
				}
				//cache the values of the combo boxes.
				currentSelectedAnimationId = cbox.selectedIndex;
				if (currentSelectedAnimationId == -1) { return;}
				currentSelectedShardTypeIsBase = (cbox2.selectedItem as String) == "Base" ? true : false;
				cbox3.removeAll();
				cbox3.selectedItem = -1;
				currentSelectedShardName = null;
				SetSelectedShard(null/*, null*/);
				
				signal2.dispatch(target.name, [currentSelectedAnimationId, currentSelectedShardTypeIsBase]);
				//UpdateShardComboBox();
			}
			else if (target.name == "shardSelector")
			{
				var cbox:ComboBox = config.getCompById("shardSelector") as ComboBox;
				if (cbox.selectedIndex == -1 || cbox.selectedItem == null) { return; }
				//currentSelectedShardItem = cbox.selectedItem as ShardItem;
				currentSelectedShardName = cbox.selectedItem as String;
				signal2.dispatch(target.name, [currentSelectedAnimationId, currentSelectedShardTypeIsBase, currentSelectedShardName]);
				//UpdateShardComboBox();
			}
			
			else if (target.name == "charAnimationsSelector")
			{
				var charAnimationList:List = config.getCompById("charAnimationsSelector") as List;
				signal2.dispatch("AnimMenu_ChangeSelectedAnimationOfCurrentCharacter", charAnimationList.selectedIndex);
				if (charAnimationList.selectedItem == null)
				{
					config.getCompById("animationListButtonGroup").enabled = config.getCompById("addShardButton").enabled = false;
				}
				else
				{
					config.getCompById("animationListButtonGroup").enabled = config.getCompById("addShardButton").enabled = true;
				}
			}
			else
			{
				try
				{
				signal2.dispatch(target.name, target.selectedIndex);
				}
				catch (e:Error){}
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
			var cbox:ComboBox = config.getCompById("shardTypeSelector") as ComboBox;
			cbox.addItem("Base");
			cbox.addItem("Addition");
			cbox.selectedIndex = 0;
			
			var animList:List = config.getCompById("animList") as List;
			animList.listItemClass = ShardItem;
			dispatchEvent(e);
			
			var charAnimList:List = config.getCompById("charAnimationsSelector") as List;
			if (charAnimList)
			{
				charAnimList.listItemClass = HorizontalListItem;
			}
			
			//Disable certain buttons
			config.getCompById("animationListButtonGroup").enabled = false;
			config.getCompById("addShardButton").enabled = false;
		}
		
		[inline]
		private function ChangeDefaultLabelForAnimationSelector(defaultLabel:String):void
		{
			var cbox:ComboBox = config.getCompById("animationSelector") as ComboBox;
			if (cbox)
			{
				cbox.defaultLabel = defaultLabel;					
			}
		}
		
	}

}