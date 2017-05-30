package  
{
	import characters.ColorValueHolder;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.IGraphicsData;
	import flash.display.GraphicsGradientFill;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.utils.Dictionary;
	/**
	 * Handles changing the colors of a group of Sprites
	 * @author 
	 */
	public class Colorizer 
	{
		
		//A dictionary for holding groups of Sprites that can undergo color changes. Key is the group name and Value is a vector with Sprites.
		private var colorizeGroups:Dictionary = new Dictionary();
		//Holds references of sprites that contains a gradient fill as the key and the value is data there just to exist (an int of 0)
		private var gradientSprites:Dictionary = new Dictionary();
		public function Colorizer() 
		{
			
		}
		
		public function AddColorizeData(baseSprite:Sprite, colorizeData:Object):void
		{
			var targets:Array=[];
			var groups:Array=[];
			if ("Target" in colorizeData)
			{
				if (colorizeData.Target is Array)
				{targets = colorizeData.Target as Array; }
				else if (colorizeData.Target is String)
				{targets[0] = colorizeData.Target as String; }
			}
			if ("Group" in colorizeData)
			{
				if (colorizeData.Group is Array)
				{groups = colorizeData.Group as Array; }
				else if (colorizeData.Group is String)
				{groups[0] = colorizeData.Group as String; }				
			}
			
			//Iterate through the arrays. Will always stop at the length of the shortest array.
			var groupName:String;
			var child:Sprite;
			var colorizeList:Vector.<Sprite>;
			for (var i:int = 0, tl:int = targets.length, gl:int = groups.length; i < tl && i < gl; i++) 
			{
				groupName = groups[i];
				if (!(groupName in colorizeGroups))
				{
					colorizeGroups[groupName] = new Vector.<Sprite>();
				}
				colorizeList = colorizeGroups[groupName] as Vector.<Sprite>;
				
				//There are multiple sprites to be added to the particular group 
				if (targets[i] is Array)
				{
					for (var j:int = 0, k:int = targets[i].length; j < k; j++) 
					{
						child = FindChildInSprite(baseSprite, targets[i][j] as String);
						if (child != null && colorizeList.indexOf(child) == -1)
						{
							colorizeList[colorizeList.length] = child;
							//Check to see if the sprite has a gradient fill.
							if (CheckIfColorizeTargetHasGradientFill(child))
							{
								gradientSprites[child] = true;
							}
						}
					}
				}
				else if (targets[i] is String)
				{
					child = FindChildInSprite(baseSprite, targets[i]);
					if (child != null && colorizeList.indexOf(child) == -1)
					{
						colorizeList[colorizeList.length] = child;
						//Check to see if the sprite has a gradient fill.
						if (CheckIfColorizeTargetHasGradientFill(child))
						{
							gradientSprites[child] = true;
						}
					}
				}
			}
			
		}
		
		private function FindChildInSprite(sprite:Sprite, childName:String):Sprite
		{
			//Break down childName into parts. Periods are used as string seperators.
			var searchTraversal:Array = childName.split(".");
			var result:Sprite = sprite;
			if (!result) { return null;}
			//If the "childName" is "this" then the entire sprite will be colorized.
			if ((searchTraversal[0] as String).toLowerCase() == "this")
			{return result; }	
				
			for (var i:int = 0, l:int = searchTraversal.length; i < l; i++) 
			{
				result = result.getChildByName(searchTraversal[i]) as Sprite;
				if (result == null)
				{
					//Child wasn't found
					break;
				}
			}
			
			return result;
		}
		
		public function ChangeColorsUsingCharacterData(ColorData:Object):void
		{
			for (var property:String in ColorData) 
			{
				
				var value:* = ColorData[property];
				if (property in colorizeGroups)
				{
					var spritesToColorize:Vector.<Sprite> = colorizeGroups[property] as Vector.<Sprite>;
					
					for (var i:int = 0, l:int = spritesToColorize.length; i < l; i++) 
					{
						ModifyColorOfSprite(spritesToColorize[i], value)
					}
				}
			}
		}
		
		private function CheckIfColorizeTargetHasGradientFill(sprite:Sprite):Boolean
		{
			var shapeToEdit:Shape = sprite as Shape;
			var navSprite:Sprite = sprite;
			var currentDispObject:DisplayObject;
			while (navSprite && navSprite.numChildren >= 1)
			{
				currentDispObject = navSprite.getChildAt(0);
				if (currentDispObject is DisplayObjectContainer)
				{
					navSprite = currentDispObject  as Sprite;
				}
				else if (currentDispObject is Shape)
				{
					shapeToEdit = currentDispObject as Shape;
					navSprite = null;
				}
				else
				{
					navSprite = null;
				}
			}
			if (!shapeToEdit) { return false; }
			
			var graphicsData:Vector.<IGraphicsData> = shapeToEdit.graphics.readGraphicsData(false);
			
			
			
			for (var i:uint = 0, l:uint = graphicsData.length; i < l; ++i)
			{
				if (graphicsData[i] is GraphicsGradientFill)
				{
					return true;
				}
			}
			return false;
		}
		
		
		/* Color Changing Functions */
		//{
		//Changes the color of a given sprite. colorValue
		private function ModifyColorOfSprite(sprite:Sprite, colorValue:*):void
		{
			var color:uint;
			if (gradientSprites[sprite] && colorValue is Array)
			{
				GradientChange(sprite, colorValue as Array);
			}
			else if ((colorValue as ColorTransform) != null)
			{
				sprite.transform.colorTransform = colorValue as ColorTransform;
			}
			else if (colorValue is uint)
			{
				color = colorValue as uint;
				sprite.transform.colorTransform = UtilityFunctions.CreateColorTransformFromHex(color >>> 8, color & 0xFF);
			}
			else if ("Color" in colorValue)
			{
				color = (colorValue as Object).Color;
				sprite.transform.colorTransform = UtilityFunctions.CreateColorTransformFromHex(color >>> 8, color & 0xFF);
			}
			else if (colorValue is ColorMatrixFilter)
			{
				sprite.filters = [colorValue as ColorMatrixFilter];
			}
		}
		
		//Changes the gradients of the shape in the given sprite. colorUIntValues is an array of uints for specified points of the gradients and are in 0xRRGGBBAA format.
		private function GradientChange(sprite:Sprite, colorUIntValues:Array):void
		{
			
			var shapeToEdit:Shape = sprite as Shape;
			if (sprite.numChildren >= 1)
			{
				shapeToEdit = sprite.getChildAt(0) as Shape;
			}
			var graphicsData:Vector.<IGraphicsData> = shapeToEdit.graphics.readGraphicsData(false);
			
			
			
			for (var i:uint = 0, l:uint = graphicsData.length; i < l; ++i)
			{
				if (graphicsData[i] is GraphicsGradientFill)
				{
					var gradientFill:GraphicsGradientFill = graphicsData[i] as GraphicsGradientFill;
					
					//Check if there are enough color values provided to properly set the gradient.
					if (gradientFill.colors.length > colorUIntValues.length)
					{
						return;
					}
					var color:uint;
					for (var x:int = 0, fillLength:int = gradientFill.colors.length; x < fillLength; ++x)
					{
						
						if (x < colorUIntValues.length)
						{
							if ("Color" in colorUIntValues[x])
							{
								color = (colorUIntValues[x] as Object).Color;
							}
							else
							{
								color = colorUIntValues[x];
							}
							
						}
						else //Ran out of value in colorUIntValues, keep feeding the gradientFill with the last value in colorUIntValues.
						{
							if ("Color" in colorUIntValues[colorUIntValues.length])
							{
								color = (colorUIntValues[colorUIntValues.length] as Object).Color;
							}
							else
							{
								color = colorUIntValues[colorUIntValues.length];
							}
						}
						gradientFill.colors[x] = color >>> 8; //Converts from RRGGBBAA to RRGGBB
						//Extracts the alpha value via bitwise AND operation then multiplies the result so the value ranges from 0 to 1
						gradientFill.alphas[x] = (color & 0xFF) * 0.3921568627450980392156862745098;
					}
					graphicsData[i] = gradientFill;
				}
			}
			
			shapeToEdit.graphics.clear();
			shapeToEdit.graphics.drawGraphicsData(graphicsData);
		}
		//}
		/* Color Changing Functions */
		
		/* Color Utility Functions */
		//{
		private function GetColorMatrixFilter(hue:Number, saturation:Number, brightness:Number, contrast:Number):ColorMatrixFilter
		{
			var colorMatrixValues:Array = new Array(1,0,0,0,0, 0,1,0,0,0, 0,0,1,0,0, 0,0,0,1,0);
			var hueDegrees:Number = hue * Math.PI / 180.0;
			var U:Number = Math.cos(hueDegrees); //For rotation around YIQ Y axis
			var W:Number = Math.sin(hueDegrees); //For rotation around YIQ Y axis
			//var S:Number = saturation;
			var V:Number = brightness;
			var C:Number = contrast;
			var VSU:Number = V*saturation*U; //To reduce the number of multiplication operations needed
			var VSW:Number = V*saturation*W; //To reduce the number of multiplication operations needed
			var cOffset:Number = 128 - C * 128;
			colorMatrixValues[0] = (.299*V + .701*VSU + .168*VSW)*C;
			colorMatrixValues[1] = (.587*V - .587*VSU + .330*VSW)*C;
			colorMatrixValues[2] = (.114*V - .114*VSU - .497*VSW)*C;
			//colorMatrixValues[3] = 0; //alpha offset
			colorMatrixValues[4] = cOffset;
			colorMatrixValues[5] = (.299*V - .299*VSU - .328*VSW)*C;
			colorMatrixValues[6] = (.587*V + .413*VSU + .035*VSW)*C;
			colorMatrixValues[7] = (.114*V - .114*VSU + .292*VSW)*C;
			//colorMatrixValues[8] = 0; //alpha offset
			colorMatrixValues[9] = cOffset;
			colorMatrixValues[10] = (.299*V - .3*VSU + 1.25*VSW)*C;
			colorMatrixValues[11] = (.587*V - .588*VSU - 1.05*VSW)*C;
			colorMatrixValues[12] = (.114*V + .886*VSU - .203*VSW)*C; 
			//colorMatrixValues[13] = 0; //alpha offset
			colorMatrixValues[14] = cOffset;
			//colorMatrixValues[15] = 0; //alpha
			//colorMatrixValues[16] = 0; //alpha
			//colorMatrixValues[17] = 0; //alpha
			//colorMatrixValues[18] = 0; //alpha offset
			//colorMatrixValues[19] = 0;
			return new ColorMatrixFilter(colorMatrixValues);
		}
		//}
		/* End of Color Utility Functions */
		
	}

}