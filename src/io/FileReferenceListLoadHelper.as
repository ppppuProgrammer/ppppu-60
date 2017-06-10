package io
{
	import com.jacksondunstan.signals.Signal2;
	import com.jacksondunstan.signals.Slot2;
	import flash.display.Bitmap;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;
	import flash.utils.ByteArray;

	//Handles saving files and browsing for files to load from the local filesystem. Actual loading of files is to be handled by LoaderMax.
	public class FileReferenceListLoadHelper
	{
		private var fr:FileReferenceList = new FileReferenceList();
		/*
		 * Expect handler to be in form:
		 *	 handler(e:MediaLoadedEvent) : void
		 */
		//private var handler:Function;
		private var signal2:Signal2 = new Signal2();
		private var finishedMesssage:String;
		private var filesPending:Vector.<FileReference>;
		private var filesLoadedSuccessfully:Vector.<FileReference>;
		public function FileReferenceListLoadHelper(slot:Slot2, filterText:String = "Any", filterPattern:String = "*.*", loadMessage:String="FilesLoaded") 
		{
			//handler = _handler;
			finishedMesssage = loadMessage;
			fr.addEventListener(Event.SELECT, FilesSelected);
			var filter:FileFilter = new FileFilter(filterText, filterPattern);
			signal2.addSlot(slot);
			fr.browse([filter]);
			
			
		}
		
		private function FilesSelected(e:Event):void 
		{
			fr.removeEventListener(Event.SELECT, FilesSelected);
			filesPending = new Vector.<FileReference>();
			filesLoadedSuccessfully = new Vector.<FileReference>();
			for (var i:int = 0,l:int = fr.fileList.length; i < l; i++) 
			{
				var fileRef:FileReference = (fr.fileList[i] as FileReference);
				filesPending[filesPending.length] = fileRef;
				fileRef.addEventListener(Event.COMPLETE, FileLoaded);
				fileRef.addEventListener(IOErrorEvent.IO_ERROR, FileLoadError);
				fileRef.load();
			}
			//fr.addEventListener(Event.COMPLETE, FilesLoaded);
			//fr.load();
		}
		
		private function FileLoaded(e:Event):void
		{
			var fileRef:FileReference = (e.target) as FileReference;
			filesLoadedSuccessfully[filesLoadedSuccessfully.length] = fileRef;
			RemovePendingFile(fileRef);
		}
		
		private function FileLoadError(e:IOErrorEvent):void
		{
			RemovePendingFile((e.target) as FileReference);
		}
		
		private function FinishedLoadingAllFiles():void 
		{
			//fr.removeEventListener(Event.COMPLETE, FilesLoaded);
			var dataForFiles:Vector.<LoadedFileData> = new Vector.<LoadedFileData>();
			for (var i:int = 0, l:int = filesLoadedSuccessfully.length; i < l; i++) 
			{
				dataForFiles[dataForFiles.length] = new LoadedFileData(filesLoadedSuccessfully[i].data, filesLoadedSuccessfully[i].name);
			}
			filesPending = null;
			filesLoadedSuccessfully = null;
			signal2.dispatch(finishedMesssage, dataForFiles);
			finishedMesssage = null;
			dataForFiles = null;
			fr = null;
			signal2.removeAllSlots();
			signal2 = null;
			
			
			//var bl:ByteLoader = new ByteLoader();
			
			//bl.addEventListener(ByteArrayLoadedEvent.LOADED, handler);
			//bl.load(fr.data);
		}
		
		private function RemovePendingFile(fileRef:FileReference)
		{
			fileRef.removeEventListener(Event.COMPLETE, FileLoaded);
			fileRef.removeEventListener(IOErrorEvent.IO_ERROR, FileLoadError);
			var fileIndex:int = filesPending.indexOf(fileRef);
			if (fileIndex > -1){
				filesPending.splice(fileIndex, 1);
			}
			
			if (filesPending.length == 0){
				FinishedLoadingAllFiles();
			}
			
		}
		
	}

}