package animations
{
	import flash.display.Sprite;
	import animations.DispObjInfo;
	/**
	 * Used to keep track of what elements are used in an animation, where they are positioned depth wise, and any frame in which
	 * either an element's visibility or depth changes.
	 * @author 
	 */
	public class AnimationLayout 
	{
		/*Used for when there is a change in how the elements in an animation are arranged. Typically this vector is only 1 in length.
		* Holds a custom class that is a vector wrapper.*/
		public var frameVector:Vector.<LayoutFrameVector> = new Vector.<LayoutFrameVector>();
		public function AnimationLayout() 
		{
			
		}
		public function AddNewFrameVector(time:Number, dispInfoVector:Vector.<DispObjInfo>/*, animationCanvas:Sprite*/):void
		{
			frameVector[frameVector.length] = new LayoutFrameVector(time, dispInfoVector/*, animationCanvas*/);
		}
	}

}