package animations 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author 
	 */
	public class AnimateShardLibrary 
	{
		//The collection objects are vectors, one for the base shards and the other for additional type shards. The vectors index correspond to the id of an animation. In each vector's index is a dictionary that will be the actual container for animate shards. Shards will be inserted into the dictionary by their name (or a hashed int for optimal performance).
		
		/*Contains the default timelines for an animation.*/
		private var baseShardsCollection:Vector.<Dictionary> = new Vector.<Dictionary>();
		
		private var additionalShardsCollection:Vector.<Dictionary> = new Vector.<Dictionary>();
		
		private var shardInformationDict:Dictionary = new Dictionary();
		
		public function AnimateShardLibrary() 
		{
			baseShardsCollection[0] = new Dictionary();
			additionalShardsCollection[0] = new Dictionary();
		}
		
		public function AddShardToLibrary(animationId:int, shard:AnimateShard, shardName:String, baseShard:Boolean):void
		{
			var targetCollection:Vector.<Dictionary> = baseShard ? baseShardsCollection : additionalShardsCollection;
			//Create enough new indexes in the targetted collection so an index for the animationId exists.
			while (animationId > targetCollection.length)
			{
				targetCollection[targetCollection.length] = new Dictionary();
			}
			//baseTimelinesCollection.insertAt(animationID, timelines);
			targetCollection[animationId][shardName] = shard;
			
			//var 
			//shardInformationDict[shard] = "";
			//if (baseShardsCollection.length > 0) { HasValidBaseTimeline = true;}
		}
		
		public function GetListOfShardNames(animationId:int, getBaseShards:Boolean):Vector.<String>
		{
			var targetCollection:Vector.<Dictionary> = getBaseShards ? baseShardsCollection : additionalShardsCollection;
			var shardNameList:Vector.<String> = new Vector.<String>();
			var dict:Dictionary = targetCollection[animationId];
			var shardName:String;
			for (shardName in dict) 
			{
				shardNameList[shardNameList.length] = shardName;
			}
			return shardNameList;
		}
		
		public function GetShard(animationId:int, shardTypeIsBase:Boolean, shardName:String):AnimateShard
		{
			var targetCollection:Vector.<Dictionary> = shardTypeIsBase ? baseShardsCollection : additionalShardsCollection;
			
			var shard:AnimateShard = targetCollection[animationId][shardName];
			return shard;
		}
		
		public function SetInformationForShard(shard:AnimateShard, info:String):void
		{
			shardInformationDict[shard] = info;
		}
		
		public function GetInformationOnShard(shard:AnimateShard):String
		{
			return shardInformationDict[shard];
		}
		
		//public function GetShardsFromLists
		
	}

}