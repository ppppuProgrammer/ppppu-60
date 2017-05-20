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
	public class TCHAR_ShantaeMod extends TemplateCharacterMod 
	{
		
		public function TCHAR_ShantaeMod() 
		{
			characterName = "Shantae";
			
			//var skinGradientEndPoint:ColorValueMaster = new ColorValueMaster(0xA4703CFF);
			
			//var commonSkinColor:ColorValueMaster = new ColorValueMaster(0xD39363FF);
			
			
			characterData.Color.Iris = 0x1788CDFF;
			characterData.Color.Skin = {ID: "Skin", Color: 0xD39363FF};
			characterData.Color.SkinHighlight = 0xDDAC88FF;
			characterData.Color.Hair = 0x9003A4FF;
			characterData.Color.Lip = UtilityFunctions.CreateColorTransformFromHex(0xFFC9D8FF, 51);
			characterData.Color.Legging = [0xFF0000FF, 0xFFFFFFFF];
			
			//var standardGradientEndPoint:uint = UtilityFunctions.GetColorUintFromRGB(243,182,154);
			characterData.Color.Eyelid = 0xD19561FF;
			characterData.Color.Nipple = 0xD76420FF;
			characterData.Color.Areola = [0xD76420FF, 0xD7642000];
			characterData.Color.Face = [{ID: "Skin", Color: 0xD39363FF}, {ID: "SkinGradientEnd", Color: 0xA4703CFF}];//2
			characterData.Color.Ear = [{ID: "SkinGradientEnd", Color: 0xA4703CFF}, {ID: "Skin", Color: 0xD39363FF}];//2
			characterData.Color.Breast = [{ID: "Skin", Color: 0xD39363FF},0xE88E5CFF, {ID: "SkinGradientEnd", Color: 0xA4703CFF}];//3
			characterData.Color.Vulva = [0xC86D64FF, { ID: "Skin", Color: 0xD39363FF } ];//2
			
			characterData.GraphicSets = ["Standard"];
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