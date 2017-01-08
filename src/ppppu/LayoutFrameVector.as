package ppppu 
{
	import flash.display.Sprite;
	/**
	 * Wraps around a vector to be able to provide what frame the vector is to be used for.
	 * @author 
	 */
	public class LayoutFrameVector 
	{
		public var changeTime:Number;
		public var layoutVector:Vector.<LayoutRecord> = new Vector.<LayoutRecord>();
		public function LayoutFrameVector(time:Number, layoutObj:Object, animationCanvas:Sprite) 
		{
			changeTime = time;
			
			for (var key:String in layoutObj)
			{
				var element:Sprite = animationCanvas[key];
				layoutVector[layoutVector.length] = new LayoutRecord(element as Sprite, layoutObj[key] as Number, key as String);
			}
			
			//Sort the depths now
			var arraySize:int = layoutVector.length;
			var gap:int = arraySize;
			var shrinkFactor:Number = 1.3;
			var swapped:Boolean = false;
			var swapHolder:LayoutRecord;
			var compElementDepth1:Number;
			var compElementDepth2:Number;
			while (gap != 1 || swapped)
			{
				gap = int(gap / shrinkFactor);
				if (gap < 1) { gap = 1; }
			
				var i:int = 0;
				swapped = false;
				
				while (i + gap < arraySize)
				{
					compElementDepth1 = layoutVector[i].depth;
					compElementDepth2 = layoutVector[i + gap].depth;
					if (compElementDepth1 > compElementDepth2)
					{
						swapHolder = layoutVector[i];
						layoutVector[i] = layoutVector[i + gap];
						layoutVector[i + gap] = swapHolder;
						swapped = true;
					}
					if (compElementDepth1 == compElementDepth2)
					{
						swapped = true;
					}
					++i;
				}
			}
		}
		
	}

}