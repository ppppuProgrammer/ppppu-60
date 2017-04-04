package animations
{
	import flash.net.registerClassAlias;
	/**
	 * Hold references to many shards that are used to form a complete animation. Used to have presets for animations. 
	 * @author 
	 */
	public class AnimationList 
	{
		//The animation this animation list is for.
		private var targetAnimationName:String;
		private var shardNameList:Vector.<String>;
		private var shardTypeList:Vector.<Boolean>;
		public static const ANIMATION_LIST_VERSION:int = 1;
		public var version:int = ANIMATION_LIST_VERSION;
		
		public function AnimationList(/*animationName:String, shardNames:Vector.<String>*/) 
		{
			//Need to do this so the shard name list will be serialized as a vector<String> instead of vector<object>
			registerClassAlias("String", String);
			registerClassAlias("Boolean", Boolean);
			//targetAnimationName = animationName;
			//shardNameList = shardNames;
		}
		public function get TargetAnimationName():String { return targetAnimationName; }
		public function get ShardNameList():Vector.<String> { return shardNameList; }
		public function get ShardTypeList():Vector.<Boolean> { return shardTypeList; }
		public function set TargetAnimationName(value:String):void 
		{
			targetAnimationName = value;
		}
		
		public function set ShardNameList(value:Vector.<String>):void 
		{
			shardNameList = value;
		}
		
		public function set ShardTypeList(value:Vector.<Boolean>):void 
		{
			shardTypeList = value;
		}
		
	}

}