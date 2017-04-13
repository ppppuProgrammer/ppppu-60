package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import modifications.AssetsMod;
	import modifications.ModArchive;
	import animations.Actor;
	
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
			modsList[modsList.length] = new AssetsMod(new Eyeball, "EyeballL", "Standard", 1, { Colorable: eyeballColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Eyeball, "EyeballR", "Standard", 1, { Colorable: eyeballColorProperties } );
			
			var scleraColorProperties:Object = { Group: ["Eyelid", "Sclera"], Target: ["EyelidColor", "Color"] };
			modsList[modsList.length] = new AssetsMod(new Sclera, "ScleraL", "Standard", 1, { Colorable: scleraColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Sclera, "ScleraR", "Standard", 1, { Colorable: scleraColorProperties } );
			
			modsList[modsList.length] = new AssetsMod(new ClosedLash, "ClosedLashL", "Standard", 1);
			modsList[modsList.length] = new AssetsMod(new ClosedLash, "ClosedLashR", "Standard", 1);
			
			modsList[modsList.length] = new AssetsMod(new EyeMask, "EyeMaskL", "Standard", 1);
			modsList[modsList.length] = new AssetsMod(new EyeMask, "EyeMaskR", "Standard", 1);
			
			modsList[modsList.length] = new AssetsMod(new Eyelash, "EyelashL", "Standard", 1);
			modsList[modsList.length] = new AssetsMod(new Eyelash, "EyelashR", "Standard", 1);		
			
			modsList[modsList.length] = new AssetsMod(new Eyebrow, "EyebrowL", "Standard", 1);
			modsList[modsList.length] = new AssetsMod(new Eyebrow, "EyebrowR", "Standard", 1);
			
			var eyelidColorProperties:Object = { Group: "Eyelid", Target: "Color" };
			modsList[modsList.length] = new AssetsMod(new Eyelid, "EyelidL", "Standard", 1, { Colorable: eyelidColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Eyelid, "EyelidR", "Standard", 1, { Colorable: eyelidColorProperties } );
			
			/* Arm related */
			modsList[modsList.length] = new AssetsMod(new Hand, "HandL", "Standard", 1, { Colorable: skinColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Hand, "HandR", "Standard", 1, { Colorable: skinColorProperties } );
			
			modsList[modsList.length] = new AssetsMod(new Hand2, "Hand2L", "Standard", 1, { Colorable: skinColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Hand2, "Hand2R", "Standard", 1, { Colorable: skinColorProperties } );
			
			modsList[modsList.length] = new AssetsMod(new Forearm, "ForearmL", "Standard", 1, { Colorable: skinWithHighlightColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Forearm, "ForearmR", "Standard", 1, { Colorable: skinWithHighlightColorProperties } );
			
			modsList[modsList.length] = new AssetsMod(new Arm, "ArmL", "Standard", 1, { Colorable: skinColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Arm, "ArmR", "Standard", 1, { Colorable: skinColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Arm3, "Arm3L", "Standard", 1, { Colorable: skinColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Arm3, "Arm3R", "Standard", 1, { Colorable: skinColorProperties } );
			
			modsList[modsList.length] = new AssetsMod(new Clavicle, "ClavicleL", "Standard", 1, { Colorable: skinColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Clavicle, "ClavicleR", "Standard", 1, { Colorable: skinColorProperties } );
			
			modsList[modsList.length] = new AssetsMod(new Shoulder, "ShoulderL", "Standard", 1, { Colorable: skinWithHighlightColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Shoulder, "ShoulderR", "Standard", 1, { Colorable: skinWithHighlightColorProperties } );
			
			/*Head related*/
			modsList[modsList.length] = new AssetsMod(new Neck, "Neck", "Standard", 1, { Colorable: skinColorProperties } );
			var faceColorProperties:Object = { Group: "Face", Target: "Color" };
			var faceWithHairColorProperties:Object = { Group: ["Skin","Hair"], Target: ["Skin", "Hair"] };
			modsList[modsList.length] = new AssetsMod(new Face, "Face", "Standard", 1, { Colorable: faceColorProperties } );
			modsList[modsList.length] = new AssetsMod(new FaceAngled, "FaceAngled", "Standard", 1, { Colorable: faceWithHairColorProperties } );
			modsList[modsList.length] = new AssetsMod(new FaceAngled2, "FaceAngled2", "Standard", 1, { Colorable: faceWithHairColorProperties } );
			modsList[modsList.length] = new AssetsMod(new FaceAngled3, "FaceAngled3", "Standard", 1, { Colorable: faceWithHairColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Nose, "Nose", "Standard", 1);
			
			var earColorProperties:Object = { Group: "Ear", Target: "Color" };
			modsList[modsList.length] = new AssetsMod(new Ear, "EarL", "Standard", 1, { Colorable: earColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Ear, "EarR", "Standard", 1, { Colorable: earColorProperties } );
			
			var lipColorProperties:Object  = { Group: "Lip", Target: "Lips" };
			modsList[modsList.length] = new AssetsMod(new ClosedSmile, "ClosedSmile", "Standard", 1, { Colorable: lipColorProperties } );
			modsList[modsList.length] = new AssetsMod(new OpenSmile, "OpenSmile", "Standard", 1, { Colorable: lipColorProperties } );
			modsList[modsList.length] = new AssetsMod(new TeardropMouth, "TeardropMouth", "Standard", 1, { Colorable: lipColorProperties } );
			modsList[modsList.length] = new AssetsMod(new WideMouth, "WideMouth", "Standard", 1, { Colorable: lipColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Grin, "Grin", "Standard", 1);
			
			/* Hair */
			modsList[modsList.length] = new AssetsMod(new PchHair1, "PchHair1R", "Hair_Peach", 1);
			modsList[modsList.length] = new AssetsMod(new PchHair1, "PchHair1L", "Hair_Peach", 1);
			modsList[modsList.length] = new AssetsMod(new PchHair2, "PchHair2L", "Hair_Peach", 1);
			modsList[modsList.length] = new AssetsMod(new PchHair2, "PchHair2R", "Hair_Peach", 1);
			modsList[modsList.length] = new AssetsMod(new PchHair3, "PchHair3L", "Hair_Peach", 1);
			modsList[modsList.length] = new AssetsMod(new PchHair3, "PchHair3R", "Hair_Peach", 1);
			modsList[modsList.length] = new AssetsMod(new PchHairFront, "PchHairFront", "Hair_Peach", 1);
			modsList[modsList.length] = new AssetsMod(new PchHairFrontAngled2, "PchHairFrontAngled2", "Hair_Peach", 1);
			modsList[modsList.length] = new AssetsMod(new PchHairBack, "PchHairBack", "Hair_Peach", 1);
			modsList[modsList.length] = new AssetsMod(new PchEarring, "PchEarringL", "Earring_Peach", 1);
			modsList[modsList.length] = new AssetsMod(new PchEarring, "PchEarringR", "Earring_Peach", 1);
			modsList[modsList.length] = new AssetsMod(new PchCrown, "PchCrown", "Headwear_Peach", 1);
			
			modsList[modsList.length] = new AssetsMod(new RosaHair1, "RosaHair1R", "Hair_Rosalina", 1);
			modsList[modsList.length] = new AssetsMod(new RosaHair1, "RosaHair1L", "Hair_Rosalina", 1);
			modsList[modsList.length] = new AssetsMod(new RosaHair2, "RosaHair2L", "Hair_Rosalina", 1);
			modsList[modsList.length] = new AssetsMod(new RosaHair2, "RosaHair2R", "Hair_Rosalina", 1);
			modsList[modsList.length] = new AssetsMod(new RosaHair3, "RosaHair3L", "Hair_Rosalina", 1);
			modsList[modsList.length] = new AssetsMod(new RosaHair3, "RosaHair3R", "Hair_Rosalina", 1);
			modsList[modsList.length] = new AssetsMod(new RosaHairFront, "RosaHairFront", "Hair_Rosalina", 1);
			modsList[modsList.length] = new AssetsMod(new RosaHairBack, "RosaHairBack", "Hair_Rosalina", 1);
			modsList[modsList.length] = new AssetsMod(new RosaEarring, "RosaEarringL", "Earrring_Rosalina", 1);
			modsList[modsList.length] = new AssetsMod(new RosaEarring, "RosaEarringR", "Earrring_Rosalina", 1);
			modsList[modsList.length] = new AssetsMod(new RosaCrown, "RosaCrown", "Headwear_Rosalina", 1);
			modsList[modsList.length] = new AssetsMod(new RosaHairFrontAngled, "RosaHairFrontAngled", "Hair_Rosalina", 1);
			//Not sure if highlights should be in base assets or in the standard graphic set
			//modsList[modsList.length] = new AssetsMod(new PenisHighlight, "PenisHighlight");
			
			//modsList[modsList.length] = new AssetsMod(new Face, "Face", { Colorable: skinColorProperties } );
			
			/*modsList[modsList.length] = new AssetsMod(new X, "XL", { Colorable: skinColorProperties } );
			modsList[modsList.length] = new AssetsMod(new X, "XR", { Colorable: skinColorProperties } );
			
			modsList[modsList.length] = new AssetsMod(new , "XL", { Colorable: skinColorProperties } );
			modsList[modsList.length] = new AssetsMod(new , "R", { Colorable: skinColorProperties } );*/
			
			/* Torso related*/
			modsList[modsList.length] = new AssetsMod(new Hips, "Hips", "Standard", 1, { Colorable: skinColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Hips2, "Hips2", "Standard", 1, { Colorable: skinColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Chest, "Chest", "Standard", 1, { Colorable: skinColorProperties } );
			
			modsList[modsList.length] = new AssetsMod(new Boob, "BoobL", "Standard", 1, { Colorable: skinWithHighlightColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Boob, "BoobR", "Standard", 1, { Colorable: skinWithHighlightColorProperties } );
			
			var breastGradientColorProperties:Object  = { Group: ["Breast", "SkinHighlight"], Target: ["Color", "Highlight"] };
			modsList[modsList.length] = new AssetsMod(new Boob2, "Boob2L", "Standard", 1, { Colorable: breastGradientColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Boob2, "Boob2R", "Standard", 1, { Colorable: breastGradientColorProperties } );
			
			var nippleColorProperties:Object  = { Group: "Nipple", Target: "Color" };
			modsList[modsList.length] = new AssetsMod(new Nipple, "NippleL", "Standard", 1, { Colorable: nippleColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Nipple, "NippleR", "Standard", 1, { Colorable: nippleColorProperties } );
			
			var areolaColorProperties:Object  = { Group: "Areola", Target: "Color" };
			modsList[modsList.length] = new AssetsMod(new Areola, "AreolaL", "Standard", 1, { Colorable: areolaColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Areola, "AreolaR", "Standard", 1, { Colorable: areolaColorProperties } );
			
			var charSkinHighlightColorProperties:Object = { Group: "SkinHighlight", Target: "Highlight" };
			modsList[modsList.length] = new AssetsMod(new BoobHighlight, "BoobHighlightL", "Standard", 1, { Colorable: charSkinHighlightColorProperties } );
			modsList[modsList.length] = new AssetsMod(new BoobHighlight, "BoobHighlightR", "Standard", 1, { Colorable: charSkinHighlightColorProperties } );
			
			modsList[modsList.length] = new AssetsMod(new Navel, "Navel", "Standard", 1, { Colorable: skinColorProperties } );
			
			/* Leg /lower body related */
			
			var leggingsColorProperties:Object = { Group: "Legging", Target: "Legging" };
			modsList[modsList.length] = new AssetsMod(new LowerLeg, "LowerLegL", "Standard", 1, { Colorable: leggingsColorProperties } );
			modsList[modsList.length] = new AssetsMod(new LowerLeg, "LowerLegR", "Standard", 1, { Colorable: leggingsColorProperties } );
			
			modsList[modsList.length] = new AssetsMod(new UpperLeg, "UpperLegL", "Standard", 1, { Colorable: skinWithHighlightColorProperties } );
			modsList[modsList.length] = new AssetsMod(new UpperLeg, "UpperLegR", "Standard", 1, { Colorable: skinWithHighlightColorProperties } );
			
			modsList[modsList.length] = new AssetsMod(new FrontButt, "FrontButtL", "Standard", 1, { Colorable: skinColorProperties } );
			modsList[modsList.length] = new AssetsMod(new FrontButt, "FrontButtR", "Standard", 1, { Colorable: skinColorProperties } );
			
			modsList[modsList.length] = new AssetsMod(new Groin, "Groin", "Standard", 1, { Colorable: skinColorProperties } );
			var vulvaColorProperties:Object = { Group: ["Vulva", "SkinHighlight", "SkinHighlight"], Target: ["Color", "Highlight", "Highlight2"] };
			modsList[modsList.length] = new AssetsMod(new Vulva, "Vulva", "Standard", 1, { Colorable: vulvaColorProperties } );
			
			/* Male */
			modsList[modsList.length] = new AssetsMod(new MalePenisHead, "MalePenisHead", "Standard", Actor.LAYER_MAIN, null);
			modsList[modsList.length] = new AssetsMod(new MaleShaft, "MaleShaft", "Standard", Actor.LAYER_MAIN, null);
			modsList[modsList.length] = new AssetsMod(new MaleShaft2, "MaleShaft2", "Standard", Actor.LAYER_MAIN, null);
			modsList[modsList.length] = new AssetsMod(new MaleGroin, "MaleGroin", "Standard", Actor.LAYER_MAIN, null);
			modsList[modsList.length] = new AssetsMod(new MaleLeg, "MaleLegL", "Standard", Actor.LAYER_MAIN, null);
			modsList[modsList.length] = new AssetsMod(new MaleLeg, "MaleLegR", "Standard", Actor.LAYER_MAIN, null);
			modsList[modsList.length] = new AssetsMod(new MaleBody, "MaleBody", "Standard", Actor.LAYER_MAIN, null);
			modsList[modsList.length] = new AssetsMod(new ShaftMask, "ShaftMask", "Standard", Actor.LAYER_MAIN, null);
			modsList[modsList.length] = new AssetsMod(new ShaftMask2, "ShaftMask2", "Standard", Actor.LAYER_MAIN, null);
			//Not sure if highlights should be in base assets or in the standard graphic set
			//modsList[modsList.length] = [new PenisHighlight, "PenisHighlight", Actor.LAYER_MAIN, null];
			//modsList[modsList.length] = [new , "", Actor.LAYER_MAIN, null];
			
			
			
			
		}
		
	}
	
}