package menu 
{
	import animations.AnimateShard;
	import com.bit101.components.ListItem;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * minimal component list item class to hold a reference to an AnimateShard and display the name for it.
	 * @author 
	 */
	public class ShardItem extends ListItem 
	{
		//Name of the shard
		private var _shardName:String;
		//The actual shard that the item is for.
		//private var _shard:AnimateShard;
		//The type of shard, used to denote the order priority of the shard. 0 is base, 1 is addition, -1 is invalid / not set
		private var _shardType:Boolean;
		public function ShardItem(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, data:Object=null) 
		{
			super(parent, xpos, ypos, data);
			
		}
		
		override public function set data(value:Object):void
		{
			if (value == "")
			{
				_data = value;
				//_shard = null;
				_shardName = null;
				_shardType = false;
			}
			else
			{
				//_shard = value.shard as AnimateShard;
				_shardType = value.type as Boolean;
				_shardName = value.name as String;
				//If shardType is -1, set display text to null. If type >= 0 then prefix display text with "Base: " (if 0) or "Add: " (if 1) and then tack on the shard name.
				//var displayText:String = 
				_data = (_shardName == null) ? null : (_shardType ? "Base: " : "Addition: ") + _shardName;
			}
			invalidate();
		}
		override public function get data():Object
		{
			return _data;
		}
		
		/*public function get shard():AnimateShard
		{
			return _shard;
		}*/
		
		public function get shardName():String { return _shardName; }
		
		public function get shardType():Boolean { return _shardType; }
		
		
	}

}