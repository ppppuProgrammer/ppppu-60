package
{
	import animations.AnimationList;
	import flash.display.Sprite;

	/**
	 * Contains various data that is to be sent through signals.
	 * @author 
	 */
	public class MessageData 
	{
		public var intData:Vector.<int>;
		public var uintData:Vector.<uint>;
		public var floatData:Vector.<Number>;
		public var boolData:Vector.<Boolean>;
		public var stringData:Vector.<String>;
		public var animationListData:Vector.<AnimationList>;
		public var spriteData:Vector.<Sprite>;
		public function MessageData() 
		{
			intData = new Vector.<int>();
			uintData = new Vector.<uint>();
			floatData = new Vector.<Number>();
			boolData = new Vector.<Boolean>();
			stringData = new Vector.<String>();
			animationListData = new Vector.<AnimationList>();
			spriteData = new Vector.<Sprite>();
		}
		
	}
}