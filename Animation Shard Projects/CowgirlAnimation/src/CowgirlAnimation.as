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
			this.displayOrderList = '{"0":{"HairBackLayer":0,"ArmL":1,"HandR":2,"ArmR":3,"ForearmR":4,"ShoulderL":5,"ShoulderR":6,"Neck":7,"FrontButtR":8,"FrontButtL":9,"Chest":10,"Hips":11,"Navel":12,"MaleLegL":13,"MaleLegR":14,"PchLowerLegR":15,"UpperLegR":16,"PchLowerLegL":17,"UpperLegL":18,"MaleGroin":19,"MaleShaft":20.01,"MalePenisHead":20.02,"ShaftMask":20,"BoobL":21,"AreolaL":22,"NippleL":23,"Groin":24,"Vulva":25,"MaleBody":26,"ClavicleR":27,"ClavicleL":28,"HairBehindHeadwearLayer":29,"Symbol 47":30,"HairBehindFaceLayer":31,"EarR":32,"EarL":33,"Face":34,"ClosedLashR":35,"ClosedLashL":36,"ScleraR":37,"EyeballR":38.01,"EyelidR":38.02,"EyeMaskR":38,"EyelashR":39,"ScleraL":40,"EyeballL":41.01,"EyelidL":41.02,"EyeMaskL":41,"EyelashL":42,"HairFrontLayer":43,"EyebrowR":44,"EyebrowL":45,"Nose":46,"OpenSmile":47,"ClosedSmile":48,"HandL":49,"ForearmL":50,"BoobR":51,"AreolaR":52,"NippleR":53}}'
			//this.displayOrderList = '{"0":{"PchHairBack":0,"ArmL":1,"HandR":2,"ArmR":3,"ForearmR":4,"ShoulderL":5,"ShoulderR":6,"Neck":7,"FrontButtR":8,"FrontButtL":9,"Chest":10,"Hips":11,"Navel":12,"MaleLegL":13,"MaleLegR":14,"PchLowerLegR":15,"UpperLegR":16,"PchLowerLegL":17,"UpperLegL":18,"MaleGroin":19,"MaleShaft":20.01,"MalePenisHead":20.02,"ShaftMask":20,"BoobL":21,"AreolaL":22,"NippleL":23,"Groin":24,"Vulva":25,"MaleBody":26,"ClavicleR":27,"ClavicleL":28,"PchCrown":29,"PchHair3R":30,"PchHair3L":31,"PchEarringL":32,"PchEarringR":33,"EarR":34,"EarL":35,"Face":36,"ClosedLashR":37,"ClosedLashL":38,"ScleraR":39,"EyeballR":40.01,"EyelidR":40.02,"EyeMaskR":40,"EyelashR":41,"ScleraL":42,"EyeballL":43.01,"EyelidL":43.02,"EyeMaskL":43,"EyelashL":44,"PchHair1R":45,"PchHair1L":46,"PchHair2R":47,"PchHair2L":48,"PchHairFront":49,"EyebrowR":50,"EyebrowL":51,"Nose":52,"OpenSmile":53,"ClosedSmile":54,"HandL":55,"ForearmL":56,"BoobR":57,"AreolaR":58,"NippleR":59}}';*/
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
			dispInfo[dispInfo.length] = new DispObjInfo("MaleLegL", 1400, 0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleLegR", 1500, 0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleGroin", 2000, 0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleShaft", 100, 0.0, "ShaftMask", 2);
			dispInfo[dispInfo.length] = new DispObjInfo("MalePenisHead", 200, 0.0, "ShaftMask", 2);
			dispInfo[dispInfo.length] = new DispObjInfo("ShaftMask", 2100, 0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleBody", 2700, 0.0);
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
			vector.push(new EyeballLTimelineData().GetTimelineData());
			vector.push(new EyeballRTimelineData().GetTimelineData());
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
			vector.push(new LowerLegLTimelineData().GetTimelineData());
			vector.push(new LowerLegRTimelineData().GetTimelineData());
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
			dispInfo[dispInfo.length] = new DispObjInfo("HairBackLayer", 100, 0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("ArmL", 200, 0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("HandR", 300, 0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("ArmR", 400,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("ForearmR", 500,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("ShoulderL", 600,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("ShoulderR", 700, 0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("Neck", 800,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("FrontButtR", 900,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("FrontButtL", 1000,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("Chest", 1100, 0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("Hips", 1200,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("Navel", 1300,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("LowerLegR", 1600,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("UpperLegR", 1700, 0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("LowerLegL", 1800,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("UpperLegL", 1900,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("BoobL", 2200,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("AreolaL", 2300, 0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("NippleL", 2400,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("Groin", 2500,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("Vulva", 2600,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("ClavicleR", 2800, 0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("ClavicleL", 2900,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("HairBehindHeadwearLayer", 3000,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("HairBehindFaceLayer", 3200,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("EarR", 3300, 0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("EarL", 3400,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("Face", 3500,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("ClosedLashR", 3600,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("ClosedLashL", 3700, 0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("ScleraR", 3800,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("EyeMaskR", 3900, 0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("EyeballR",100,0.0, "EyeMaskR", 2);
			dispInfo[dispInfo.length] = new DispObjInfo("EyelidR",200,0.0, "EyeMaskR", 2);
			dispInfo[dispInfo.length] = new DispObjInfo("EyelashR", 4000,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("ScleraL", 4100,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("EyeMaskL", 4200, 0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("EyeballL",100,0.0, "EyeMaskL", 2);
			dispInfo[dispInfo.length] = new DispObjInfo("EyelidL", 200, 0.0, "EyeMaskL", 2);
			dispInfo[dispInfo.length] = new DispObjInfo("EyelashL",4300,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("HairFrontLayer",4400,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("EyebrowR", 4500, 0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("EyebrowL",4600,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("Nose",4700,0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("OpenSmile", 4800, 0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("ClosedSmile", 4900, 0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("HandL", 5000, 0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("ForearmL", 5100, 0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("BoobR", 5200, 0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("AreolaR", 5300, 0.0);
			dispInfo[dispInfo.length] = new DispObjInfo("NippleR",5400,0.0);
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