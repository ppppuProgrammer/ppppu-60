package menu
{
	import adobe.utils.CustomActions;
	import animations.AnimateShard;
	import animations.AnimationList;
	import com.bit101.components.*;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.bit101.utils.MinimalConfigurator;
	import com.jacksondunstan.signals.*;
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import io.FileReferenceLoadHelper;
	import io.FileReferenceSaveHelper;
	import mx.utils.StringUtil;
	import org.libspark.betweenas3.core.tweens.AbstractTween;
	import org.libspark.betweenas3.core.tweens.ObjectTween;
	import org.libspark.betweenas3.core.tweens.groups.SerialTween;
	import org.libspark.betweenas3.tweens.ITween;
	import org.libspark.betweenas3.utils.TimeUtil;
	import AppCore;

	//[SWF(backgroundColor=0xeeeeee, width=480, height=720)]
	public class DeveloperMenu extends Sprite implements Slot1,Slot2
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
		
		private var animationDuration:Number;
		
		private var signal1:Signal1 = new Signal1();
		private var signal2:Signal2 = new Signal2();
		private var config:MinimalConfigurator;
		private var waitingForComponentsCreation:Boolean = true;
		
		private var currentSelectedAnimationId:int;
		private var currentSelectedShardTypeIsBase:Boolean;
		private var currentSelectedShardItem:ShardItem;
		private var currentSelectedShardName:String;
		
		//var currentTimelineSet:Vector.<SerialTween>;
		private var serialTweenDict:Dictionary = new Dictionary();
		public function DeveloperMenu(app:AppCore) 
		{			
			config = new MinimalConfigurator(this);
			config.addEventListener(Event.COMPLETE, FinishedLoadingXML);
			
			addEventListener(MouseEvent.CLICK, ClickEventHandler, true);
			addEventListener(Event.CHANGE, ChangeEventHandler, true);
			addEventListener(Event.SELECT, SelectEventHandler, true);

			signal1.addSlot(app);
			signal2.addSlot(app);
			
			config.loadXML("DevMenuDefinition.xml");
			
		}

		public function ReadyCheck():Boolean
		{
			return !waitingForComponentsCreation;
		}
		
		/*public function SetupHooksToApp(app:AppCore):void
		{
			signal1.addSlot(app);
			addEventListener(MouseEvent.CLICK, ClickEventHandler, true);
			
			
			signal2.addSlot(app);
			addEventListener(Event.SELECT, SelectEventHandler, true);
			
			addEventListener(Event.CHANGE, ChangeEventHandler, true);
		}*/
		
		private function ClickEventHandler(e:MouseEvent):void
		{
			if (e.target.name == "addShardButton")
			{
				AddSelectedShardToAnimationList();
			}
			/*if (e.target.name == "setAnimationButton")
			{
				var anim_cbox:ComboBox = config.getCompById("animationSelector") as ComboBox;
				var body_cbox:ComboBox = config.getCompById("bodyTypeSelector") as ComboBox;
				var char_cbox:ComboBox = config.getCompById("characterSelector") as ComboBox;
				signal2.dispatch(e.target.name, [anim_cbox.selectedIndex, body_cbox.selectedIndex, char_cbox.selectedIndex]);
			}*/
			else if (e.target.name == "finalizeButton")
			{
				CompileAnimation();
				//CompileShardsIntoAnimation();
			}
			else if (e.target.name == "removeShardButton")
			{
				RemoveShardFromAnimationList();
			}
			else if (e.target.name == "loadAnimationListButton")
			{
				LoadAnimationListFile();
			}
			else if (e.target.name == "saveAnimationListButton")
			{
				SaveAnimationListToFile();
			}
			else if (e.target.name == "addGfxSetButton")
			{
				var gfxSetCBox:ComboBox = config.getCompById("gfxSetSelector") as ComboBox;
				var gfxSetList:List = config.getCompById("gfxSetList") as List;
				if (gfxSetCBox && gfxSetList)
				{
					if (gfxSetCBox.selectedItem != null && gfxSetList.items.indexOf(gfxSetCBox.selectedItem) == -1)
					{
						gfxSetList.addItem(gfxSetCBox.selectedItem);
					}
				}
				
				UpdateGraphicSetsUsed();
			}
			else if (e.target.name == "removeGfxSetButton")
			{
				var gfxSetList:List = config.getCompById("gfxSetList") as List;
				if (gfxSetList)
				{
					if (gfxSetList.selectedIndex != -1)
					{
						gfxSetList.removeItemAt(gfxSetList.selectedIndex);
					}
				}
				
				UpdateGraphicSetsUsed();
			}
			else if (e.target.name != "setFrameButton" /*&& (config.getCompById("elementSelector") as ComboBox).selectedIndex > -1*/)
			{
				signal1.dispatch(e.target.name);
			}		
			else
			{
				//setFrameButton needs to also send data on what frame to go to.
				signal2.dispatch(e.target.name, int((config.getCompById("frameSlider") as HUISlider).value));
			}
			
		}
		
		private function ChangeEventHandler(e:Event):void
		{
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
		
		private function SelectEventHandler(e:Event):void
		{
			
			if (e.target.name == "shardTypeSelector" || e.target.name == "animationSelector")
			{
				var cbox:ComboBox = config.getCompById("animationSelector") as ComboBox;
				var cbox2:ComboBox = config.getCompById("shardTypeSelector") as ComboBox;
				var cbox3:ComboBox = config.getCompById("shardSelector") as ComboBox;
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
				
				signal2.dispatch(e.target.name, [currentSelectedAnimationId, currentSelectedShardTypeIsBase]);
				//UpdateShardComboBox();
			}
			else if (e.target.name == "shardSelector")
			{
				var cbox:ComboBox = config.getCompById("shardSelector") as ComboBox;
				if (cbox.selectedIndex == -1) { return; }
				//currentSelectedShardItem = cbox.selectedItem as ShardItem;
				currentSelectedShardName = cbox.selectedItem as String;
				signal2.dispatch(e.target.name, [currentSelectedAnimationId, currentSelectedShardTypeIsBase, currentSelectedShardName]);
				//UpdateShardComboBox();
			}
			/*else if(e.target.name == "elementSelector")
			{
				var serialTweenForElement:SerialTween = serialTweenDict[(config.getCompById("elementSelector") as ComboBox).selectedItem];
				var tweenSlider:HUISlider = (config.getCompById("tweenSelectSlider") as HUISlider);
				//Need to find out how many ITweens are in the serial tween.
				var tweenAmount:int=0;
				while (serialTweenForElement.getTweenAt(tweenAmount) != null)
				{
					++tweenAmount;
				}
				tweenSlider.maximum = tweenAmount;
			}*/
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
		
		public function UpdateShardsCombobox(shardNames:Vector.<String>):void 
		{
			var cbox:ComboBox = config.getCompById("shardSelector") as ComboBox;
			cbox.removeAll();
			for (var i:int = 0; i < shardNames.length; i++) 
			{
				cbox.addItem(shardNames[i]);
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
		
		public function CompileAnimation():void
		{
			var animateList:AnimationList = CreateAnimationList();
			signal2.dispatch("CompileAnimationFromAnimationList", animateList);
		}
		
		public function CompileShardsIntoAnimation():void
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
		}
		
		public function FinishedLoadingXML(e:Event):void
		{
			waitingForComponentsCreation = false;
			config.removeEventListener(Event.COMPLETE, FinishedLoadingXML);
			
			var cbox:ComboBox = config.getCompById("shardTypeSelector") as ComboBox;
			cbox.addItem("Base");
			cbox.addItem("Addition");
			
			var animList:List = config.getCompById("animList") as List;
			animList.listItemClass = ShardItem;
			
			var window:Window = config.getCompById("mainWindow") as Window;
			window.title += " v" + Version.VERSION;//window.title + 
			
			signal1.dispatch("MenuFinishedInitializing");
		}
		public function AddNewAnimation(name:String):void
		{
			var cbox:ComboBox = config.getCompById("animationSelector") as ComboBox;
			if (cbox)
			{
				cbox.addItem(name);
			}
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
		
		public function AddNewGraphicSet(name:String):void
		{
			var cbox:ComboBox = config.getCompById("gfxSetSelector") as ComboBox;
			if (cbox)
			{
				cbox.addItem(name);
			}
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
			/*//Need to prepare data to create the animation list.
			var cbox:ComboBox = config.getCompById("animationSelector") as ComboBox;
			if (cbox.selectedIndex == -1) { return; }
		
			var animList:List = config.getCompById("animList") as List;
			var shardsList:Array = animList.items;
			var listLength:int = shardsList.length;
			if (listLength == 0) { return;}
			var shardNames:Vector.<String> = new Vector.<String>();
			var shardTypes:Vector.<Boolean> = new Vector.<Boolean>();
			for (var i:int = 0; i < listLength; i++) 
			{
				shardNames[shardNames.length] = (shardsList[i].name) as String;
				shardTypes[shardTypes.length] = (shardsList[i].type) as Boolean;
			}
			//Create the animation List.
			var list:AnimationList = new AnimationList();
			list.TargetAnimationName = cbox.selectedItem as String;
			list.ShardNameList = shardNames;
			list.ShardTypeList = shardTypes;*/
			
			//Need to ask the user where they want to save the list.
			var file:FileReferenceSaveHelper = new FileReferenceSaveHelper(null, CreateAnimationList(), "file.pasl");
			
		}
		
		private function LoadAnimationListFile():void
		{
			var file:FileReferenceLoadHelper = new FileReferenceLoadHelper(this, "ppppu animation shard list (*.pasl)", "*.pasl");
			
		}
		
		private function WriteToDebugOutput(textToAdd:String):void
		{
			var output:TextArea = config.getCompById("debugOutput") as TextArea;
			output.text += (output.text.length > 0 ? "\n" : "") + textToAdd as String;
		}
		
		//private function Update
		
		//Used exclusively for debug messages.
		public function onSignal1(string:*):void
		{
			WriteToDebugOutput(string as String);
		}
		
		public function onSignal2(targetName:*, value:*):void
		{
			if (targetName == "timeText")
			{
				//var position:Number = roundToNearest(.01, value);
				var position:Number = value;
				var timeStr:String = position.toFixed(2) + " / " + animationDuration.toFixed(2);
				(config.getCompById(targetName) as Label).text = timeStr;
				
				//Update the label that indicates the frame
				var animationTotalKeyframes:Number = TimeUtil.toFrames(animationDuration, 30.0);
				var frameStr:String = (((TimeUtil.toFrames(position, 30)+1.0)%animationTotalKeyframes).toFixed(1)) + " / " + int(animationTotalKeyframes);
				(config.getCompById("frameText") as Label).text = frameStr;
			}
			else if (targetName == "updatedAnimation")
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
			else if (targetName == "animationDuration")
			{
				animationDuration = value;
				(config.getCompById("frameSlider") as HUISlider).maximum = value*stage.frameRate;
			}
			else if (targetName == "SetShardDescription")
			{
				SetSelectedShard(value as String/*value[0] as AnimateShard, value[1] as String*/);
			}
			else if (targetName == "elementSelector")
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
			else if (targetName == "SetupShardsList")
			{
				var shardsData:Vector.<Array> = value as Vector.<Array>;
				if (shardsData)
				{
					var animateList:List = config.getCompById("animList") as List;	
					
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
			}
			/*else if (targetName == "SetShardsFromList") //Add shards that were referred in an animation list
			{
				var shardsData:Vector.<Array> = value as Vector.<Array>;
				if (shardsData)
				{
					var animateList:List = config.getCompById("animList") as List;	
					
					if (animateList)
					{
						animateList.removeAll();
						//value is vector of arrays hold the following in order: shard name, shard type, shard
						//var shardsData:Vector.<Array> = value as Vector.<Array>;
						for (var j:int = 0, k:int = shardsData.length; j < k; j++) 
						{
							animateList.addItem({name: shardsData[j][0] as String, type: shardsData[j][1] as Boolean, shard: shardsData[j][2] as AnimateShard});
							//animateList.addItem(list.ShardNameList[j]);
						}
					}
				}
			}*/
			else if (targetName == "FileLoaded")
			{
				//value is an array, index 0 is the data from the file, index 1 is the name of the file
				//signal2.dispatch(targetName, value);
				var bytes:ByteArray = value[0] as ByteArray;
				//bytes.position = 0;
				var list:AnimationList = bytes.readObject() as AnimationList;
				if (list)
				{
					WriteToDebugOutput(StringUtil.substitute("Successfully loaded Animation List \"{0}\"", value[1] as String));
					var cbox:ComboBox = config.getCompById("animationSelector") as ComboBox;
					if (cbox)
					{
						cbox.selectedIndex = cbox.items.indexOf(list.TargetAnimationName);
					}
					//Don't have direct access to the shards, send a command to AppCore to do stuff with the list. The dev menu will receive a command with the shards that the list wants.
					signal2.dispatch("ProcessAnimationList", list);
					/*var cbox:ComboBox = config.getCompById("animationSelector") as ComboBox;
					var animateList:List = config.getCompById("animList") as List;
					intentionallyBreaking;
					//The way "shards" are added to the animate list is completely wrong. It needs to be added similiar to the standard way, not brute forcing shard names into it.
					if (cbox && animateList)
					{
						animateList.removeAll();
						cbox.selectedIndex = cbox.items.indexOf(list.TargetAnimationName);
						var shardsAmount:int = list.ShardNameList.length;
						var shard:AnimateShard;
						for (var j:int = 0; j < shardsAmount; j++) 
						{
							shard = 
							animList.addItem({name: currentSelectedShardName, shard: currentSelectedShard, type: list.ShardTypeList[j]});
							//animateList.addItem(list.ShardNameList[j]);
						}
					}*/
				}
				else
				{
					WriteToDebugOutput(StringUtil.substitute("Failed to load Animation List \"{0}\"", value[1] as String));
				}
			}
		}
		
		private function SetSelectedShard(/*shard:AnimateShard, shardName:String,*/ description:String):void
		{
			
			//currentSelectedShardItem = shard;
			//currentSelectedShardName = shardName;
			(config.getCompById("shardInfoText") as TextArea).text = description;
		}
		
		function roundToNearest(roundTo:Number, value:Number):Number{
			return Math.round(value/roundTo)*roundTo;
		}
	}
}
