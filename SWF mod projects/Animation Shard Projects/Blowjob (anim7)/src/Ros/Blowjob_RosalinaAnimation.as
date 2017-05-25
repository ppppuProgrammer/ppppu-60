package Ros
{
    import animations.AnimateShard;
    import animations.DispObjInfo;
    import modifications.AnimateShardMod;

    public class Blowjob_RosalinaAnimation
    {
        /*public static function Blowjob_RosalinaAnimation()
        {
            modsList[modsList.length] = CreateShardModForHair();
			modsList[modsList.length] = CreateShardModForEyeL();
			modsList[modsList.length] = CreateShardModForEyeR();
			
        }*/
		
		public static function GetShardMods():Vector.<AnimateShardMod>
		{
			var shardMods:Vector.<AnimateShardMod> = new Vector.<AnimateShardMod>;
			shardMods[shardMods.length] = CreateShardModForHair();
			shardMods[shardMods.length] = CreateShardModForEyeL();
			shardMods[shardMods.length] = CreateShardModForEyeR();
			return shardMods;
		}

        //Display Object Information Region
		//{
		private static function CreateDisplayInfoForHair():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("HairBack", 200, -1.0, "BehindHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair1L", 400, -1.0, "FrontEarLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair1R", 200, -1.0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair3R", 400, -1.0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair3L", 600, -1.0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair2L", 800, -1.0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair2R", 1000, -1.0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("HairFrontAngled", 1400, -1.0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
            return dispInfo;
        }

		private static function CreateDisplayInfoForEyeL():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("ClosedLashL", 200, -1.0, "LeftEyeLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("ScleraL", 400, -1.0, "LeftEyeLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("EyeballL", 200, -1.0, "EyeMaskL", DispObjInfo.FLAG_MASKED);
dispInfo[dispInfo.length] = new DispObjInfo("EyelidL", 400, -1.0, "EyeMaskL", DispObjInfo.FLAG_MASKED);
dispInfo[dispInfo.length] = new DispObjInfo("EyeMaskL", 600, -1.0, "LeftEyeLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("EyelashL", 800, -1.0, "LeftEyeLayer", DispObjInfo.FLAG_CHILD);
            return dispInfo;
        }

		private static function CreateDisplayInfoForEyeR():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("ClosedLashR", 200, -1.0, "RightEyeLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Sclera2R", 400, -1.0, "RightEyeLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("EyeballR", 200, -1.0, "EyeMask2R", DispObjInfo.FLAG_MASKED);
dispInfo[dispInfo.length] = new DispObjInfo("EyelidR", 400, -1.0, "EyeMask2R", DispObjInfo.FLAG_MASKED);
dispInfo[dispInfo.length] = new DispObjInfo("EyeMask2R", 600, -1.0, "RightEyeLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("EyelashR", 800, -1.0, "RightEyeLayer", DispObjInfo.FLAG_CHILD);
            return dispInfo;
        }

		//}
		//End Display Object Information Region

		//Timeline Data Region
		//{
		private static function GetTimelineDataForHair():Vector.<Object>
        {
            var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();

dataForTimelineCreation.push(new HairFrontAngledTimelineData().GetTimelineData());
dataForTimelineCreation.push(new Hair2RTimelineData().GetTimelineData());
dataForTimelineCreation.push(new Hair2LTimelineData().GetTimelineData());
dataForTimelineCreation.push(new Hair3LTimelineData().GetTimelineData());
dataForTimelineCreation.push(new Hair3RTimelineData().GetTimelineData());
dataForTimelineCreation.push(new Hair1RTimelineData().GetTimelineData());
dataForTimelineCreation.push(new Hair1LTimelineData().GetTimelineData());
dataForTimelineCreation.push(new HairBackTimelineData().GetTimelineData());
            return dataForTimelineCreation;
        }

		private static function GetTimelineDataForEyeL():Vector.<Object>
        {
            var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
dataForTimelineCreation.push(new EyelashLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new EyeMaskLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new EyelidLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new EyeballLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ScleraLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ClosedLashLTimelineData().GetTimelineData());
            return dataForTimelineCreation;
        }

		private static function GetTimelineDataForEyeR():Vector.<Object>
        {
            var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
dataForTimelineCreation.push(new EyelashRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new EyeMask2RTimelineData().GetTimelineData());
dataForTimelineCreation.push(new EyelidRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new EyeballRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new Sclera2RTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ClosedLashRTimelineData().GetTimelineData());
            return dataForTimelineCreation;
        }

		//}
		//End Timeline Data Region

		//Animate Shard Region
		//{
		private static function CreateShardModForHair():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForHair();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForHair();
            var animateShard:AnimateShardMod = new AnimateShardMod("Blowjob", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Rosalina Hair", false, "Put description here");
            return animateShard;
        }

		private static function CreateShardModForEyeL():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForEyeL();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEyeL();
            var animateShard:AnimateShardMod = new AnimateShardMod("Blowjob", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Left Eye Variant 2", false, "Put description here");
            return animateShard;
        }

		private static function CreateShardModForEyeR():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForEyeR();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEyeR();
            var animateShard:AnimateShardMod = new AnimateShardMod("Blowjob", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Right Eye Variant 2", false, "Put description here");
            return animateShard;
        }

		//}
		//End Animate Shard Region


    }
}