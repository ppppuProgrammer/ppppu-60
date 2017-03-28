package  
{
	import flash.geom.ColorTransform;
	/**
	 * Holds various static functions that can be useful for various parts of the program. Due to their static nature, the use of
	 * these functions in performance critical code and used within functions called multiple times within a short period is discouraged.
	 * @author 
	 */
	public class UtilityFunctions 
	{
		
		/*public function UtilityFunctions() 
		{
			
		}*/
		
		private static function GetColorUintValue(red:uint=0, green:uint=0, blue:uint=0, alpha:uint = 255):uint
		{
			if (red > 0xFF) red = 0xFF; if (green > 0xFF) green = 0xFF; if (blue > 0xFF) blue = 0xFF; if (alpha > 0xFF) alpha = 0xFF;
			if (red < 0x00) red = 0x00; if (green < 0x00) green = 0x00; if (blue < 0x00) blue = 0x00; if (alpha < 0x00) alpha = 0x00;
			var colorValue:uint = 0;
			colorValue += (red << 24) + (green << 16) + (blue << 8) + alpha;
			return colorValue;
		}
		
		/*public static function GetColorUintFromRGBA(red:uint, green:uint, blue:uint. alpha:uint):uint
		{
			var colorValue:uint = 0;
			colorValue +=  (red << 24) + (green << 16) + (blue << 8) + alpha;
			return colorValue;
		}*/
		
		public static function GetColorUintFromRGB(red:uint, green:uint, blue:uint):uint
		{
			var colorValue:uint = 0;
			colorValue += (red << 16) + (green << 8) + blue;
			return colorValue;
		}
		
		public static function CreateColorTransformFromHex(colorValue:uint, alpha:uint = 255):ColorTransform
		{
			var ct:ColorTransform = new ColorTransform();
			ct.color = colorValue;
			if (alpha != 255)
			{
				if (alpha > 255) { alpha = 255; }
				ct.alphaMultiplier = 0;
				ct.alphaOffset = alpha;
			}
			return ct;
		}
		
	}

}