package characters 
{
	/**
	 * ...
	 * @author 
	 */
	public class ColorValueHolder
	{
		private var color:uint = 0x00000000; //In RRGGBBAA format
		private var colorValueMaster:ColorValueMaster;
		public function ColorValueHolder(initColor:uint, master:ColorValueMaster) 
		{
			color = initColor;
			colorValueMaster = master;
		}
		
		public function GetColor():uint
		{
			return color;
		}
		
		public function SetColor(newColor:uint):void
		{
			color = newColor;
			colorValueMaster.SetColor(color);
		}
		
		public function GetIfLinkIsActive():Boolean
		{
			return colorValueMaster.GetIfLinkIsActive();
		}
		
		
		
	}

}