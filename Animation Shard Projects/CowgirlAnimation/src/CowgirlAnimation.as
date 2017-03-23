package
{
	import animations.AnimateShard;
	import animations.DispObjInfo;
	import modifications.AnimateShardMod;
	import modifications.AnimationMod;
	import flash.display.Sprite;
	import flash.events.Event;
	import modifications.ModArchive;
	import modifications.TemplateAnimationMod;
	//import Animations.Cowgirl.*;
	/**
	 * ...
	 * @author 
	 */
	public class CowgirlAnimation extends ModArchive
	{
		//private var timelinesData:Vector.<Object> = new Vector.<Object>();
		public function CowgirlAnimation() 
		{
			modsList.push(CreateShardModForFemale());
			modsList.push(CreateShardModForMale());
			/*isBasisTemplate = true;
			this.bodyTypeName = "Standard";
			this.animationName = "Cowgirl";
			this.displayOrderList = '{"0":{"HairBackLayer":0,"ArmL":1,"HandR":2,"ArmR":3,"ForearmR":4,"ShoulderL":5,"ShoulderR":6,"Neck":7,"FrontButtR":8,"FrontButtL":9,"Chest":10,"Hips":11,"Navel":12,"MaleLegL":13,"MaleLegR":14,"PchLowerLegR":15,"UpperLegR":16,"PchLowerLegL":17,"UpperLegL":18,"MaleGroin":19,"MaleShaft":20.01,"MalePenisHead":20.02,"ShaftMask":20,"BoobL":21,"AreolaL":22,"NippleL":23,"Groin":24,"Vulva":25,"MaleBody":26,"ClavicleR":27,"ClavicleL":28,"HairBehindHeadwearLayer":29,"Symbol 47":30,"HairBehindFaceLayer":31,"EarR":32,"EarL":33,"Face":34,"ClosedLashR":35,"ClosedLashL":36,"ScleraR":37,"PchPupilR":38.01,"EyelidR":38.02,"EyeMaskR":38,"EyelashR":39,"ScleraL":40,"PchPupilL":41.01,"EyelidL":41.02,"EyeMaskL":41,"EyelashL":42,"HairFrontLayer":43,"EyebrowR":44,"EyebrowL":45,"Nose":46,"OpenSmile":47,"ClosedSmile":48,"HandL":49,"ForearmL":50,"BoobR":51,"AreolaR":52,"NippleR":53}}'
			//this.displayOrderList = '{"0":{"PchHairBack":0,"ArmL":1,"HandR":2,"ArmR":3,"ForearmR":4,"ShoulderL":5,"ShoulderR":6,"Neck":7,"FrontButtR":8,"FrontButtL":9,"Chest":10,"Hips":11,"Navel":12,"MaleLegL":13,"MaleLegR":14,"PchLowerLegR":15,"UpperLegR":16,"PchLowerLegL":17,"UpperLegL":18,"MaleGroin":19,"MaleShaft":20.01,"MalePenisHead":20.02,"ShaftMask":20,"BoobL":21,"AreolaL":22,"NippleL":23,"Groin":24,"Vulva":25,"MaleBody":26,"ClavicleR":27,"ClavicleL":28,"PchCrown":29,"PchHair3R":30,"PchHair3L":31,"PchEarringL":32,"PchEarringR":33,"EarR":34,"EarL":35,"Face":36,"ClosedLashR":37,"ClosedLashL":38,"ScleraR":39,"PchPupilR":40.01,"EyelidR":40.02,"EyeMaskR":40,"EyelashR":41,"ScleraL":42,"PchPupilL":43.01,"EyelidL":43.02,"EyeMaskL":43,"EyelashL":44,"PchHair1R":45,"PchHair1L":46,"PchHair2R":47,"PchHair2L":48,"PchHairFront":49,"EyebrowR":50,"EyebrowL":51,"Nose":52,"OpenSmile":53,"ClosedSmile":54,"HandL":55,"ForearmL":56,"BoobR":57,"AreolaR":58,"NippleR":59}}';*/
		}
		
		private function GetTimelineDataForMale():Vector.<Object>
		{
			var vector:Vector.<Object> = new Vector.<Object>();
			vector.push(new MaleBodyTimelineData().GetTimelineData());
			vector.push(new MaleGroinTimelineData().GetTimelineData());
			vector.push(new MaleLegLTimelineData().GetTimelineData());
			vector.push(new MaleLegRTimelineData().GetTimelineData());
			vector.push(new MalePenisHeadTimelineData().GetTimelineData());
			vector.push(new MaleShaftTimelineData().GetTimelineData());
			vector.push(new ShaftMaskTimelineData().GetTimelineData());
			return vector;
		}
		
		private function CreateDisplayInfoForMale():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			dispInfo[dispInfo.length] = new DispObjInfo("MaleLegL", 1, 0.0, "Navel", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleLegR", 1, 0.0, "MaleLegL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleGroin", 1, 0.0, "UpperLegL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleShaft", 0, 0.0, "ShaftMask", 2);
			dispInfo[dispInfo.length] = new DispObjInfo("MalePenisHead", 1, 0.0, "ShaftMask", 2);
			dispInfo[dispInfo.length] = new DispObjInfo("ShaftMask", 1, 0.0, "MaleGroin", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleBody", 1, 0.0, "Vulva", 1);
			return dispInfo;
		}
		
		private function CreateShardModForMale():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForMale();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForMale();
			var maleAnimateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Male", "Base"]), timelineData, dispInfo, "Male_Giver", true, "Male (Giver) animations for the Cowgirl position");
			return maleAnimateShard;
		}
		
		private function GetTimelineDataForFemale():Vector.<Object>
		{
			var vector:Vector.<Object> = new Vector.<Object>();
			vector.push(new AreolaLTimelineData().GetTimelineData());
			vector.push(new AreolaRTimelineData().GetTimelineData());
			vector.push(new ArmLTimelineData().GetTimelineData());
			vector.push(new ArmRTimelineData().GetTimelineData());
			vector.push(new BoobLTimelineData().GetTimelineData());
			vector.push(new BoobRTimelineData().GetTimelineData());
			vector.push(new ChestTimelineData().GetTimelineData());
			vector.push(new ClavicleLTimelineData().GetTimelineData());
			vector.push(new ClavicleRTimelineData().GetTimelineData());
			vector.push(new ClosedLashLTimelineData().GetTimelineData());
			vector.push(new ClosedLashRTimelineData().GetTimelineData());
			vector.push(new ClosedSmileTimelineData().GetTimelineData());
			vector.push(new EarLTimelineData().GetTimelineData());
			vector.push(new EarRTimelineData().GetTimelineData());
			vector.push(new EyebrowLTimelineData().GetTimelineData());
			vector.push(new EyebrowRTimelineData().GetTimelineData());
			vector.push(new EyelashLTimelineData().GetTimelineData());
			vector.push(new EyelashRTimelineData().GetTimelineData());
			vector.push(new EyelidLTimelineData().GetTimelineData());
			vector.push(new EyelidRTimelineData().GetTimelineData());
			vector.push(new EyeMaskLTimelineData().GetTimelineData());
			vector.push(new EyeMaskRTimelineData().GetTimelineData());
			vector.push(new FaceTimelineData().GetTimelineData());
			vector.push(new ForearmLTimelineData().GetTimelineData());
			vector.push(new ForearmRTimelineData().GetTimelineData());
			vector.push(new FrontButtLTimelineData().GetTimelineData());
			vector.push(new FrontButtRTimelineData().GetTimelineData());
			vector.push(new GroinTimelineData().GetTimelineData());
			vector.push(new HandLTimelineData().GetTimelineData());
			vector.push(new HandRTimelineData().GetTimelineData());
			vector.push(new HipsTimelineData().GetTimelineData());
			vector.push(new NavelTimelineData().GetTimelineData());
			vector.push(new NeckTimelineData().GetTimelineData());
			vector.push(new NippleLTimelineData().GetTimelineData());
			vector.push(new NippleRTimelineData().GetTimelineData());
			vector.push(new NoseTimelineData().GetTimelineData());
			vector.push(new OpenSmileTimelineData().GetTimelineData());
			vector.push(new ScleraLTimelineData().GetTimelineData());
			vector.push(new ScleraRTimelineData().GetTimelineData());
			
			vector.push(new ShoulderLTimelineData().GetTimelineData());
			vector.push(new ShoulderRTimelineData().GetTimelineData());
			vector.push(new UpperLegLTimelineData().GetTimelineData());
			vector.push(new UpperLegRTimelineData().GetTimelineData());
			vector.push(new VulvaTimelineData().GetTimelineData());
			return vector;
		}
		
		
		
		private function CreateDisplayInfoForFemale():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			dispInfo[dispInfo.length] = new DispObjInfo("HairBackLayer", 1, 0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("ArmL", 1, 0.0, "HairBackLayer", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("HandR", 1,0.0, "ArmL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("ForearmR", 1,0.0, "HandR", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("ShoulderL", 1,0.0, "ForearmR", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("ShoulderR", 1, 0.0, "ShoulderL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("Neck", 1,0.0, "ShoulderR", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("FrontButtR", 1,0.0, "Neck", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("FrontButtL", 1,0.0, "FrontButtR", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("Chest", 1, 0.0, "FrontButtL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("Hips", 1,0.0, "Chest", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("Navel", 1,0.0, "Hips", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("PchLowerLegR", 1,0.0, "MaleLegR", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("UpperLegR", 1, 0.0, "PchLowerLegR", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("PchLowerLegL", 1,0.0, "UpperLegR", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("UpperLegL", 1,0.0, "PchLowerLegL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("BoobL", 1,0.0, "ShaftMask", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("AreolaL", 1, 0.0, "BoobL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("NippleL", 1,0.0, "AreolaL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("Groin", 1,0.0, "NippleL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("Vulva", 1,0.0, "Groin", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("ClavicleR", 1, 0.0, "MaleBody", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("ClavicleL", 1,0.0, "ClavicleR", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("HairBehindHeadwearLayer", 1,0.0, "ClavicleL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("HairBehindFaceLayer", 1,0.0, "HairBehindHeadwearLayer", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("EarR", 1, 0.0, "HairBehindFaceLayer", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("EarL", 1,0.0, "EarR", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("Face", 1,0.0, "EarL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("ClosedLashR", 1,0.0, "Face", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("ClosedLashL", 1, 0.0, "ClosedLashR", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("ScleraR", 1,0.0, "ClosedLashL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("PchPupilR",0,0.0, "EyeMaskR", 2);
			dispInfo[dispInfo.length] = new DispObjInfo("EyelidR",1,0.0, "EyeMaskR", 2);
			dispInfo[dispInfo.length] = new DispObjInfo("EyeMaskR", 1, 0.0, "ScleraR", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("EyelashR", 1,0.0, "EyeMaskR", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("ScleraL", 1,0.0, "EyelashR", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("PchPupilL",0,0.0, "EyeMaskL", 2);
			dispInfo[dispInfo.length] = new DispObjInfo("EyelidL", 1, 0.0, "EyeMaskL", 2);
			dispInfo[dispInfo.length] = new DispObjInfo("EyeMaskL",1,0.0, "ScleraL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("EyelashL",1,0.0, "EyeMaskL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("HairFrontLayer",1,0.0, "EyelashL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("EyebrowR", 1, 0.0, "HairFrontLayer", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("EyebrowL",1,0.0, "EyebrowR", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("Nose",1,0.0, "EyebrowL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("OpenSmile", 1, 0.0, "Nose", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("ClosedSmile", 1, 0.0, "OpenSmile", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("HandL", 1, 0.0, "ClosedSmile", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("ForearmL", 1, 0.0, "HandL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("BoobR", 1, 0.0, "ForearmL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("AreolaR", 1, 0.0, "BoobR", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("NippleR",1,0.0, "AreolaR", 1);
			return dispInfo;
		}
		
		private function CreateShardModForFemale():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForFemale();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForFemale();
			var femaleAnimateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Base"]), timelineData, dispInfo, "Female_Taker", true, "Female (taker) animations for the Cowgirl position");
			return femaleAnimateShard;
		}
		
		override protected function FirstFrame(e:Event):void
		{
			
			
			/*hairLayerAssignments.push(new HairPlacementInfo("PchHairFront", "HairFrontLayer", 0));
			hairLayerAssignments.push(new HairPlacementInfo("PchHair2L", "HairFrontLayer", 1));
			hairLayerAssignments.push(new HairPlacementInfo("PchHair2R", "HairFrontLayer", 2));
			hairLayerAssignments.push(new HairPlacementInfo("PchHair1L", "HairFrontLayer", 3));
			hairLayerAssignments.push(new HairPlacementInfo("PchHair1R", "HairFrontLayer", 4));
			
			hairLayerAssignments.push(new HairPlacementInfo("PchEarringR", "HairBehindFaceLayer", 0));
			hairLayerAssignments.push(new HairPlacementInfo("PchEarringL", "HairBehindFaceLayer", 1));
			
			hairLayerAssignments.push(new HairPlacementInfo("PchHair3L", "HairBehindHeadwearLayer", 0));
			hairLayerAssignments.push(new HairPlacementInfo("PchHair3R", "HairBehindHeadwearLayer", 1));
			hairLayerAssignments.push(new HairPlacementInfo("PchCrown", "HairBehindHeadwearLayer", 2));
			
			hairLayerAssignments.push(new HairPlacementInfo("PchHairBack", "HairBackLayer", 0));*/
			
			super.FirstFrame(e);
		}
	}

}