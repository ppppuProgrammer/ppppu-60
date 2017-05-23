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
			
			animationPresets[animationPresets.length] = ["Cowgirl", true, "Female (Standard)", true, "Male (Standard)", false, "Crown", false, "Left Earring", false, "Right Earring", false, "Left Eye Variant 2", false, "Right Eye Variant 2", false, "Mouth Variant 2", false, "Rosalina Hair", false, "Body Variant 1"];
			animationPresets[animationPresets.length] = ["Anim2",true,"Female (Standard)",true,"Male (Standard)",false,"Crown",false,"Left Earring",false,"Right Earring",false,"Left Eye Variant 2",false,"Mouth Variant 2",false,"Right Eye Variant 2",false,"Rosalina Hair"];
			animationPresets[animationPresets.length] = ["anim3",true,"Female (Standard)",true,"Male (Standard)",true,"Left Eyebrow Variant 2",true,"Right Eyebrow Variant 2",false,"Crown",false,"Left Earring",false,"Right Earring",false,"Face ver2",false,"Left Eye (ver2)",false,"Mouth (ver2)",false,"Right Eye (ver2)",false,"Rosalina Hair (ver2)"];
			animationPresets[animationPresets.length] = ["Anim4",true,"Female (Standard)",true,"Male (Standard)",true,"Left Eye (Standard)",false,"Crown",false,"Left Earring",false,"Right Earring",false,"Mouth Variant 2",false,"Right Eye Variant 2",false,"Rosalina Hair"];
			animationPresets[animationPresets.length] = ["Reverse Cowgirl",true,"Female (Standard)",true,"Male (Standard)",true,"Left Eye (Standard)",false,"Crown",false,"Left Earring",false,"Right Earring",false,"Mouth Variant 2",false,"Right Eye Variant 2",false,"Rosalina Hair"];
			animationPresets[animationPresets.length] = ["Paizuri",true,"Female (Standard)",true,"Male (Standard)",true,"Mouth (Standard)",false,"Crown",false,"Left Earring",false,"Right Earring",false,"Left Eye Variant 2",false,"Right Eye Variant 2",false,"Rosalina Hair"];
			animationPresets[animationPresets.length] = ["Blowjob",true,"Female (Standard)",true,"Male (Standard)",false,"Crown",false,"Left Earring",false,"Right Earring",false,"Left Eye Variant 2",false,"Right Eye Variant 2",false,"Rosalina Hair"];
			animationPresets[animationPresets.length] = ["Anim8",true,"Female (Standard)",true,"Male (Standard)",false,"Crown",false,"Left Earring",false,"Right Earring",false,"Mouth Variant 2",false,"Left Eye Variant 2",false,"Right Eye Variant 2",false,"Rosalina Hair"];
			animationPresets[animationPresets.length] = ["Anim9",true,"Female (Standard)",true,"Male (Standard)",false,"Crown",false,"Left Earring",false,"Right Earring",false,"Left Eye Variant 2",false,"Right Eye Variant 2",false,"Mouth Variant 2",false,"Rosalina Hair"];
			//characterData.preferredMusic = "BeepBlockSkyway";
			//characterData.DiamondULColor = 0x000000;
			//characterData.DiamondCenterColor = 0x000000;
			//characterData.DiamondBRColor = 0x000000;
			//characterData.DiamondULColor = 0x000000;
			//characterData.BackgroundColor = 0x000000;
		}
		
	}
	
}