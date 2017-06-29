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
			
			//Will be used to create the LeftIrisColor and RightIrisColor groups
			characterData.Color.IrisColor = 0x3671C1FF;
			characterData.Color.SkinColor = 0xFFDCC6FF;
			characterData.Color.SkinHighlightColor = 0xFFFFFFFF;
			characterData.Color.HairColor = 0xFFE81AFF;
			characterData.Color.HairAngledColor = 0xFEB60DFF;
			characterData.Color.LipColor = 0xFF99CCFF;
			characterData.Color.LeggingColor = [0xECC6FFFF, 0xE0A6FCFF];
			//var skinGradientEndPoint:ColorValueMaster = new ColorValueMaster(UtilityFunctions.GetColorUintValue(243, 182, 154, 255));
			
			//var standardGradientEndPoint:uint = UtilityFunctions.GetColorUintFromRGB(243,182,154);
			characterData.Color.ScleraColor = 0xFFFFFFFF;
			characterData.Color.EyelidColor = 0xF0A586FF;
			characterData.Color.NippleColor = 0xFFAFFFFF;
			characterData.Color.AreolaColor = [0xFFAFFFFF, 0xFFAFFF00];
			characterData.Color.FaceColor = [0xFFDCC6FF, UtilityFunctions.GetColorUintValue(243, 182, 154, 255)];//2
			characterData.Color.EarColor = [UtilityFunctions.GetColorUintValue(243, 182, 154, 255), 0xFFDCC6FF];//2
			characterData.Color.BreastColor = [0xFFDCC6FF,0xFFDCC6FF, UtilityFunctions.GetColorUintValue(243, 182, 154, 255)];//3
			characterData.Color.VulvaColor = [0xF3B69AFF,0xFFDCC6FF];//2
			characterData.Color.SkinLineColor = 0x7A2810FF;
			characterData.Color.AnusColor = [UtilityFunctions.GetColorUintValue(255, 166, 159), 0xFFDCC6];//2
			characterData.Color.MaleSkinColor = 0xE6AE8AFF;
			
			//linked color group 1 (Skin 2) is for 243, 182, 154 or 0xF3B69A
			characterData.LinkedColorGroup.FaceColor = [ 2, 1, -1, -1];
			characterData.LinkedColorGroup.EarColor = [ 1, 2, -1, -1];
			characterData.LinkedColorGroup.BreastColor = [ 2, 2, 1, -1];
			//linked color group 2 (Skin) is for 255, 220, 198 or 0xFFDCC6
			characterData.LinkedColorGroup.VulvaColor = [1, 2, -1, -1];//2
			characterData.LinkedColorGroup.SkinColor = [2, -1, -1, -1];
			characterData.LinkedColorGroup.AnusColor = [ -1, 2, -1, -1];
			//linked group 3 is 255, 175, 255
			characterData.LinkedColorGroup.NippleColor = [3,-1,-1,-1];
			characterData.LinkedColorGroup.AreolaColor = [3, 3, -1, -1];
			//Linked group 4 (Iris) is 54, 113, 193, 255 or 0x3671C1FF
			characterData.LinkedColorGroup.LeftIrisColor = [4,-1,-1,-1];
			characterData.LinkedColorGroup.RightIrisColor = [4,-1,-1,-1];
			
			
			
			characterData.GraphicSets = ["Standard", "Headwear_Peach", "Earring_Peach", "Hair_Peach"];
			animationPresets[animationPresets.length] = ["Cowgirl", 0, true, "Female (Standard)", true, "Male (Standard)", false, "Crown", false, "Left Earring", false, "Right Earring", false, "Left Eye Variant 1", false, "Right Eye Variant 1", false, "Mouth Variant 1", false, "Peach Hair"];
			animationPresets[animationPresets.length] = ["Anim2", 0, true, "Female (Standard)", true, "Male (Standard)", false, "Crown", false, "Left Earring", false, "Right Earring", false, "Left Eye Variant 1", false, "Mouth Variant 1", false, "Right Eye Variant 1", false, "Peach Hair"];
			animationPresets[animationPresets.length] = ["anim3", 0,true,"Female (Standard)",true,"Male (Standard)",true,"Left Eyebrow Variant 1",true,"Right Eyebrow Variant 1",false,"Crown",false,"Left Earring",false,"Right Earring",false,"Right Eye Variant 1",false,"Left Eye Variant 1",false,"Mouth Variant 1",false,"Peach Hair"];
			animationPresets[animationPresets.length] = ["Anim4", 0, true, "Female (Standard)", true, "Male (Standard)", true, "Left Eye (Standard)", false, "Crown", false, "Left Earring", false, "Right Earring", false, "Mouth Variant 1", false, "Right Eye Variant 1", false, "Peach Hair"];
			animationPresets[animationPresets.length] = ["Reverse Cowgirl", 0,true,"Female (Standard)",true,"Male (Standard)",true,"Left Eye (Standard)",false,"Crown",false,"Left Earring",false,"Right Earring",false,"Mouth Variant 1",false,"Right Eye Variant 1",false,"Peach Hair"];
			animationPresets[animationPresets.length] = ["Paizuri", 0,true,"Female (Standard)",true,"Male (Standard)",true,"Mouth (Standard)",false,"Crown",false,"Left Earring",false,"Right Earring",false,"Left Eye Variant 1",false,"Right Eye Variant 1",false,"Peach Hair"];
			animationPresets[animationPresets.length] = ["Blowjob", 0,true,"Female (Standard)",true,"Male (Standard)",false,"Crown",false,"Left Earring",false,"Right Earring",false,"Left Eye Variant 1",false,"Right Eye Variant 1",false,"Peach Hair"];
			animationPresets[animationPresets.length] = ["Anim8", 0,true,"Female (Standard)",true,"Male (Standard)",false,"Crown",false,"Left Earring",false,"Right Earring",false,"Left Eye Variant 1",false,"Mouth Variant 1",false,"Right Eye Variant 1",false,"Peach Hair"];
			animationPresets[animationPresets.length] = ["Anim9", 0,true,"Female (Standard)",true,"Male (Standard)",false,"Crown",false,"Left Earring",false,"Right Earring",false,"Left Eye Variant 1",false,"Right Eye Variant 1",false,"Mouth Variant 1",false,"Peach Hair"];
			characterData.PreferredMusic = "BeepBlockSkyway";
			characterData.Color.ODiamondColor1 = 0xFC7883FF;
			characterData.Color.IDiamondColor1 = characterData.Color.TDiamondColor1 = 0xFFE1E3FF;
			characterData.Color.IDiamondColor2 = characterData.Color.TDiamondColor2 = 0xFEC2C7FF;
			characterData.Color.IDiamondColor3 = characterData.Color.TDiamondColor3 = 0xFD9FA7FF;
			characterData.Color.IDiamondColor4 = characterData.Color.TDiamondColor4 = 0xFEC2C7FF;
			characterData.Color.TDiamondColor5 = 0xFC7883FF;
			characterData.Color.BackLight = [0xFFD200FF, 0xFFCC0000];
		}
		
	}
	
}