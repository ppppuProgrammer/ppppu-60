package
{
	import Pch.ReverseCowgirl_PeachAnimation;
	import Ros.ReverseCowgirl_RosalinaAnimation;
    import animations.AnimateShard;
    import animations.DispObjInfo;
    import modifications.AnimateShardMod;
    import modifications.ModArchive;

    public class ReverseCowgirlAnimation extends ModArchive
    {
        public function ReverseCowgirlAnimation()
        {
            modsList[modsList.length] = CreateShardModForMale();
			modsList[modsList.length] = CreateShardModForFemale();
			modsList[modsList.length] = CreateShardModForLeftEye();
			modsList = modsList.concat(ReverseCowgirl_PeachAnimation.GetShardMods(), ReverseCowgirl_RosalinaAnimation.GetShardMods());
        }

        private function CreateDisplayInfoForMale():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();

			dispInfo[dispInfo.length] = new DispObjInfo("MaleLegL", 400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MaleLegR", 600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MaleGroin", 800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ShaftMask", 5000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MaleBody", 8400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MaleShaft", 200, 0, "ShaftMask", DispObjInfo.FLAG_MASKED);
dispInfo[dispInfo.length] = new DispObjInfo("MalePenisHead", 400, 0, "ShaftMask", DispObjInfo.FLAG_MASKED);
dispInfo[dispInfo.length] = new DispObjInfo("PenisHighlight", 600, 0, "ShaftMask", DispObjInfo.FLAG_MASKED);
            return dispInfo;
        }

		private function CreateDisplayInfoForFemale():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();

			dispInfo[dispInfo.length] = new DispObjInfo("BackLayer", 200, 0);

dispInfo[dispInfo.length] = new DispObjInfo("HandL", 1000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ForearmL", 1200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Neck", 1400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Arm2L", 1600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Groin2", 1800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("UpperLegR", 2000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("LowerLegR", 2200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("UpperLegL", 2400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BehindHeadLayer", 2600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("FaceAngled2", 2800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BehindEarLayer", 3000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("EarR", 3200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("FrontEarLayer", 3400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("LeftEyeLayer", 3600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("RightEyeLayer", 3800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MouthLayer", 4000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("NoseAngled", 4200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("EyebrowR", 4400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("EyebrowL", 4600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("FrontHeadLayer", 4800, 0);

dispInfo[dispInfo.length] = new DispObjInfo("BackVulva", 5200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("UpperBackAngled", 5400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("LowerBackAngled", 5600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Arm2R", 5800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ShoulderR", 6000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BackHipsAngled", 6200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("NippleL", 6400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("SideBoobL", 6600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BoobHighlightL", 6800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ButtcheekShadowR2", 7000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ButtcheekShadowR1", 7200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ButtcheekR", 7400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ButtcheekShadowL2", 7600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ButtcheekShadowL1", 7800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ButtcheekL", 8000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("LowerLegL", 8200, 0);

dispInfo[dispInfo.length] = new DispObjInfo("HandR", 8600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ForearmR", 8800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("FrontLayer", 9000, 0);
            return dispInfo;
        }
		
		private function CreateDisplayInfoForLeftEye():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("ClosedLashL", 200, 0, "LeftEyeLayer", DispObjInfo.FLAG_CHILD);
            return dispInfo;
        }


		private function GetTimelineDataForMale():Vector.<Object>
        {
            var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
			dataForTimelineCreation.push(new MaleBodyTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new ShaftMaskTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new PenisHighlightTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new MaleShaftTimelineData().GetTimelineData());
dataForTimelineCreation.push(new MalePenisHeadTimelineData().GetTimelineData());
dataForTimelineCreation.push(new MaleGroinTimelineData().GetTimelineData());
dataForTimelineCreation.push(new MaleLegRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new MaleLegLTimelineData().GetTimelineData());
            return dataForTimelineCreation;
        }

		private function GetTimelineDataForFemale():Vector.<Object>
        {
            var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
dataForTimelineCreation.push(new ForearmRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new HandRTimelineData().GetTimelineData());

dataForTimelineCreation.push(new LowerLegLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ButtcheekLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ButtcheekShadowL1TimelineData().GetTimelineData());
dataForTimelineCreation.push(new ButtcheekShadowL2TimelineData().GetTimelineData());
dataForTimelineCreation.push(new ButtcheekRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ButtcheekShadowR1TimelineData().GetTimelineData());
dataForTimelineCreation.push(new ButtcheekShadowR2TimelineData().GetTimelineData());
dataForTimelineCreation.push(new BoobHighlightLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new SideBoobLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new NippleLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new BackHipsAngledTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ShoulderRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new Arm2RTimelineData().GetTimelineData());
dataForTimelineCreation.push(new LowerBackAngledTimelineData().GetTimelineData());
dataForTimelineCreation.push(new UpperBackAngledTimelineData().GetTimelineData());
dataForTimelineCreation.push(new BackVulvaTimelineData().GetTimelineData());



//dataForTimelineCreation.push(new Symbol96TimelineData().GetTimelineData());
//dataForTimelineCreation.push(new HairFrontAngled2TimelineData().GetTimelineData());
//dataForTimelineCreation.push(new Hair2RTimelineData().GetTimelineData());
//dataForTimelineCreation.push(new Hair3RTimelineData().GetTimelineData());
//dataForTimelineCreation.push(new HeadwearTimelineData().GetTimelineData());
//dataForTimelineCreation.push(new Hair1RTimelineData().GetTimelineData());
dataForTimelineCreation.push(new EyebrowLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new EyebrowRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new NoseAngledTimelineData().GetTimelineData());
/*dataForTimelineCreation.push(new TeardropMouthTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ClosedSmileTimelineData().GetTimelineData());
dataForTimelineCreation.push(new OpenSmileTimelineData().GetTimelineData());*/
//dataForTimelineCreation.push(new EyelashRTimelineData().GetTimelineData());
//dataForTimelineCreation.push(new EyeMaskRTimelineData().GetTimelineData());
//dataForTimelineCreation.push(new EyelidRTimelineData().GetTimelineData());
//dataForTimelineCreation.push(new EyeballRTimelineData().GetTimelineData());
//dataForTimelineCreation.push(new ScleraRTimelineData().GetTimelineData());
//dataForTimelineCreation.push(new ClosedLashRTimelineData().GetTimelineData());
//dataForTimelineCreation.push(new ClosedLashLTimelineData().GetTimelineData());
//dataForTimelineCreation.push(new EarringRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new EarRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new FaceAngled2TimelineData().GetTimelineData());
//dataForTimelineCreation.push(new Hair1LTimelineData().GetTimelineData());
//dataForTimelineCreation.push(new Hair2LTimelineData().GetTimelineData());
//dataForTimelineCreation.push(new Hair3LTimelineData().GetTimelineData());
//dataForTimelineCreation.push(new EarringLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new UpperLegLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new LowerLegRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new UpperLegRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new Groin2TimelineData().GetTimelineData());
dataForTimelineCreation.push(new Arm2LTimelineData().GetTimelineData());
dataForTimelineCreation.push(new NeckTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ForearmLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new HandLTimelineData().GetTimelineData());

//dataForTimelineCreation.push(new HairBackTimelineData().GetTimelineData());
            return dataForTimelineCreation;
        }
		
		private function GetTimelineDataForLeftEye():Vector.<Object>
        {
			var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
			dataForTimelineCreation.push(new ClosedLashLTimelineData().GetTimelineData());
			return dataForTimelineCreation;
		}

		private function CreateShardModForMale():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForMale();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForMale();
            var animateShard:AnimateShardMod = new AnimateShardMod("Reverse Cowgirl", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Male (Standard)", true, "Put description here");
            return animateShard;
        }

		private function CreateShardModForFemale():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForFemale();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForFemale();
            var animateShard:AnimateShardMod = new AnimateShardMod("Reverse Cowgirl", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Female (Standard)", true, "Put description here");
            return animateShard;
        }

		private function CreateShardModForLeftEye():AnimateShardMod
        {
			var timelineData:Vector.<Object> = GetTimelineDataForLeftEye();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForLeftEye();
            var animateShard:AnimateShardMod = new AnimateShardMod("Reverse Cowgirl", Vector.<String>(["Eye", "Left", "Standard"]), timelineData, dispInfo, "Left Eye (Standard)", true, "Eye Motion: Closed");
            return animateShard;
		}
    }
}