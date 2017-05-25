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
	
	import flash.errors.IOError;
	import flash.events.IOErrorEvent;
	import AppCore;
	import flash.utils.ByteArray;

	//[SWF(backgroundColor=0xeeeeee, width=480, height=720)]
	public class DeveloperMenu extends Sprite implements /*Slot1,*/Slot2, ISubMenu
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
		
		/*CONFIG::release {
			[Embed(source="DevMenuDefinition.xml",mimeType="application/octet-stream")]
			private var menuDefinitionClass:Class;
		}*/
		
		//var currentTimelineSet:Vector.<SerialTween>;
		private var serialTweenDict:Dictionary = new Dictionary();
		
		public function DeveloperMenu(/*app:AppCore, director:Director*/) 
		{			
			name = "Developer Menu";	
			
			//addEventListener(MouseEvent.CLICK, ClickEventHandler, true);
			//addEventListener(Event.CHANGE, ChangeEventHandler, true);
			//addEventListener(Event.SELECT, SelectEventHandler, true);
		}
		
		public function InitializeMenu(app:AppCore):void
		{
			config = new MinimalConfigurator(this);
			config.addEventListener(Event.COMPLETE, FinishedLoadingXML);
			
			signal1.addSlot(app);
			signal2.addSlot(app);
			
			
			CONFIG::debug{
				config.loadXML("../src/menu/DevMenuDefinition.xml");
			}
			
			/*CONFIG::release
			{
				var xmlByteArray:ByteArray = new menuDefinitionClass() as ByteArray;
				config.parseXMLString(xmlByteArray.readUTFBytes(xmlByteArray.length));
			}*/
		}
		
		public function RegisterDirectorForMessages(director:Director):void
		{
			//Allow the director and menu to communicate with each other
			signal2.addSlot(director);
			director.RegisterMenuForMessaging(this);
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
		
		public function ClickEventHandler(target:Object/*e:MouseEvent*/):void
		{
			
		/*	if (targetName != "setFrameButton")
			{
				signal1.dispatch(targetName);
			}		
			else
			{
				//setFrameButton needs to also send data on what frame to go to.
				signal2.dispatch(targetName, int((config.getCompById("frameSlider") as HUISlider).value));
			}*/
			
		}
		
		public function ChangeEventHandler(e:Event):void
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
		
		public function SelectEventHandler(e:Event):void
		{

			{
				try
				{
				signal2.dispatch(e.target.name, e.target.selectedIndex);
				}
				catch (e:Error){}
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
			config.removeEventListener(Event.COMPLETE, FinishedLoadingXML);
			config.removeEventListener(IOErrorEvent.IO_ERROR, FailedLoadingXML, true);
			
			
			
			//var guiSlider:HGUISlider = config.getCompById("assetSelectSlider") as HGUISlider;
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
		
		/*public function AddNewCharacter(name:String):void
		{
			var cbox:ComboBox = config.getCompById("characterSelector") as ComboBox;
			if (cbox)
			{
				cbox.addItem(name);
			}
		}*/
		
		
		
		
		
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
		}
		
		
	}
}
