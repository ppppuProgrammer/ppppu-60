package
{
	import characters.ColorValueMaster;
	import flash.display.Sprite;
	import flash.events.Event;
	import modifications.TemplateCharacterMod
	//import UtilityFunctions;
	/**
	 * ...
	 * @author 
	 */
	public class TCHAR_PeachMod extends TemplateCharacterMod 
	{
		
		public function TCHAR_PeachMod() 
		{
			characterName = "Peach";
			
			characterData.Color.Iris = 0x3671C1FF;
			characterData.Color.Skin = 0xFFDCC6FF;
			characterData.Color.SkinHighlight = 0xFFFFFFFF;
			characterData.Color.Hair = 0xFEB60DFF;
			characterData.Color.Lip = 0xFF99CCFF
			characterData.Color.Legging = [0xECC6FFFF, 0xE0A6FCFF];
			var skinGradientEndPoint:ColorValueMaster = new ColorValueMaster(UtilityFunctions.GetColorUintValue(243, 182, 154, 255));
			
			//var standardGradientEndPoint:uint = UtilityFunctions.GetColorUintFromRGB(243,182,154);
			characterData.Color.Eyelid = 0xF0A586FF;
			characterData.Color.Nipple = 0xFFAFFFFF;
			characterData.Color.Areola = [0xFFAFFFFF, 0xFFAFFF00];
			characterData.Color.Face = [0xFFDCC6FF, skinGradientEndPoint.CreateLinkedColorHolder()];//2
			characterData.Color.Ear = [skinGradientEndPoint.CreateLinkedColorHolder(), 0xFFDCC6FF];//2
			characterData.Color.Breast = [0xFFDCC6FF,0xFFDCC6FF, skinGradientEndPoint.CreateLinkedColorHolder()];//3
			characterData.Color.Vulva = [0xF3B69AFF,0xFFDCC6FF];//2
			
			characterData.skinGradient_Anus = [UtilityFunctions.GetColorUintValue(255, 166, 159), 0xFFDCC6];//2
			
			//characterData.preferredMusic = "BeepBlockSkyway";
			//characterData.DiamondULColor = 0x000000;
			//characterData.DiamondCenterColor = 0x000000;
			//characterData.DiamondBRColor = 0x000000;
			//characterData.DiamondULColor = 0x000000;
			//characterData.BackgroundColor = 0x000000;
		}
		
	}
	
}