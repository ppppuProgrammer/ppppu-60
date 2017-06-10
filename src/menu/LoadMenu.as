package menu 
{
	import com.lorentz.SVG.display.SVGDocument;
	import com.lorentz.SVG.display.base.SVGElement;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.IGraphicsData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.bit101.utils.MinimalConfigurator;
	import flash.errors.IOError;
	import flash.events.IOErrorEvent;
	import com.jacksondunstan.signals.Signal2;
	import com.jacksondunstan.signals.Slot2;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.*;
	import flash.net.FileReference;
	import io.FileReferenceLoadHelper;
	import io.FileReferenceListLoadHelper;
	import io.LoadedFileData;
	import modifications.Mod;
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
				var svgFileData:Vector.<LoadedFileData> = value as Vector.<LoadedFileData>;
				if (svgFileData == null) { return; }
				
				var file:LoadedFileData;
				for (var j:int = 0,k:int = svgFileData.length; j < k; j++) 
				{
					file = svgFileData[j] as LoadedFileData;
					var fileBytes:ByteArray = file.data;
					var fileName:String = file.name;
					if (fileBytes && fileName)
					{
						var svgString:String = fileBytes.readUTFBytes(fileBytes.length);
						
						//var rect:Rectangle = spr.getBounds(spr);
						var signalData:MessageData = new MessageData();
						//var svgFileName:String = value[1] as String;
						fileName = fileName.slice(0, fileName.indexOf(".svg"));
						var nameParts:Array = fileName.split("_");
						if (nameParts.length >= 3)
						{
							//set name for the svg
							signalData.stringData[0] = nameParts[0] as String;
							var svgActor:String = nameParts[1];
							//signalData.stringData[1] = nameParts[1] as String;
							//layer that the asset will be assigned to for their actor
							signalData.intData[0] = int(nameParts[2]);
							
							if (nameParts.length >= 4)
							{
								var svgActorExtensions:Array;
								svgActorExtensions = (nameParts[3] as String).split("-");
								for (var i:int = 0,l:int = svgActorExtensions.length; i < l; i++) 
								{
									var svg:SVGDocument = new SVGDocument();  
									svg.parse(svgString);  
									
									signalData.stringData[signalData.stringData.length] = svgActor + svgActorExtensions[i];
									signalData.spriteData[signalData.spriteData.length] = svg;
								}
							}
							else
							{
								var svg:SVGDocument = new SVGDocument();  

								svg.parse(svgString);  
								signalData.stringData[signalData.stringData.length] = svgActor;
								signalData.spriteData[signalData.spriteData.length] = svg;
							}
						}
						
						signal2.dispatch("LoadMenu_LoadedSVGAsset", signalData);
					}
				}
			}
			else if (command == "SWFModLoaded")
			{
				var swfFileData:Vector.<LoadedFileData> = value as Vector.<LoadedFileData>;
				if (swfFileData == null) { return; }
				
				var file:LoadedFileData;
				
				for (var i:int = 0,l:int = swfFileData.length; i < l; i++) 
				{
					file = swfFileData[i];
					var fileBytes:ByteArray = file.data;
					if (fileBytes)
					{
						var swfLoader:Loader = new Loader();
						swfLoader.loadBytes(fileBytes);
						swfLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, FinishedAsyncSWFLoading);
					}
				}
			}
		}
		
		private function FinishedAsyncSWFLoading(e:Event):void
		{
			var content:DisplayObject = e.target.content;
			var loader:Loader = e.target.loader as Loader;
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, FinishedAsyncSWFLoading);
			
			if (content is Mod)
			{
				//Allow mod to do any first frame activities.
				addChild(content);
				removeChild(content);
				signal2.dispatch("LoadMenu_ProcessMod", content);				
			}
			loader.unload();
		}
		
		public function ClickEventHandler(target:Object):void
		{
			//var targetName:String = target["name"];
			if (target.name == "loadSVGAssetBtn")
			{
				var svgFile:FileReferenceListLoadHelper = new FileReferenceListLoadHelper(this, "Scalable Vector Graphics files (*.svg)", "*.svg", "SVGLoaded");
			}
			else if (target.name == "loadModBtn")
			{
				var modFile:FileReferenceListLoadHelper = new FileReferenceListLoadHelper(this, "PPPPU NX SWF Mod (*.swf)", "*.swf", "SWFModLoaded");
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