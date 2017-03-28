package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import modifications.TemplateCharacterMod
	//import UtilityFunctions;
	/**
	 * ...
	 * @author 
	 */
	public class TCHAR_RosalinaMod extends TemplateCharacterMod 
	{
		
		public function TCHAR_RosalinaMod() 
		{
			characterName = "Rosalina";
			
			characterData.Color.Iris = 0x36BDC1;
			characterData.Color.Skin = 0xFFDCC6;
			characterData.Color.Lip =  UtilityFunctions.CreateColorTransformFromHex(0xFF99CC, 51);
			characterData.Color.Leggings = [0xFFFFFFFF, 0xC5F7EBFF];
			//var standardGradientEndPoint:uint = UtilityFunctions.GetColorUintFromRGB(243,182,154);
			//characterData.skinGradient_Face = [0xFFDCC6, standardGradientEndPoint];//2
			//characterData.sSkinGradient_Breasts = [0xFFDCC6,0xFFDCC6, standardGradientEndPoint];//3
			//characterData.skinGradient_Vulva = [standardGradientEndPoint,0xFFDCC6];//2
			//characterData.skinGradient_Anus = [UtilityFunctions.GetColorUintFromRGB(255, 166, 159), 0xFFDCC6];//2
			//characterData.preferredMusic = "BeepBlockSkyway";
			//characterData.DiamondULColor = 0x000000;
			//characterData.DiamondCenterColor = 0x000000;
			//characterData.DiamondBRColor = 0x000000;
			//characterData.DiamondULColor = 0x000000;
			//characterData.BackgroundColor = 0x000000;
		}
		
	}
	
}