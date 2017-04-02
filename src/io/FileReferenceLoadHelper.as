package io 
{
	import com.jacksondunstan.signals.Signal2;
	import com.jacksondunstan.signals.Slot2;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.ByteArray;

	//Handles saving files and browsing for files to load from the local filesystem. Actual loading of files is to be handled by LoaderMax.
	public class FileReferenceLoadHelper
	{
		private var fr:FileReference = new FileReference();
		/*
		 * Expect handler to be in form:
		 *	 handler(e:MediaLoadedEvent) : void
		 */
		//private var handler:Function;
		private var signal2:Signal2 = new Signal2();
		public function FileReferenceLoadHelper(slot:Slot2, filterText:String = "Any", filterPattern:String = "*.*") 
		{
			//handler = _handler;

			fr.addEventListener(Event.SELECT, fileSelected);
			var filter:FileFilter = new FileFilter(filterText, filterPattern);
			signal2.addSlot(slot);
			fr.browse([filter]);
			
			
		}
		
		private function fileSelected(e:Event):void 
		{
			fr.removeEventListener(Event.SELECT, fileSelected);
			fr.addEventListener(Event.COMPLETE, fileLoaded);
			fr.load();
		}
		
		private function fileLoaded(e:Event):void 
		{
			fr.removeEventListener(Event.COMPLETE, fileLoaded);
			
			signal2.dispatch("FileLoaded", [fr.data,fr.name]);
			fr = null;
			signal2.removeAllSlots();
			signal2 = null;
			//var bl:ByteLoader = new ByteLoader();
			
			//bl.addEventListener(ByteArrayLoadedEvent.LOADED, handler);
			//bl.load(fr.data);
		}
		
	}

}