package
{
	import Pch.Paizuri_PeachAnimation;
	import Ros.Paizuri_RosalinaAnimation;
    import animations.AnimateShard;
    import animations.DispObjInfo;
    import modifications.AnimateShardMod;
    import modifications.ModArchive;

    public class PaizuriAnimation extends ModArchive
    {
        public function PaizuriAnimation()
        {
            modsList[modsList.length] = CreateShardModForMale();
			modsList[modsList.length] = CreateShardModForFemale();
			modsList[modsList.length] = CreateShardModForMouth();
			modsList = modsList.concat(Paizuri_PeachAnimation.GetShardMods(), Paizuri_RosalinaAnimation.GetShardMods());
        }

        //Display Object Information Region
		//{
		private function CreateDisplayInfoForMale():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("MaleLegL", 1000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MaleLegR", 1200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MaleGroin", 5200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MaleShaft", 5400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ShaftMask2", 5600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MaleBody", 5800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MalePenisHead", 200, 0, "ShaftMask2", DispObjInfo.FLAG_MASKED);
dispInfo[dispInfo.length] = new DispObjInfo("PenisHighlight", 400, 0, "ShaftMask2", DispObjInfo.FLAG_MASKED);
            return dispInfo;
        }

		private function CreateDisplayInfoForFemale():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("BackLayer", 200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BehindHeadLayer", 400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Hips2", 600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Chest", 800, 0);

dispInfo[dispInfo.length] = new DispObjInfo("Arm2R", 1400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Arm2L", 1600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ShoulderL", 1800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ShoulderR", 2000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Neck", 2200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BehindEarLayer", 2400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("EarL", 2600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("EarR", 2800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("FrontEarLayer", 3000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Face", 3200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("RightEyeLayer", 3400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("LeftEyeLayer", 3600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("FrontHeadLayer", 3800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("EyebrowR", 4000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("EyebrowL", 4200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Nose", 4400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MouthLayer", 4600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ClavicleR", 4800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ClavicleL", 5000, 0);

dispInfo[dispInfo.length] = new DispObjInfo("Boob3L", 6000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BoobHighlightL", 6200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("AreolaL", 6400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("NippleL", 6600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Boob3R", 6800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BoobHighlightR", 7000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("AreolaR", 7200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("NippleR", 7400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Hand2R", 7600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ForearmR", 7800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Hand2L", 8000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ForearmL", 8200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("FrontLayer", 8400, 0);
            return dispInfo;
        }

		private function CreateDisplayInfoForMouth():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("WideMouth", 200, 0, "MouthLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("WideTeardropMouth", 400, 0, "MouthLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Tongue", 600, 0, "MouthLayer", DispObjInfo.FLAG_CHILD);
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
			dataForTimelineCreation.push(new ShaftMask2TimelineData().GetTimelineData());
			dataForTimelineCreation.push(new PenisHighlightTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new MalePenisHeadTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new MaleShaftTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new MaleGroinTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new MaleLegRTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new MaleLegLTimelineData().GetTimelineData());
            return dataForTimelineCreation;
        }

		private function GetTimelineDataForFemale():Vector.<Object>
        {
            var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
			dataForTimelineCreation.push(new ForearmLTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new Hand2LTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new ForearmRTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new Hand2RTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new NippleRTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new AreolaRTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new BoobHighlightRTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new Boob3RTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new NippleLTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new AreolaLTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new BoobHighlightLTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new Boob3LTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new ClavicleLTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new ClavicleRTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new NoseTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new EyebrowLTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new EyebrowRTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new FaceTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new EarRTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new EarLTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new NeckTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new ShoulderRTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new ShoulderLTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new Arm2LTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new Arm2RTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new ChestTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new Hips2TimelineData().GetTimelineData());
            return dataForTimelineCreation;
        }

		private function GetTimelineDataForMouth():Vector.<Object>
        {
            var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
dataForTimelineCreation.push(new TongueTimelineData().GetTimelineData());
dataForTimelineCreation.push(new WideTeardropMouthTimelineData().GetTimelineData());
dataForTimelineCreation.push(new WideMouthTimelineData().GetTimelineData());
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
            var animateShard:AnimateShardMod = new AnimateShardMod("Paizuri", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Male (Standard)", true, "Put description here");
            return animateShard;
        }

		private function CreateShardModForFemale():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForFemale();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForFemale();
            var animateShard:AnimateShardMod = new AnimateShardMod("Paizuri", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Female (Standard)", true, "Put description here");
            return animateShard;
        }

		private function CreateShardModForMouth():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForMouth();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForMouth();
            var animateShard:AnimateShardMod = new AnimateShardMod("Paizuri", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Mouth (Standard)", true, "Put description here");
            return animateShard;
        }

		//}
		//End Animate Shard Region


    }
}