package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
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
			
			characterData.Color.IrisColor = 0x36BDC1FF;
			characterData.Color.SkinColor = 0xFFDCC6FF;
			characterData.Color.SkinHighlightColor = 0xFFFFFFFF;
			characterData.Color.LipColor =  UtilityFunctions.GetColorUintValue(0xFF, 0x99, 0xCC, 51);// UtilityFunctions.CreateColorTransformFromHex(0xFF99CC, 51);
			characterData.Color.LeggingColor = [0xFFFFFFFF, 0xC5F7EBFF];	
			characterData.Color.SkinHighlightColor = 0xFFFFFFFF;
			//characterData.Color.HairColor = 0xF3B69AFF;
			//characterData.Color.HairAngledColor = 0xFEA972FF;//UtilityFunctions.GetColorUintValue(243, 182, 154, 255);
			characterData.Color.HairColor = 0xfffc7dFF;
			characterData.Color.HairAngledColor = 0xfea972FF;//UtilityFunctions.GetColorUintValue(243, 182, 154, 255);
			//var skinGradientEndPoint:ColorValueMasterColor = new ColorValueMaster(UtilityFunctions.GetColorUintValue(243, 182, 154, 255));
			
			//var standardGradientEndPoint:uintColor = UtilityFunctions.GetColorUintFromRGB(243,182,154);
			characterData.Color.ScleraColor = 0xFFFFFFFF;
			characterData.Color.EyelidColor = 0xF0A586FF;
			characterData.Color.NippleColor = 0xFFAFFFFF;
			characterData.Color.AreolaColor = [0xFFAFFFFF, 0xFFAFFF00];
			characterData.Color.FaceColor = [0xFFDCC6FF, UtilityFunctions.GetColorUintValue(243, 182, 154, 255)];//2
			characterData.Color.EarColor = [UtilityFunctions.GetColorUintValue(243, 182, 154, 255), 0xFFDCC6FF];//2
			characterData.Color.BreastColor = [0xFFDCC6FF,0xFFDCC6FF, UtilityFunctions.GetColorUintValue(243, 182, 154, 255)];//3
			characterData.Color.VulvaColor = [0xF3B69AFF,0xFFDCC6FF];//2
			characterData.Color.AnusColor = [UtilityFunctions.GetColorUintValue(255, 166, 159, 255), 0xFFDCC6FF];//2
			characterData.Color.SkinLineColor = 0x7A2810FF;
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
			//Linked group 4 (Iris) is 54, 189, 193 or 0x36BDC1
			characterData.LinkedColorGroup.LeftIrisColor = [4,-1,-1,-1];
			characterData.LinkedColorGroup.RightIrisColor = [4,-1,-1,-1];
			
			characterData.GraphicSets = ["Standard", "Headwear_Rosalina", "Earring_Rosalina", "Hair_Rosalina"];
			
			animationPresets[animationPresets.length] = ["Cowgirl", 0, true, "Female (Standard)", true, "Male (Standard)", false, "Crown", false, "Left Earring", false, "Right Earring", false, "Left Eye Variant 2", false, "Right Eye Variant 2", false, "Mouth Variant 2", false, "Rosalina Hair", false, "Body Variant 1"];
			animationPresets[animationPresets.length] = ["Anim2", 0,true,"Female (Standard)",true,"Male (Standard)",false,"Crown",false,"Left Earring",false,"Right Earring",false,"Left Eye Variant 2",false,"Mouth Variant 2",false,"Right Eye Variant 2",false,"Rosalina Hair"];
			animationPresets[animationPresets.length] = ["anim3", 0,true,"Female (Standard)",true,"Male (Standard)",true,"Left Eyebrow Variant 2",true,"Right Eyebrow Variant 2",false,"Crown",false,"Left Earring",false,"Right Earring",false,"Face ver2",false,"Left Eye (ver2)",false,"Mouth (ver2)",false,"Right Eye (ver2)",false,"Rosalina Hair (ver2)"];
			animationPresets[animationPresets.length] = ["Anim4", 0,true,"Female (Standard)",true,"Male (Standard)",true,"Left Eye (Standard)",false,"Crown",false,"Left Earring",false,"Right Earring",false,"Mouth Variant 2",false,"Right Eye Variant 2",false,"Rosalina Hair"];
			animationPresets[animationPresets.length] = ["Reverse Cowgirl", 0,true,"Female (Standard)",true,"Male (Standard)",true,"Left Eye (Standard)",false,"Crown",false,"Left Earring",false,"Right Earring",false,"Mouth Variant 2",false,"Right Eye Variant 2",false,"Rosalina Hair"];
			animationPresets[animationPresets.length] = ["Paizuri", 0,true,"Female (Standard)",true,"Male (Standard)",true,"Mouth (Standard)",false,"Crown",false,"Left Earring",false,"Right Earring",false,"Left Eye Variant 2",false,"Right Eye Variant 2",false,"Rosalina Hair"];
			animationPresets[animationPresets.length] = ["Blowjob", 0, true, "Female (Standard)", true, "Male (Standard)", false, "Crown", false, "Left Earring", false, "Right Earring", false, "Left Eye Variant 2", false, "Right Eye Variant 2", false, "Rosalina Hair"];
			animationPresets[animationPresets.length] = ["Anim8", 0,true,"Female (Standard)",true,"Male (Standard)",false,"Crown",false,"Left Earring",false,"Right Earring",false,"Mouth Variant 2",false,"Left Eye Variant 2",false,"Right Eye Variant 2",false,"Rosalina Hair"];
			animationPresets[animationPresets.length] = ["Anim9", 0,true,"Female (Standard)",true,"Male (Standard)",false,"Crown",false,"Left Earring",false,"Right Earring",false,"Left Eye Variant 2",false,"Right Eye Variant 2",false,"Mouth Variant 2",false,"Rosalina Hair"];
			characterData.PreferredMusic = "BeepBlockSkyway";
			//var rosalinaBackgroundElementsColorTransform:ColorTransform = new ColorTransform(0.62, 1.0, 1.0, 1.0, -59, 22, 102);
			characterData.Color.ODiamondColor1 = 0x618EE9FF;
			characterData.Color.IDiamondColor1 = characterData.Color.TDiamondColor1 = 0x63F7FFFF;
			characterData.Color.IDiamondColor2 = characterData.Color.TDiamondColor2 = 0x62D8FFFF;
			characterData.Color.IDiamondColor3 = characterData.Color.TDiamondColor3 = 0x62B5FFFF;
			characterData.Color.IDiamondColor4 = characterData.Color.TDiamondColor4 = 0x62D8FFFF;
			characterData.Color.TDiamondColor5 = 0x618EE9FF;
			characterData.Color.BackLight = [0x63E866FF, 0x63E26600];//99,232,102 to 99, 226, 102
		}
		
	}
	
}