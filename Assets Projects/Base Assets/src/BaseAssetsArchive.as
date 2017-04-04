package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import modifications.AssetsMod;
	import modifications.ModArchive;
	
	/**
	 * ...
	 * @author 
	 */
	public class BaseAssetsArchive extends ModArchive 
	{
		
		public function BaseAssetsArchive() 
		{
			var skinColorProperties:Object = { Group: "Skin", Target: "Skin" };
			var skinWithHighlightColorProperties:Object = { Group: ["Skin", "SkinHighlight"], Target: ["Skin", "Highlight"] };
			/* Eye related */
			var eyeballColorProperties:Object = { Group: ["Iris", "Pupil"], Target: ["Iris", "Pupil"] };
			modsList[modsList.length] = new AssetsMod(new Eyeball, "EyeballL", { Colorable: eyeballColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Eyeball, "EyeballR", { Colorable: eyeballColorProperties } );
			
			var scleraColorProperties:Object = { Group: ["Eyelid", "Sclera"], Target: ["EyelidColor", "Color"] };
			modsList[modsList.length] = new AssetsMod(new Sclera, "ScleraL", { Colorable: scleraColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Sclera, "ScleraR", { Colorable: scleraColorProperties } );
			
			modsList[modsList.length] = new AssetsMod(new ClosedLash, "ClosedLashL");
			modsList[modsList.length] = new AssetsMod(new ClosedLash, "ClosedLashR");
			
			modsList[modsList.length] = new AssetsMod(new EyeMask, "EyeMaskL");
			modsList[modsList.length] = new AssetsMod(new EyeMask, "EyeMaskR");
			
			modsList[modsList.length] = new AssetsMod(new Eyelash, "EyelashL");
			modsList[modsList.length] = new AssetsMod(new Eyelash, "EyelashR");		
			
			modsList[modsList.length] = new AssetsMod(new Eyebrow, "EyebrowL");
			modsList[modsList.length] = new AssetsMod(new Eyebrow, "EyebrowR");
			
			var eyelidColorProperties:Object = { Group: "Eyelid", Target: "Color" };
			modsList[modsList.length] = new AssetsMod(new Eyelid, "EyelidL", { Colorable: eyelidColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Eyelid, "EyelidR", { Colorable: eyelidColorProperties } );
			
			/* Arm related */
			modsList[modsList.length] = new AssetsMod(new Hand, "HandL", { Colorable: skinColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Hand, "HandR", { Colorable: skinColorProperties } );
			
			modsList[modsList.length] = new AssetsMod(new Hand2, "Hand2L", { Colorable: skinColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Hand2, "Hand2R", { Colorable: skinColorProperties } );
			
			modsList[modsList.length] = new AssetsMod(new Forearm, "ForearmL", { Colorable: skinWithHighlightColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Forearm, "ForearmR", { Colorable: skinWithHighlightColorProperties } );
			
			modsList[modsList.length] = new AssetsMod(new Arm, "ArmL", { Colorable: skinColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Arm, "ArmR", { Colorable: skinColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Arm3, "Arm3L", { Colorable: skinColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Arm3, "Arm3R", { Colorable: skinColorProperties } );
			
			modsList[modsList.length] = new AssetsMod(new Clavicle, "ClavicleL", { Colorable: skinColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Clavicle, "ClavicleR", { Colorable: skinColorProperties } );
			
			modsList[modsList.length] = new AssetsMod(new Shoulder, "ShoulderL", { Colorable: skinWithHighlightColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Shoulder, "ShoulderR", { Colorable: skinWithHighlightColorProperties } );
			
			/*Head related*/
			modsList[modsList.length] = new AssetsMod(new Neck, "Neck", { Colorable: skinColorProperties } );
			var faceColorProperties:Object = { Group: "Face", Target: "Color" };
			var faceWithHairColorProperties:Object = { Group: ["Skin","Hair"], Target: ["Skin", "Hair"] };
			modsList[modsList.length] = new AssetsMod(new Face, "Face", { Colorable: faceColorProperties } );
			modsList[modsList.length] = new AssetsMod(new FaceAngled, "FaceAngled", { Colorable: faceWithHairColorProperties } );
			modsList[modsList.length] = new AssetsMod(new FaceAngled2, "FaceAngled2", { Colorable: faceWithHairColorProperties } );
			modsList[modsList.length] = new AssetsMod(new FaceAngled3, "FaceAngled3", { Colorable: faceWithHairColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Nose, "Nose");
			
			var earColorProperties:Object = { Group: "Ear", Target: "Color" };
			modsList[modsList.length] = new AssetsMod(new Ear, "EarL", { Colorable: earColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Ear, "EarR", { Colorable: earColorProperties } );
			
			var lipColorProperties:Object  = { Group: "Lip", Target: "Lips" };
			modsList[modsList.length] = new AssetsMod(new ClosedSmile, "ClosedSmile", { Colorable: lipColorProperties } );
			modsList[modsList.length] = new AssetsMod(new OpenSmile, "OpenSmile", { Colorable: lipColorProperties } );
			modsList[modsList.length] = new AssetsMod(new TeardropMouth, "TeardropMouth", { Colorable: lipColorProperties } );
			modsList[modsList.length] = new AssetsMod(new WideMouth, "WideMouth", { Colorable: lipColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Grin, "Grin");
			//modsList[modsList.length] = new AssetsMod(new Face, "Face", { Colorable: skinColorProperties } );
			
			/*modsList[modsList.length] = new AssetsMod(new X, "XL", { Colorable: skinColorProperties } );
			modsList[modsList.length] = new AssetsMod(new X, "XR", { Colorable: skinColorProperties } );
			
			modsList[modsList.length] = new AssetsMod(new , "XL", { Colorable: skinColorProperties } );
			modsList[modsList.length] = new AssetsMod(new , "R", { Colorable: skinColorProperties } );*/
			
			/* Torso related*/
			modsList[modsList.length] = new AssetsMod(new Hips, "Hips", { Colorable: skinColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Hips2, "Hips2", { Colorable: skinColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Chest, "Chest", { Colorable: skinColorProperties } );
			
			modsList[modsList.length] = new AssetsMod(new Boob, "BoobL", { Colorable: skinWithHighlightColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Boob, "BoobR", { Colorable: skinWithHighlightColorProperties } );
			
			var breastGradientColorProperties:Object  = { Group: ["Breast", "SkinHighlight"], Target: ["Color", "Highlight"] };
			modsList[modsList.length] = new AssetsMod(new Boob2, "Boob2L", { Colorable: breastGradientColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Boob2, "Boob2R", { Colorable: breastGradientColorProperties } );
			
			var nippleColorProperties:Object  = { Group: "Nipple", Target: "Color" };
			modsList[modsList.length] = new AssetsMod(new Nipple, "NippleL", { Colorable: nippleColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Nipple, "NippleR", { Colorable: nippleColorProperties } );
			
			var areolaColorProperties:Object  = { Group: "Areola", Target: "Color" };
			modsList[modsList.length] = new AssetsMod(new Areola, "AreolaL", { Colorable: areolaColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Areola, "AreolaR", { Colorable: areolaColorProperties } );
			
			var charSkinHighlightColorProperties:Object = { Group: "SkinHighlight", Target: "Highlight" };
			modsList[modsList.length] = new AssetsMod(new BoobHighlight, "BoobHighlightL", { Colorable: charSkinHighlightColorProperties } );
			modsList[modsList.length] = new AssetsMod(new BoobHighlight, "BoobHighlightR", { Colorable: charSkinHighlightColorProperties } );
			
			modsList[modsList.length] = new AssetsMod(new Navel, "Navel", { Colorable: skinColorProperties } );
			
			/* Leg /lower body related */
			
			var leggingsColorProperties:Object = { Group: "Legging", Target: "Legging" };
			modsList[modsList.length] = new AssetsMod(new LowerLeg, "LowerLegL", { Colorable: leggingsColorProperties } );
			modsList[modsList.length] = new AssetsMod(new LowerLeg, "LowerLegR", { Colorable: leggingsColorProperties } );
			
			modsList[modsList.length] = new AssetsMod(new UpperLeg, "UpperLegL", { Colorable: skinWithHighlightColorProperties } );
			modsList[modsList.length] = new AssetsMod(new UpperLeg, "UpperLegR", { Colorable: skinWithHighlightColorProperties } );
			
			modsList[modsList.length] = new AssetsMod(new FrontButt, "FrontButtL", { Colorable: skinColorProperties } );
			modsList[modsList.length] = new AssetsMod(new FrontButt, "FrontButtR", { Colorable: skinColorProperties } );
			
			modsList[modsList.length] = new AssetsMod(new Groin, "Groin", { Colorable: skinColorProperties } );
			var vulvaColorProperties:Object = { Group: ["Vulva", "SkinHighlight", "SkinHighlight"], Target: ["Color", "Highlight", "Highlight2"] };
			modsList[modsList.length] = new AssetsMod(new Vulva, "Vulva", { Colorable: vulvaColorProperties } );
			
			
			
			
			
			
		}
		
	}
	
}