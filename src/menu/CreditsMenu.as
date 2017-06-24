package menu 
{
	import com.bit101.components.Label;
	import com.bit101.components.List;
	import com.bit101.components.PushButton;
	import com.bit101.components.RadioButton;
	import com.bit101.components.TextArea;
	import com.jacksondunstan.signals.Slot2;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.bit101.utils.MinimalConfigurator;
	import flash.errors.IOError;
	import flash.events.IOErrorEvent;
	import com.jacksondunstan.signals.Signal2;
	import flash.utils.ByteArray;
	import mx.utils.StringUtil;

	/**
	 * ...
	 * @author 
	 */
	public class CreditsMenu extends Sprite implements ISubMenu
	{
		private var config:MinimalConfigurator;
		//private var signal2:Signal2;
		
		CONFIG::release {
			[Embed(source="CreditsMenuDefinition.xml",mimeType="application/octet-stream")]
			private var menuDefinitionClass:Class;
		}
		
		public function CreditsMenu() 
		{
			name = "Credits Menu";
			//signal2 = new Signal2;
		}
		
		public function InitializeMenu(app:AppCore):void
		{
			config = new MinimalConfigurator(this);
			config.addEventListener(Event.COMPLETE, FinishedLoadingXML);
			config.addEventListener(IOErrorEvent.IO_ERROR, FailedLoadingXML);
			CONFIG::debug
			{
				config.loadXML("../src/menu/CreditsMenuDefinition.xml");
			}
			
			CONFIG::release
			{
				var xmlByteArray:ByteArray = new menuDefinitionClass() as ByteArray;
				config.parseXMLString(xmlByteArray.readUTFBytes(xmlByteArray.length));
			}
			//app.SetupMenuHooks(null, this);
			//signal2.addSlot(app);
		}
		
		private function FinishedLoadingXML(e:Event):void
		{
			config.removeEventListener(Event.COMPLETE, FinishedLoadingXML);
			config.removeEventListener(IOErrorEvent.IO_ERROR, FailedLoadingXML);
			
			var versionInfo:Label = config.getCompById("versionLabel") as Label;
			if (versionInfo) {
				var buildDate:String = AppVersionNX.BUILDDATE;
				var date:String = buildDate.substring(0, buildDate.indexOf(" "));
				var time:String = buildDate.substring(buildDate.indexOf(" ")+1);
				var dayMonthSlashPos:int = date.indexOf("/");
				var monthYearSlashPos:int = date.lastIndexOf("/");
				var month:String = date.substring(0, dayMonthSlashPos);
				if (month.length == 1) { month = 0 + month; }
				var day:String = date.substring(dayMonthSlashPos + 1, monthYearSlashPos);
				if (day.length == 1) { day = 0 + day; }
				var year:String = date.substring(monthYearSlashPos + 1);
				
				//time
				var buildAfterNoon:Boolean = (time.indexOf("PM") != -1) ? true : false;
				var hour:String = String( int(time.substring(0, time.indexOf(":"))) + (buildAfterNoon ? 12 : 0));
				if (hour.length == 1) { hour = 0 + hour; }
				var minute:String = time.substring(time.indexOf(":") + 1, time.indexOf(" "));
				if (minute.length == 1) {  minute = 0 + minute; }	
				versionInfo.text = StringUtil.substitute("ppppuNX version {0} Build Number {1} Build Date: {2}", AppVersionNX.VERSION, AppVersionNX.BUILDNUMBER, buildDate);
			}
			dispatchEvent(e);
		}
		
		private function FailedLoadingXML(e:IOErrorEvent):void
		{
			config.removeEventListener(Event.COMPLETE, FinishedLoadingXML);
			config.removeEventListener(IOErrorEvent.IO_ERROR, FailedLoadingXML);
			//signal2.removeAllSlots();
			//signal2 = null;
			config = null;
			dispatchEvent(e);
		}
		
		/*public function onSignal2(targetName:*, value:*):void
		{
		}
		
		public function ClickEventHandler(target:Object):void
		{
		}
		
		public function ChangeEventHandler(target:Object):void
		{
			
		}
		public function SelectEventHandler(target:Object):void
		{
		}*/
		
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