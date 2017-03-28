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
		private var _shard:AnimateShard;
		public function ShardItem(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, data:Object=null) 
		{
			super(parent, xpos, ypos, data);
			
		}
		
		override public function set data(value:Object):void
		{
			if (value == "")
			{
				_data = value;
				_shard = null;
			}
			else
			{
			_data = value.displayName;
			_shard = value.shard;
			}
			invalidate();
		}
		override public function get data():Object
		{
			return _data;
		}
		
		public function get shard():AnimateShard
		{
			return _shard;
		}
		
		
	}

}