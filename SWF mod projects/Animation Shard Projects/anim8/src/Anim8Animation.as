package
{
    import animations.AnimateShard;
    import animations.DispObjInfo;
    import modifications.AnimateShardMod;
    import modifications.ModArchive;
	import Pch.Anim8_PeachAnimation;
	import Ros.Anim8_RosalinaAnimation;

    public class Anim8Animation extends ModArchive
    {
        public function Anim8Animation()
        {
            modsList[modsList.length] = CreateShardModForMale();
			modsList[modsList.length] = CreateShardModForFemale();
			modsList = modsList.concat(Anim8_PeachAnimation.GetShardMods(), Anim8_RosalinaAnimation.GetShardMods());
        }

        //Display Object Information Region
		//{
		private function CreateDisplayInfoForMale():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("MaleLegR", 600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MaleGroin", 800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MaleLegL", 7200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MaleBody", 8600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MaleShaft", 200, 0, "ShaftMask", DispObjInfo.FLAG_MASKED);
dispInfo[dispInfo.length] = new DispObjInfo("MalePenisHead", 400, 0, "ShaftMask", DispObjInfo.FLAG_MASKED);
dispInfo[dispInfo.length] = new DispObjInfo("PenisHighlight", 600, 0, "ShaftMask", DispObjInfo.FLAG_MASKED);
            return dispInfo;
        }

		private function CreateDisplayInfoForFemale():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("BackLayer", 200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("LowerLegL", 400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("FrontButtL", 1000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("UpperLegL", 1200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ArmL", 1400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ForearmL", 1600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ChestAngled", 1800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MidTorsoAngled", 2000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ShoulderL", 2200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ClavicleL", 2400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Neck", 2600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BehindHeadLayer", 2800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("FaceAngled", 3000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BehindEarLayer", 3200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("EarR", 3400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("FrontEarLayer", 3600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("LeftEyeLayer", 3800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("RightEyeLayer", 4000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MouthLayer", 4200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Nose", 4400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("EyebrowR", 4600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("EyebrowL", 4800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("FrontHeadLayer", 5000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ClavicleR", 5200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("FrontButtR", 5400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BoobL", 5600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BoobHighlightL", 5800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("HipsAngled", 6000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Navel", 6200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("LowerLegR", 6400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ShaftMask", 6600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("UpperLegR", 6800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Groin", 7000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("AreolaL", 7400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("NippleL", 7600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BoobR", 7800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BoobHighlightR", 8000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("AreolaR", 8200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("NippleR", 8400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("VulvaAngled", 8800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("HandL", 9000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Hand2R", 9200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Arm3R", 9400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ForearmR", 9600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("FrontLayer", 9800, 0);
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
dataForTimelineCreation.push(new MaleLegLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new MaleGroinTimelineData().GetTimelineData());
dataForTimelineCreation.push(new MaleLegRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ShaftMaskTimelineData().GetTimelineData());
dataForTimelineCreation.push(new PenisHighlightTimelineData().GetTimelineData());
dataForTimelineCreation.push(new MalePenisHeadTimelineData().GetTimelineData());
dataForTimelineCreation.push(new MaleShaftTimelineData().GetTimelineData());
            return dataForTimelineCreation;
        }

		private function GetTimelineDataForFemale():Vector.<Object>
        {
            var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
dataForTimelineCreation.push(new ForearmRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new Arm3RTimelineData().GetTimelineData());
dataForTimelineCreation.push(new Hand2RTimelineData().GetTimelineData());
dataForTimelineCreation.push(new HandLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new VulvaAngledTimelineData().GetTimelineData());

dataForTimelineCreation.push(new NippleRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new AreolaRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new BoobHighlightRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new BoobRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new NippleLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new AreolaLTimelineData().GetTimelineData());

dataForTimelineCreation.push(new GroinTimelineData().GetTimelineData());
dataForTimelineCreation.push(new UpperLegRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new LowerLegRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new NavelTimelineData().GetTimelineData());
dataForTimelineCreation.push(new HipsAngledTimelineData().GetTimelineData());
dataForTimelineCreation.push(new BoobHighlightLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new BoobLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new FrontButtRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ClavicleRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new EyebrowLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new EyebrowRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new NoseTimelineData().GetTimelineData());
dataForTimelineCreation.push(new EarRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new FaceAngledTimelineData().GetTimelineData());
dataForTimelineCreation.push(new NeckTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ClavicleLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ShoulderLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new MidTorsoAngledTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ChestAngledTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ForearmLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ArmLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new UpperLegLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new FrontButtLTimelineData().GetTimelineData());

dataForTimelineCreation.push(new LowerLegLTimelineData().GetTimelineData());
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
            var animateShard:AnimateShardMod = new AnimateShardMod("Anim8", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Male (Standard)", true, "Put description here");
            return animateShard;
        }

		private function CreateShardModForFemale():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForFemale();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForFemale();
            var animateShard:AnimateShardMod = new AnimateShardMod("Anim8", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Female (Standard)", true, "Put description here");
            return animateShard;
        }

		//}
		//End Animate Shard Region


    }
}