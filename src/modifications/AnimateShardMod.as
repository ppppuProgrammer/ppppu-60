package modifications 
{
	import animations.DispObjInfo;
	
	/**
	 * Mod base class that will be used to define an AnimateShard, which is a group of tweens used to build an animation.
	 * @author 
	 */
	public class AnimateShardMod implements IModdable 
	{
		//Name of the animation the AnimateShard is for.
		protected var targetAnimationName:String;
		//A list of strings that define one or more categories that the animate shard falls into.
		protected var categories:Vector.<String> = new Vector.<String>();
		// Holds the various objects that hold data used to manipulate Display Objects
		protected var timelinesData:Vector.<Object> = new Vector.<Object>();
		protected var displayObjectOrders:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
		//The name of the shard.
		protected var shardName:String;
		//Used to determine if this shard has timelines for base graphics of an animation. Timelines in a base shard have lower priority when a collision between timelines controlling the same graphic element occurs.
		protected var isBaseShard = false;
		//A optional description of what the AnimateShard is for and what it will affect or add.
		protected var shardDescription:String;
		public function AnimateShardMod() 
		{
			
		}
		
		/* INTERFACE modifications.IModdable */
		
		public function OutputModDetails():String 
		{
			
		}
		
	}

}