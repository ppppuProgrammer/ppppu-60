package menu 
{
	import com.lorentz.SVG.display.SVGDocument;
	import com.lorentz.SVG.display.base.SVGElement;
	import flash.display.Graphics;
	import flash.display.IGraphicsData;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.bit101.utils.MinimalConfigurator;
	import flash.errors.IOError;
	import flash.events.IOErrorEvent;
	import com.jacksondunstan.signals.Signal2;
	import com.jacksondunstan.signals.Slot2;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import io.FileReferenceLoadHelper;
	/**
	 * ...
	 * @author 
	 */
	public class LoadMenu extends Sprite implements Slot2, ISubMenu
	{
		private var config:MinimalConfigurator;
		private var signal2:Signal2;
		
		CONFIG::release {
			[Embed(source="LoadMenuDefinition.xml",mimeType="application/octet-stream")]
			private var menuDefinitionClass:Class;
		}
		
		public function LoadMenu() 
		{
			name = "Load Menu";
			signal2 = new Signal2;
		}
		
		public function InitializeMenu(app:AppCore):void
		{
			config = new MinimalConfigurator(this);
			CONFIG::NX
			{
			app.SetupMenuHooks(null, this);
			signal2.addSlot(app);
			}
			config.addEventListener(Event.COMPLETE, FinishedLoadingXML);
			config.addEventListener(IOErrorEvent.IO_ERROR, FailedLoadingXML);

			CONFIG::debug {
				config.loadXML("../src/menu/LoadMenuDefinition.xml");
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
					//ChangeEventHandler(value as Object);
				}
			}
			else if (command == "SelectEvent")
			{
				if (!value) { return;}
				var compName:String = (value as Object)["name"];
				if (config.getCompById(compName) != null)
				{
					//SelectEventHandler(value as Object);
				}
			}
			else if (command == "SVGLoaded")
			{
				var fileBytes:ByteArray = value[0] as ByteArray;
				var fileName:String = value[1] as String;
				if (fileBytes && fileName)
				{
					var svgString:String = fileBytes.readUTFBytes(fileBytes.length);
					var svg:SVGDocument = new SVGDocument();  
					svg.forceSynchronousParse = true;
					svg.autoAlign = true;
					//svg.svgTransform
					svg.parse(svgString);  
					//var svgE:SVGElement = svg.getElementAt(0);
					//svgE.viewPortElement.svgX = "-245";
					//svgE.viewPortElement.svgY = "-24";
					//svg.getChildAt(0).x = -245/2;
					//svg.getChildAt(0).y = -24/2;
					//svg.x = -245/2;
					//svg.y = -24/2;
					//stage.addChild(svg);
					//var gfx:Vector.<IGraphicsData> = svg.graphics.readGraphicsData();
					//stage.removeChild(svg);
					var matrix:Matrix = new Matrix(1, 0, 0, 1, -245.05, -27.6);
					svg.transform.matrix = matrix;
					var spr:Sprite = new Sprite;
					spr.addChild(svg);
					//stage.addChild(svg);
					//stage.removeChild(svg);
					//var sprite:Sprite = new Sprite();
					//sprite.addChild(svg);
					var rect:Rectangle = spr.getBounds(spr);
					signal2.dispatch("LoadMenu_LoadedSVGAsset", [spr, fileName]);
					//addChild(svg);  
				}
			}
		}
		
		public function ClickEventHandler(target:Object):void
		{
			//var targetName:String = target["name"];
			if (target.name == "loadSVGAssetBtn")
			{
				var svgFile:FileReferenceLoadHelper = new FileReferenceLoadHelper(this, "Scalable Vector Graphics (*.svg)", "*.svg", "SVGLoaded");
			}
			/*else if (target.name == "previewMusicButton")
			{
				var musicSelectDroplist:ComboBox = config.getCompById("musicSelectDroplist") as ComboBox;
				if (musicSelectDroplist)
				{
					signal2.dispatch("MusicMenu_PreviewMusic", musicSelectDroplist.selectedIndex);
				}
			}*/

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