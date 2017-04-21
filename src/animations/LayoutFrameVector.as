package animations 
{
	import flash.display.Sprite;
	import animations.DispObjInfo;
	/**
	 * Wraps around a vector to be able to provide what frame the vector is to be used for.
	 * @author 
	 */
	public class LayoutFrameVector 
	{
		public var changeTime:Number;
		public var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
		//public var overrideDataList:Vector.<Object>;
		public function LayoutFrameVector(time:Number, vector:Vector.<DispObjInfo>/*, overrideList:Vector.<Object>*/) 
		{
			changeTime = time;
			dispInfo = vector;
			//overrideDataList = overrideList;
		}
		
	}

}