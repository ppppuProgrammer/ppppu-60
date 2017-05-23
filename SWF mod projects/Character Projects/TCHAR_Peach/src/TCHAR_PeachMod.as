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
			animationPresets[animationPresets.length] = ["Cowgirl", true, "Female (Standard)", true, "Male (Standard)", false, "Crown", false, "Left Earring", false, "Right Earring", false, "Left Eye Variant 1", false, "Right Eye Variant 1", false, "Mouth Variant 1", false, "Peach Hair"];
			animationPresets[animationPresets.length] = ["Anim2", true, "Female (Standard)", true, "Male (Standard)", false, "Crown", false, "Left Earring", false, "Right Earring", false, "Left Eye Variant 1", false, "Mouth Variant 1", false, "Right Eye Variant 1", false, "Peach Hair"];
			animationPresets[animationPresets.length] = ["anim3",true,"Female (Standard)",true,"Male (Standard)",true,"Left Eyebrow Variant 1",true,"Right Eyebrow Variant 1",false,"Crown",false,"Left Earring",false,"Right Earring",false,"Right Eye Variant 1",false,"Left Eye Variant 1",false,"Mouth Variant 1",false,"Peach Hair"];
			animationPresets[animationPresets.length] = ["Anim4", true, "Female (Standard)", true, "Male (Standard)", true, "Left Eye (Standard)", false, "Crown", false, "Left Earring", false, "Right Earring", false, "Mouth Variant 1", false, "Right Eye Variant 1", false, "Peach Hair"];
			animationPresets[animationPresets.length] = ["Reverse Cowgirl",true,"Female (Standard)",true,"Male (Standard)",true,"Left Eye (Standard)",false,"Crown",false,"Left Earring",false,"Right Earring",false,"Mouth Variant 1",false,"Right Eye Variant 1",false,"Peach Hair"];
			animationPresets[animationPresets.length] = ["Paizuri",true,"Female (Standard)",true,"Male (Standard)",true,"Mouth (Standard)",false,"Crown",false,"Left Earring",false,"Right Earring",false,"Left Eye Variant 1",false,"Right Eye Variant 1",false,"Peach Hair"];
			animationPresets[animationPresets.length] = ["Blowjob",true,"Female (Standard)",true,"Male (Standard)",false,"Crown",false,"Left Earring",false,"Right Earring",false,"Left Eye Variant 1",false,"Right Eye Variant 1",false,"Peach Hair"];
			animationPresets[animationPresets.length] = ["Anim8",true,"Female (Standard)",true,"Male (Standard)",false,"Crown",false,"Left Earring",false,"Right Earring",false,"Left Eye Variant 1",false,"Mouth Variant 1",false,"Right Eye Variant 1",false,"Peach Hair"];
			animationPresets[animationPresets.length] = ["Anim9",true,"Female (Standard)",true,"Male (Standard)",false,"Crown",false,"Left Earring",false,"Right Earring",false,"Left Eye Variant 1",false,"Right Eye Variant 1",false,"Mouth Variant 1",false,"Peach Hair"];
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