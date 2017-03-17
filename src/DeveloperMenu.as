package
{
	import com.bit101.components.*;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.bit101.utils.MinimalConfigurator;
	import com.jacksondunstan.signals.*;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import mx.utils.StringUtil;
	import org.libspark.betweenas3.core.tweens.AbstractTween;
	import org.libspark.betweenas3.core.tweens.ObjectTween;
	import org.libspark.betweenas3.core.tweens.groups.SerialTween;
	import org.libspark.betweenas3.tweens.ITween;
	import org.libspark.betweenas3.utils.TimeUtil;
	import ppppu.AppCore;

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
		
		var animationDuration:Number;
		
		var signal1:Signal1 = new Signal1();
		var signal2:Signal2 = new Signal2();
		var config:MinimalConfigurator;
		var waitingForComponentsCreation:Boolean = true;
		
		//var currentTimelineSet:Vector.<SerialTween>;
		var serialTweenDict:Dictionary = new Dictionary();
		public function DeveloperMenu() 
		{
			//title = "NX developer menu";
			//this.setSize(480, 720);
			//
			/*animProgressSlider = new HUISlider(this, 160, 30, "Progress");
animProgressSlider.labelPrecision = 0;

			animationLabel = new Label(this, 10, 10, "Animation:");

			animDropListPH = new ComboBox(this, 60, 10);
			animDropListPH.width = 60;
			

			frameLabel = new Label(this, 70, 30, "Frame:");

			frameText = new Label(this, 110, 30, "#");

			animPlayButton = new PushButton(this, 10, 30, "Play", PlayAnimationHandler);
animPlayButton.width = 50;
animPlayButton.toggle = true;

			setFrameButton = new PushButton(this, 180, 80, "Set to frame", SetFrameHandler);
setFrameButton.width = 80;

			frameSlider = new HUISlider(this, 270, 80, "");
frameSlider.minimum = 1;
frameSlider.value = 1;
frameSlider.labelPrecision = 0;

			bodyLabel = new Label(this, 170, 10, "Body group:");

			bodyDropListPH = new ComboBox(this, 230, 10);
			bodyDropListPH.width = 60;
			bodyDropListPH.addItem("Test1");
			bodyDropListPH.addItem("Test2");

			charLabel = new Label(this, 340, 10, "Character:");

			charDropListPH = new ComboBox(this, 390, 10);
			charDropListPH.width = 60;

			frameForwardButton = new PushButton(this, 90, 80, "Frame forward", FrameForwardHandler);
frameForwardButton.width = 80;

			frameBackButton = new PushButton(this, 10, 80, "Frame back", FrameBackHandler);
frameBackButton.width = 70;

			frameSettingLabel = new Label(this, 10, 60, "Frame Settings");*/
			
			
			
			config = new MinimalConfigurator(this);
			config.addEventListener(Event.COMPLETE, FinishedLoadingXML);
			config.loadXML("DevMenuDefinition.xml");
			
		}

		public function ReadyCheck():Boolean
		{
			return !waitingForComponentsCreation;
		}
		
		public function SetupHooksToApp(app:AppCore):void
		{
			signal1.addSlot(app);
			addEventListener(MouseEvent.CLICK, ClickEventHandler, true);
			
			
			signal2.addSlot(app);
			addEventListener(Event.SELECT, SelectEventHandler, true);
			
			addEventListener(Event.CHANGE, ChangeEventHandler, true);
		}
		
		private function ClickEventHandler(e:MouseEvent)
		{
			if (e.target.name == "setAnimationButton")
			{
				var anim_cbox:ComboBox = config.getCompById("animationSelector") as ComboBox;
				var body_cbox:ComboBox = config.getCompById("bodyTypeSelector") as ComboBox;
				var char_cbox:ComboBox = config.getCompById("characterSelector") as ComboBox;
				signal2.dispatch(e.target.name, [anim_cbox.selectedIndex, body_cbox.selectedIndex, char_cbox.selectedIndex]);
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
		
		private function ChangeEventHandler(e:Event)
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
		
		private function SelectEventHandler(e:Event)
		{
			if(e.target.name == "elementSelector")
			{
				/*var serialTweenForElement:SerialTween = serialTweenDict[(config.getCompById("elementSelector") as ComboBox).selectedItem];
				var tweenSlider:HUISlider = (config.getCompById("tweenSelectSlider") as HUISlider);
				//Need to find out how many ITweens are in the serial tween.
				var tweenAmount:int=0;
				while (serialTweenForElement.getTweenAt(tweenAmount) != null)
				{
					++tweenAmount;
				}
				tweenSlider.maximum = tweenAmount;*/
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
		
		public function FinishedLoadingXML(e:Event):void
		{
			waitingForComponentsCreation = false;
			config.removeEventListener(Event.COMPLETE, FinishedLoadingXML);
		}
		public function AddNewAnimation(name:String):void
		{
			var cbox:ComboBox = config.getCompById("animationSelector") as ComboBox;
			if (cbox)
			{
				cbox.addItem(name);
			}
		}
		
		public function AddNewBodyType(name:String):void
		{
			var cbox:ComboBox = config.getCompById("bodyTypeSelector") as ComboBox;
			if (cbox)
			{
				cbox.addItem(name);
			}
		}
		
		public function AddNewCharacter(name:String):void
		{
			var cbox:ComboBox = config.getCompById("characterSelector") as ComboBox;
			if (cbox)
			{
				cbox.addItem(name);
			}
		}
		
		//Used for entering strings into the debug output
		public function onSignal1(string:*):void
		{
			var output:TextArea = config.getCompById("debugOutput") as TextArea;
			output.text += "\n" + string as String;
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
		}
		
		function roundToNearest(roundTo:Number, value:Number):Number{
			return Math.round(value/roundTo)*roundTo;
		}
	}
}
