package animations 
{
	import org.libspark.betweenas3.core.tweens.groups.SerialTween;
	/**
	 * Holds various data that will be used to construct part of an tween controlled animation. Shards are intended to be used to segment different parts of a whole animation, to help facilitate tween reuse and easy animation modifications.
	 * @author 
	 */
	public class AnimateShard 
	{
		//The timelines (a series of tweens that are to move a specified display object) for the shard.
		private var timelines:Vector.<SerialTween>;
		private var displayObjectData:Vector.<DispObjInfo>;
		public function AnimateShard(timelineTweens:Vector.<SerialTween>, dispObjInfoVector:Vector.<DispObjInfo>) 
		{
			timelines = timelineTweens;
			displayObjectData = dispObjInfoVector;
		}
		
		public function GetTimelines():Vector.<SerialTween>
		{
			return timelines;
		}
		
		public function GetDispObjData():Vector.<DispObjInfo>
		{
			return displayObjectData;
		}
		
	}

}