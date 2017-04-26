package menu 
{
	import com.bit101.components.ListItem;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * Specialized item to be used for horizontal lists (which are just normal lists with a rotation of 270 and scaleX multiplied by -1)
	 * @author 
	 */
	public class HorizontalListItem extends ListItem 
	{
		
		public function HorizontalListItem(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, data:Object=null) 
		{
			super(parent, xpos, ypos, data);
			this.scaleX *= -1;
			this.rotation = 270
		}
		
		
		
	}

}