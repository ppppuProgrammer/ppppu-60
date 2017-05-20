package
{
	import Pch.Anim9_PeachAnimation;
	import Ros.Anim9_RosalinaAnimation;
    import animations.AnimateShard;
    import animations.DispObjInfo;
    import modifications.AnimateShardMod;
    import modifications.ModArchive;

    public class Anim9Animation extends ModArchive
    {
        public function Anim9Animation()
        {
            modsList[modsList.length] = CreateShardModForMale();
			modsList[modsList.length] = CreateShardModForFemale();
			modsList = modsList.concat(Anim9_PeachAnimation.GetShardMods(), Anim9_RosalinaAnimation.GetShardMods());
        }

        //Display Object Information Region
		//{
		private function CreateDisplayInfoForMale():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("MaleLegL", 600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MaleLegR", 1400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MaleGroin", 4600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ShaftMask", 4800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MaleBody", 6600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MaleShaft", 200, 0, "ShaftMask", DispObjInfo.FLAG_MASKED);
dispInfo[dispInfo.length] = new DispObjInfo("MalePenisHead", 400, 0, "ShaftMask", DispObjInfo.FLAG_MASKED);
dispInfo[dispInfo.length] = new DispObjInfo("PenisHighlight", 600, 0, "ShaftMask", DispObjInfo.FLAG_MASKED);
            return dispInfo;
        }

		private function CreateDisplayInfoForFemale():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("BackLayer", 200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BehindHeadLayer", 400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ArmL", 800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("HandL", 1000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ForearmL", 1200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ArmR", 1600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("HandR", 1800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ForearmR", 2000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ShoulderL", 2200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ShoulderR", 2400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Neck", 2600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("FrontButtR", 2800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("FrontButtL", 3000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Chest", 3200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Hips2", 3400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Navel", 3600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("LowerLegR", 3800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("UpperLegR", 4000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("LowerLegL", 4200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("UpperLegL", 4400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ClavicleR", 5000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ClavicleL", 5200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BoobL", 5400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BoobHighlightL", 5600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("AreolaL", 5800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("NippleL", 6000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Groin", 6200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Vulva", 6400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BehindEarLayer", 6800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("EarL", 7000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("EarR", 7200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("FrontEarLayer", 7400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Face", 7600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("RightEyeLayer", 7800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("LeftEyeLayer", 8000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("FrontHeadLayer", 8200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("EyebrowR", 8400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("EyebrowL", 8600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Nose", 8800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MouthLayer", 9000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BoobR", 9200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BoobHighlightR", 9400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("AreolaR", 9600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("NippleR", 9800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("FrontLayer", 10000, 0);
            return dispInfo;
        }

		//}
		//End Display Object Information Region

		//Timeline Data Region
		//{
		private function GetTimelineDataForMale():Vector.<Object>
        {
            var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
dataForTimelineCreation.push(new MaleBodyTimelineData().GetTimelineData());
dataForTimelineCreation.push(new MaleGroinTimelineData().GetTimelineData());
dataForTimelineCreation.push(new MaleLegRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new MaleLegLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ShaftMaskTimelineData().GetTimelineData());
dataForTimelineCreation.push(new PenisHighlightTimelineData().GetTimelineData());
dataForTimelineCreation.push(new MalePenisHeadTimelineData().GetTimelineData());
dataForTimelineCreation.push(new MaleShaftTimelineData().GetTimelineData());
            return dataForTimelineCreation;
        }

		private function GetTimelineDataForFemale():Vector.<Object>
        {
            var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
dataForTimelineCreation.push(new NippleRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new AreolaRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new BoobHighlightRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new BoobRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new NoseTimelineData().GetTimelineData());
dataForTimelineCreation.push(new EyebrowLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new EyebrowRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new FaceTimelineData().GetTimelineData());
dataForTimelineCreation.push(new EarRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new EarLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new VulvaTimelineData().GetTimelineData());
dataForTimelineCreation.push(new GroinTimelineData().GetTimelineData());
dataForTimelineCreation.push(new NippleLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new AreolaLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new BoobHighlightLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new BoobLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ClavicleLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ClavicleRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new UpperLegLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new LowerLegLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new UpperLegRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new LowerLegRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new NavelTimelineData().GetTimelineData());
dataForTimelineCreation.push(new Hips2TimelineData().GetTimelineData());
dataForTimelineCreation.push(new ChestTimelineData().GetTimelineData());
dataForTimelineCreation.push(new FrontButtLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new FrontButtRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new NeckTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ShoulderRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ShoulderLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ForearmRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new HandRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ArmRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ForearmLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new HandLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ArmLTimelineData().GetTimelineData());
            return dataForTimelineCreation;
        }

		//}
		//End Timeline Data Region

		//Animate Shard Region
		//{
		private function CreateShardModForMale():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForMale();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForMale();
            var animateShard:AnimateShardMod = new AnimateShardMod("Anim9", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Male (Standard)", true, "Put description here");
            return animateShard;
        }

		private function CreateShardModForFemale():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForFemale();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForFemale();
            var animateShard:AnimateShardMod = new AnimateShardMod("Anim9", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Female (Standard)", true, "Put description here");
            return animateShard;
        }

		//}
		//End Animate Shard Region


    }
}