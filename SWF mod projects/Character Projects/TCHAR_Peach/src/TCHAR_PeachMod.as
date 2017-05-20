package
{
	//import characters.ColorValueMaster;
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
			characterData.Color.Hair = 0xFFE81AFF;
			characterData.Color.HairAngled = 0xFEB60DFF;
			characterData.Color.Lip = 0xFF99CCFF;
			characterData.Color.Legging = [0xECC6FFFF, 0xE0A6FCFF];
			//var skinGradientEndPoint:ColorValueMaster = new ColorValueMaster(UtilityFunctions.GetColorUintValue(243, 182, 154, 255));
			
			//var standardGradientEndPoint:uint = UtilityFunctions.GetColorUintFromRGB(243,182,154);
			characterData.Color.Eyelid = 0xF0A586FF;
			characterData.Color.Nipple = 0xFFAFFFFF;
			characterData.Color.Areola = [0xFFAFFFFF, 0xFFAFFF00];
			characterData.Color.Face = [0xFFDCC6FF, {ID: "SkinGradient", Color: UtilityFunctions.GetColorUintValue(243, 182, 154, 255)}];//2
			characterData.Color.Ear = [{ID: "SkinGradient", Color: UtilityFunctions.GetColorUintValue(243, 182, 154, 255)}, 0xFFDCC6FF];//2
			characterData.Color.Breast = [0xFFDCC6FF,0xFFDCC6FF, {ID: "SkinGradient", Color: UtilityFunctions.GetColorUintValue(243, 182, 154, 255)}];//3
			characterData.Color.Vulva = [0xF3B69AFF,0xFFDCC6FF];//2
			
			//characterData.Color.Anus = [UtilityFunctions.GetColorUintValue(255, 166, 159), 0xFFDCC6];//2
			
			characterData.GraphicSets = ["Standard", "Headwear_Peach", "Earring_Peach", "Hair_Peach"];
			animationPresets[animationPresets.length] = ["Cowgirl", true, "Female_Taker", true, "Male_Giver", false, "Peach Hair", false, "Peach Left Eye", false, "Peach Right Eye", false, "Peach Mouth", false, "Crown", false, "Right Earring ", false, "Left Earring"];
			animationPresets[animationPresets.length] = ["Anim2", true, "Male", true, "Female", false, "Peach EyeL", false, "Peach Hair", false, "Peach Mouth", false, "Peach EyeR", false, "Crown", false, "EarringL", false, "EarringR"];
			animationPresets[animationPresets.length] = ["anim3", true, "Male", true, "Female", true, "EyebrowL1", true, "EyebrowR1", false, "Peach Hair", false, "Peach EarringR", false, "Peach Mouth", false, "Peach EyeL", false, "Peach EarringL", false, "Peach Headwear", false, "Peach EyeR"];
			animationPresets[animationPresets.length] = ["Anim4",true,"Default EyeL",true,"Male",true,"Female",false,"Peach EyeR",false,"Peach EarringR",false,"Crown",false,"Peach Mouth",false,"EarringL",false,"Peach Hair"];
			animationPresets[animationPresets.length] = ["Reverse Cowgirl", true, "Female", true, "Male", true, "Left Eye", false, "Peach EarringL", false, "Peach Headwear", false, "Peach EarringR", false, "Peach Mouth", false, "Peach EyeR", false, "Peach Hair"];
			animationPresets[animationPresets.length] = ["Paizuri", true, "Female", true, "Male", true, "Mouth", false, "Peach Hair", false, "EarringR", false, "Peach EyeL", false, "Peach EyeR", false, "EarringL", false, "Crown"];
			animationPresets[animationPresets.length] = ["Blowjob", true, "Female_Taker", true, "Male_Giver", false, "Peach Hair", false, "Peach EyeL", false, "Peach EarringL", false, "Peach Headwear", false, "Peach EyeR", false, "Peach EarringR"];
			animationPresets[animationPresets.length] = ["Anim8",true,"Male",true,"Female",false,"Peach Hair",false,"EarringL",false,"Crown",false,"Peach EyeR",false,"EarringR",false,"Peach EyeL",false,"Peach Mouth"];
			animationPresets[animationPresets.length] = ["Anim9",true,"Male",true,"Female",false,"Crown",false,"Peach Mouth",false,"Peach EyeR",false,"EarringR",false,"Peach EyeL",false,"Peach Hair",false,"EarringL"];
			//characterData.ChangeableGfxSets = false;
			//characterData.preferredMusic = "BeepBlockSkyway";
			//characterData.DiamondULColor = 0x000000;
			//characterData.DiamondCenterColor = 0x000000;
			//characterData.DiamondBRColor = 0x000000;
			//characterData.DiamondULColor = 0x000000;
			//characterData.BackgroundColor = 0x000000;
		}
		
	}
	
}