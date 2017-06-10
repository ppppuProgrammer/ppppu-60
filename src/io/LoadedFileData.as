package io 
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author 
	 */
	public class LoadedFileData 
	{
		public var data:ByteArray;
		public var name:String;
		public function LoadedFileData(fileData:ByteArray, fileName:String) 
		{
			data = fileData;
			name = fileName;
		}
		
	}

}