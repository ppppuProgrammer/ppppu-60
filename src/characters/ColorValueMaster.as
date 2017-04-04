package characters
{
	/**
	 * ...
	 * @author 
	 */
	public class ColorValueMaster 
	{
		private var color:uint = 0x00000000; //In RRGGBBAA format
		private var linkedColorHolders:Vector.<ColorValueHolder> = new Vector.<ColorValueHolder>();
		private var linkIsActive:Boolean = true;
		public function ColorValueMaster(initColor:uint) 
		{
			color = initColor;
		}
		
		public function SetColor(newColor:uint):void
		{
			if (linkIsActive)
			{
				for (var i:int = 0, l:int = linkedColorHolders.length; i < l; i++) 
				{
					linkedColorHolders[i].SetColor(newColor);
				}
				color = newColor;
			}
		}
		
		public function GetIfLinkIsActive():Boolean
		{
			return linkIsActive;
		}
		
		public function CreateLinkedColorHolder():ColorValueHolder
		{
			var cvh:ColorValueHolder = new ColorValueHolder(color, this);
			linkedColorHolders[linkedColorHolders.length] = cvh;
			return cvh;
		}
		
		public function RemoveLinkedColorHolder(cvh:ColorValueHolder):Boolean
		{
			var result:Boolean = false;
			var index:int = linkedColorHolders.indexOf(cvh);
			if (index != -1)
			{
				linkedColorHolders = linkedColorHolders.splice(index, 1);
				result = true;
			}
			return result;
		}
		
	}

}