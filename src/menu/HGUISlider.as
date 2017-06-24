package menu 
{
	import com.bit101.components.HUISlider;
	import com.bit101.components.List;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * A slider intended to display a certain graphic depending on the value of the slider. Holds a list of items that contain data such as the graphic to display, a name associate with the graphic. Does not accept a handler function.
	 * @author 
	 */
	public class HGUISlider extends HUISlider 
	{
		protected var _list:List;
		protected var _items:Array;
		protected var _displayBox:Sprite;
		protected var _displaySize:Number = 32;
		//protected var 
		public function HGUISlider(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, label:String="", items:Array = null) 
		{
			super(parent, xpos, ypos, label, null);
			_items = items;
		}
		
		public override function draw():void
		{
			
			//displaySize = Math.round(displaySize / 0.05) * 0.05;
			//Line width is to be 4% of the display size, capped at 1 minimum and 6 maximum.
			var lineWidth:Number = 2;//Math.max(1, Math.min(displaySize * .04, 6));
			
			_displayBox.graphics.clear();
			_displayBox.graphics.beginFill(0xFFFFFF);
			_displayBox.graphics.drawRect(0, 0, displaySize, displaySize);
			_displayBox.graphics.endFill();
			_displayBox.graphics.lineStyle(lineWidth, 0x000000);
			//_displayBox.graphics.beginFill(0x000000);
			//Draw a border around the filled box
			var lineLeft_Top:Number= 0-(lineWidth/2);
			var lineBottom_Right:Number= displaySize+(lineWidth/2);
			_displayBox.graphics.moveTo(lineLeft_Top, lineLeft_Top);
			_displayBox.graphics.lineTo(lineBottom_Right, lineLeft_Top);
			_displayBox.graphics.lineTo(lineBottom_Right, lineBottom_Right);
			_displayBox.graphics.lineTo(lineLeft_Top, lineBottom_Right);
			_displayBox.graphics.lineTo(lineLeft_Top, lineLeft_Top);
			_displayBox.graphics.endFill();
			
			_displayBox.x = -(_displayBox.width+lineWidth);
			_displayBox.y =  lineWidth;
			
			
			maximum = _list.items.length-1;
			//minimum = (_slider.maximum > 0) ? 1 : 0;
			
			/*if (_list.selectedIndex == -1)
			{
				_list.selectedIndex = (_slider.minimum > 0) ? 0 : -1;
				value = _list.selectedIndex + 1;
			}*/
			//value = _list.selectedIndex + 1;
			
			_displayBox.removeChildren();
			var listItem:Object = _list.selectedItem;
			if (listItem != null)
			{				
				var icon:Sprite = listItem.displayImage as Sprite;
				if (icon)
				{
					if (icon.width > icon.height)
					{
						icon.width = _displaySize * .85;
						icon.scaleY = icon.scaleX;
					}
					else
					{
						icon.height = _displaySize * .85;
						icon.scaleX = icon.scaleY;
					}
					
					//Get the bounds of the sprite
					var spriteBounds:Rectangle = icon.getBounds(icon);
					//Using the reg point and bounds, calculate the position of the registration point as a percentage of the sprite.
					var regPointWidthPercent:Number = Math.abs((0 -spriteBounds.left) / (spriteBounds.right - spriteBounds.left));// ((100 / spriteBounds.width) * regPoint.x) * .01;
					var regPointHeightPercent:Number = Math.abs((0-spriteBounds.top) / (spriteBounds.bottom - spriteBounds.top));//((100 / spriteBounds.height) * regPoint.y) * .01;

					icon.x = (_displayBox.width - icon.width)/2 + (icon.width * regPointWidthPercent);
					icon.y = (_displayBox.height - icon.height)/2 + (icon.height * regPointHeightPercent);

							
					_displayBox.addChild(icon);
				}
			}
			
			//Need to update the slider value label in HUISlider.
			super.draw();
		}
		
		//Modified code from the min comp library below
		
		/**
		 * Sets / gets the current value of this slider.
		 */
		override public function set value(v:Number):void
		{
			if (v > _list.items.length - 1) v = _list.items.length-1;
			_slider.value = v;
			formatValueLabel();
			selectedIndex = v;
			invalidate();
			//dispatchEvent(new Event(Event.CHANGE));
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		protected override function addChildren():void
		{
			super.addChildren();
			_list = new List(null, 0, 0, _items);
			_list.autoHideScrollBar = true;
			_list.addEventListener(Event.SELECT, onSelect);
			
			
			_displayBox = new Sprite();
			addChild(_displayBox);
			//_displayBox.addChild(new Sprite());
			//_displayBox.getChildAt(0).name = "_content";
			
			
			//_labelButton = new PushButton(this, 0, 0, "", onDropDown);
			//_dropDownButton = new PushButton(this, 0, 0, "+", onDropDown);
		}
		
		/**
		 * Called when an item in the list is selected. Displays that item in the label button.
		 */
		protected function onSelect(event:Event):void
		{
			//_open = false;
			//_dropDownButton.label = "+";
			/*if(stage != null && stage.contains(_list))
			{
				stage.removeChild(_list);
			}*/
			//setLabelButtonLabel();
			dispatchEvent(event);
		}
		
		
		//Unmodified code copied from the min comp library below this point
		/**
		 * Adds an item to the list.
		 * @param item The item to add. Can be a string or an object containing a string property named label.
		 */
		public function addItem(item:Object):void
		{
			_list.addItem(item);
			_slider.maximum++;
			invalidate();
		}
		
		/**
		 * Adds an item to the list at the specified index.
		 * @param item The item to add. Can be a string or an object containing a string property named label.
		 * @param index The index at which to add the item.
		 */
		public function addItemAt(item:Object, index:int):void
		{
			_list.addItemAt(item, index);
			_slider.maximum++;
			invalidate();
		}
		
		/**
		 * Removes the referenced item from the list.
		 * @param item The item to remove. If a string, must match the item containing that string. If an object, must be a reference to the exact same object.
		 */
		public function removeItem(item:Object):void
		{
			_list.removeItem(item);
			_slider.maximum--;
			invalidate();
		}
		
		/**
		 * Removes the item from the list at the specified index
		 * @param index The index of the item to remove.
		 */
		public function removeItemAt(index:int):void
		{
			_list.removeItemAt(index);
			_slider.maximum--;
			invalidate();
		}
		
		/**
		 * Removes all items from the list.
		 */
		public function removeAll():void
		{
			_list.removeAll();
			_slider.maximum = 0;
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function get displaySize():Number { return _displaySize; }
		public function set displaySize(value:Number):void 
		{
			_displaySize = value;
		}
		
		/**
		 * Sets / gets the index of the selected list item.
		 */
		public function set selectedIndex(value:int):void
		{
			//Slider will feed the value into this function but will constantly activate the function since sliders internally use a Number for value.
			//This causes the the slider to lock because the invalidate will constantly force a redraw. 
			//To prevent this, the value must be a different integer number from the current selected index;
			//if (_list.selectedIndex != value)
			//{
				_list.selectedIndex = value;
				invalidate();
				dispatchEvent(new Event(Event.CHANGE));
				
			//}
			//setLabelButtonLabel();
		}
		public function get selectedIndex():int
		{
			return _list.selectedIndex;
		}
		
		/**
		 * Sets / gets the item in the list, if it exists.
		 */
		public function set selectedItem(item:Object):void
		{
			_list.selectedItem = item;
			//invalidate();
			//setLabelButtonLabel();
		}
		public function get selectedItem():Object
		{
			return _list.selectedItem;
		}
		
		/**
		 * Sets/gets the default background color of list items.
		 */
		public function set defaultColor(value:uint):void
		{
			_list.defaultColor = value;
		}
		public function get defaultColor():uint
		{
			return _list.defaultColor;
		}
		
		/**
		 * Sets/gets the selected background color of list items.
		 */
		public function set selectedColor(value:uint):void
		{
			_list.selectedColor = value;
		}
		public function get selectedColor():uint
		{
			return _list.selectedColor;
		}
		
		/**
		 * Sets/gets the rollover background color of list items.
		 */
		public function set rolloverColor(value:uint):void
		{
			_list.rolloverColor = value;
		}
		public function get rolloverColor():uint
		{
			return _list.rolloverColor;
		}
		
		/**
		 * Sets the height of each list item.
		 */
		public function set listItemHeight(value:Number):void
		{
			_list.listItemHeight = value;
			//invalidate();
		}
		public function get listItemHeight():Number
		{
			return _list.listItemHeight;
		}
		
		/**
		 * Sets / gets the label that will be shown if no item is selected.
		 */
		/*public function set defaultLabel(value:String):void
		{
			_defaultLabel = value;
			setLabelButtonLabel();
		}
		public function get defaultLabel():String
		{
			return _defaultLabel;
		}*/
		
		/**
		 * Sets / gets the list of items to be shown.
		 */
		public function set items(value:Array):void
		{
			_list.items = value;
			//_slider.maximum = value.length;
			invalidate();
		}
		
		public function get items():Array
		{
			return _list.items;
		}
		
		/**
		 * Sets / gets the class used to render list items. Must extend ListItem.
		 */
		public function set listItemClass(value:Class):void
		{
			_list.listItemClass = value;
		}
		public function get listItemClass():Class
		{
			return _list.listItemClass;
		}
		
		
		/**
		 * Sets / gets the color for alternate rows if alternateRows is set to true.
		 */
		public function set alternateColor(value:uint):void
		{
			_list.alternateColor = value;
		}
		public function get alternateColor():uint
		{
			return _list.alternateColor;
		}
		
		/**
		 * Sets / gets whether or not every other row will be colored with the alternate color.
		 */
		public function set alternateRows(value:Boolean):void
		{
			_list.alternateRows = value;
		}
		public function get alternateRows():Boolean
		{
			return _list.alternateRows;
		}

        /**
         * Sets / gets whether the scrollbar will auto hide when there is nothing to scroll.
         */
        public function set autoHideScrollBar(value:Boolean):void
        {
            _list.autoHideScrollBar = value;
            invalidate();
        }
        public function get autoHideScrollBar():Boolean
        {
            return _list.autoHideScrollBar;
        }
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		/**
		 * Handler called when the slider's value changes.
		 * @param event The Event passed by the slider.
		 */
		override protected function onSliderChange(event:Event):void
		{
			//super.onSliderChange(event);
			formatValueLabel();
			selectedIndex = event.currentTarget.value;
			dispatchEvent(new Event(Event.CHANGE));
		}
	}

}