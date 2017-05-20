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
	public class TCHAR_RosalinaMod extends TemplateCharacterMod 
	{
		
		public function TCHAR_RosalinaMod() 
		{
			characterName = "Rosalina";
			
			characterData.Color.Iris = 0x36BDC1FF;
			characterData.Color.Skin = 0xFFDCC6FF;
			characterData.Color.Lip =  UtilityFunctions.CreateColorTransformFromHex(0xFF99CC, 51);
			characterData.Color.Legging = [0xFFFFFFFF, 0xC5F7EBFF];	
			characterData.Color.SkinHighlight = 0xFFFFFFFF;
			//characterData.Color.Hair = 0xF3B69AFF;
			//characterData.Color.HairAngled = 0xFEA972FF;//UtilityFunctions.GetColorUintValue(243, 182, 154, 255);
			characterData.Color.Hair = 0xfffc7dFF;
			characterData.Color.HairAngled = 0xfea972FF;//UtilityFunctions.GetColorUintValue(243, 182, 154, 255);
			//var skinGradientEndPoint:ColorValueMaster = new ColorValueMaster(UtilityFunctions.GetColorUintValue(243, 182, 154, 255));
			
			//var standardGradientEndPoint:uint = UtilityFunctions.GetColorUintFromRGB(243,182,154);
			characterData.Color.Eyelid = 0xF0A586FF;
			characterData.Color.Nipple = 0xFFAFFFFF;
			characterData.Color.Areola = [0xFFAFFFFF, 0xFFAFFF00];
			characterData.Color.Face = [0xFFDCC6FF, {ID: "SkinGradientEnd", Color: UtilityFunctions.GetColorUintValue(243, 182, 154, 255)}];//2
			characterData.Color.Ear = [{ID: "SkinGradientEnd", Color: UtilityFunctions.GetColorUintValue(243, 182, 154, 255)}, 0xFFDCC6FF];//2
			characterData.Color.Breast = [0xFFDCC6FF,0xFFDCC6FF, {ID: "SkinGradientEnd", Color: UtilityFunctions.GetColorUintValue(243, 182, 154, 255)}];//3
			characterData.Color.Vulva = [0xF3B69AFF,0xFFDCC6FF];//2
			characterData.Color.Anus = [UtilityFunctions.GetColorUintValue(255, 166, 159, 255), 0xFFDCC6FF];//2
			
			characterData.GraphicSets = ["Standard", "Headwear_Rosalina", "Earring_Rosalina", "Hair_Rosalina"];
			
			animationPresets[animationPresets.length] = ["Cowgirl",true,"Female_Taker",true,"Male_Giver",false,"Rosalina Body",false,"Rosalina Right Eye",false,"Rosalina Mouth",false,"Rosalina Left Eye",false,"Crown",false,"Right Earring ",false,"Left Earring",false,"Rosalina Hair"];
			//animationPresets[animationPresets.length] =
			animationPresets[animationPresets.length] = ["anim3", true, "Male", true, "Female", true, "EyebrowL2", true, "EyebrowR2", false, "Rosalina Headwear", false, "Rosalina EyeL", false, "Rosalina EarringR", false, "Rosalina EarringL", false, "Rosalina Mouth", false, "Rosalina Face", false, "Rosalina Hair", false, "Rosalina EyeR"];
			//animationPresets[animationPresets.length] = 
			animationPresets[animationPresets.length] = ["Reverse Cowgirl", true, "Male", true, "Female", false, "Rosalina Mouth", false, "Rosalina EarringL", false, "Rosalina EyeL", false, "Rosalina Hair", false, "Rosalina Headwear", false, "Rosalina EarringR", false, "Rosalina EyeR", true, "Left Eye"];
			animationPresets[animationPresets.length] = ["Paizuri",true,"Female",true,"Mouth",true,"Male",false,"Rosalina EyeR",false,"EarringL",false,"Rosalina EyeL",false,"Crown",false,"EarringR",false,"Rosalina Hair"];
			//animationPresets[animationPresets.length] = 
			//animationPresets[animationPresets.length] = 
			//animationPresets[animationPresets.length] = 
			//characterData.preferredMusic = "BeepBlockSkyway";
			//characterData.DiamondULColor = 0x000000;
			//characterData.DiamondCenterColor = 0x000000;
			//characterData.DiamondBRColor = 0x000000;
			//characterData.DiamondULColor = 0x000000;
			//characterData.BackgroundColor = 0x000000;
		}
		
	}
	
}