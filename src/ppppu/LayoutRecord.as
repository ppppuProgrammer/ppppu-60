package ppppu 
{
	import flash.display.Sprite;
	/**
	 * Simple class that holds data relating to what depth an element is at.
	 * @author 
	 */
	public class LayoutRecord 
	{
		public var element:Sprite;
		//Used in case the element was not found at the time of the layout object being created. This is used to search for the element in the compositor.
		public var expectedElementName:String;
		public var depth:Number;
		public function LayoutRecord(sprite:Sprite, layerDepth:Number, searchName:String) 
		{
			element = sprite; depth = layerDepth; expectedElementName = searchName;
		}
		
	}

}