package menu 
{
	import com.bit101.components.ListItem;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author 
	 */
	public class GUISliderItem extends ListItem 
	{
		//Sprite to show when this item is selected.
		protected var _sprite:Sprite;
		//String to use for the slider's label when this item is selected.
		protected var _displayName:String;
		
		public function GUISliderItem(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, data:Object=null) 
		{
			super(parent, xpos, ypos, data);
			
		}
		
		override public function set data(value:Object):void
		{
			if (value == "")
			{
				_data = value;
				if (_sprite && _sprite.parent != null)
				{
					_sprite.parent.removeChild(_sprite);
				}
				_sprite = null;
				_displayName = "";
			}
			else
			{
				_data = value;
				_sprite = value.displayImage as Sprite;
				_displayName = value.displayName as String;
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
		
		public function get sprite():Sprite { return _sprite; }
		
		public function get displayName():String { return _displayName; }
		
		
		
	}

}