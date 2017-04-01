package io 
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.ByteArray;

	public class FileReferenceSaveHelper 
	{
		private var fr:FileReference = new FileReference();
		/*
		 * Expect handler to be in form:
		 *	 handler(e:MediaLoadedEvent) : void
		 */
		private var handler:Function;
		//public static const DATA_BINARY:int = 1;
		public static const DATA_TEXT:int = 0;
		public function FileReferenceSaveHelper(_handler:Function, data:*, defaultFileName:String=null) 
		{
			handler = _handler;
			//fr.addEventListener(Event.SELECT, fileSelected);
			//var filter:FileFilter = new FileFilter(filterText, filterPattern);
			//if (dataType == DATA_BINARY)
			//{
				var binaryData:ByteArray = new ByteArray();
				binaryData.writeObject(data);
				fr.save(binaryData, defaultFileName);
			//}
			/*else
			{
				fr.save(data, defaultFileName);
			}*/
			
		}
		
		/*private function fileSelected(e:Event):void 
		{
			fr.removeEventListener(Event.SELECT, fileSelected);
			fr.addEventListener(Event.COMPLETE, fileLoaded);
			fr.load();
		}
		
		private function fileLoaded(e:Event):void 
		{
			fr.removeEventListener(Event.COMPLETE, fileLoaded);
			
			var bl:ByteLoader = new ByteLoader();
			bl.addEventListener(ByteArrayLoadedEvent.LOADED, handler);
			bl.load(fr.data);
		}
		
		private function fileSave(e:Event):void 
		{
			var bl:ByteLoader = new ByteLoader();
			bl.addEventListener(ByteArrayLoadedEvent.LOADED, handler);
			bl.load(fr.data);
		}*/
		
	}

}