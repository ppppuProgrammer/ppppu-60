package
{
	import com.bit101.components.*;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.bit101.utils.MinimalConfigurator;
	import com.jacksondunstan.signals.*;
	import flash.events.MouseEvent;
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
			addEventListener(Event.SELECT, CompletedEventHandler, true);
		}
		
		private function ClickEventHandler(e:MouseEvent)
		{
			if (e.target.name != "setFrameButton")
			{
				signal1.dispatch(e.target.name);
			}
			else
			{
				//setFrameButton needs to also send data on what frame to go to.
				signal2.dispatch(e.target.name, (config.getCompById("frameSlider") as HUISlider).value);
			}
		}
		
		private function CompletedEventHandler(e:Event)
		{
			signal2.dispatch(e.target.name, e.target.selectedIndex);
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
		
		//Used for entering strings into the debug output
		public function onSignal1(string:*):void
		{
			var output:TextArea = config.getCompById("debugOutput") as TextArea;
			output.text += "\n" + string as String;
		}
		
		public function onSignal2(targetName:*, value:*):void
		{
			if (targetName == "frameText")
			{
				//var position:Number = roundToNearest(.01, value);
				var position:Number = value;
				var frameStr:String = position.toFixed(2) + " / " + animationDuration.toFixed(2);
				(config.getCompById(targetName) as Label).text = frameStr;
			}
			else if (targetName == "animationDuration")
			{
				animationDuration = value;
				(config.getCompById("frameSlider") as HUISlider).maximum = value*stage.frameRate;
			}
		}
		
		function roundToNearest(roundTo:Number, value:Number):Number{
			return Math.round(value/roundTo)*roundTo;
		}
	}
}
