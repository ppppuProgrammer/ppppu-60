package Ros
{
    import animations.AnimateShard;
    import animations.DispObjInfo;
    import modifications.AnimateShardMod;

    public class Anim8_RosalinaAnimation
    {
        /*public static function Anim8_RosalinaAnimation()
        {
            
			
        }*/
		
		public static function GetShardMods():Vector.<AnimateShardMod>
		{
			var shardMods:Vector.<AnimateShardMod> = new Vector.<AnimateShardMod>;
			shardMods[shardMods.length] = CreateShardModForHair();
			shardMods[shardMods.length] = CreateShardModForEyeL();
			shardMods[shardMods.length] = CreateShardModForEyeR();
			shardMods[shardMods.length] = CreateShardModForMouth();
			return shardMods;
		}

        //Display Object Information Region
		//{
		private static function CreateDisplayInfoForHair():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("HairBack", 200, 0, "BackLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair3L", 400, 0, "BehindHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair2L", 600, 0, "BehindHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair1L", 800, 0, "BehindHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair1R", 200, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair3R", 600, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair2R", 800, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("HairFrontAngled", 1000, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
            return dispInfo;
        }

		private static function CreateDisplayInfoForEyeL():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("ClosedLashL", 200, 0, "LeftEyeLayer", DispObjInfo.FLAG_CHILD);
            return dispInfo;
        }

		private static function CreateDisplayInfoForEyeR():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();			
			dispInfo[dispInfo.length] = new DispObjInfo("ClosedLashR", 200, 0, "RightEyeLayer", DispObjInfo.FLAG_CHILD);
			dispInfo[dispInfo.length] = new DispObjInfo("ScleraR", 400, 0, "RightEyeLayer", DispObjInfo.FLAG_CHILD);
			dispInfo[dispInfo.length] = new DispObjInfo("EyeballR", 200, 0, "EyeMaskR", DispObjInfo.FLAG_MASKED);
			dispInfo[dispInfo.length] = new DispObjInfo("EyelidR", 400, 0, "EyeMaskR", DispObjInfo.FLAG_MASKED);
			dispInfo[dispInfo.length] = new DispObjInfo("EyeMaskR", 600, 0, "RightEyeLayer", DispObjInfo.FLAG_CHILD);
			dispInfo[dispInfo.length] = new DispObjInfo("EyelashR", 800, 0, "RightEyeLayer", DispObjInfo.FLAG_CHILD);

            return dispInfo;
        }

		private static function CreateDisplayInfoForMouth():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("ClosedSmile", 200, 0, "MouthLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("OpenSmile", 400, 0, "MouthLayer", DispObjInfo.FLAG_CHILD);
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
dataForTimelineCreation.push(new Hair3RTimelineData().GetTimelineData());
dataForTimelineCreation.push(new Hair1RTimelineData().GetTimelineData());




dataForTimelineCreation.push(new Hair1LTimelineData().GetTimelineData());
dataForTimelineCreation.push(new Hair2LTimelineData().GetTimelineData());
dataForTimelineCreation.push(new Hair3LTimelineData().GetTimelineData());
dataForTimelineCreation.push(new HairBackTimelineData().GetTimelineData());
            return dataForTimelineCreation;
        }

	

		private static function GetTimelineDataForEyeL():Vector.<Object>
        {
            var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
dataForTimelineCreation.push(new ClosedLashLTimelineData().GetTimelineData());
            return dataForTimelineCreation;
        }

		private static function GetTimelineDataForEyeR():Vector.<Object>
        {
            var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
dataForTimelineCreation.push(new ClosedLashRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new EyelashRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new EyeMaskRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new EyelidRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ScleraRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new EyeballRTimelineData().GetTimelineData());
            return dataForTimelineCreation;
        }

		private static function GetTimelineDataForMouth():Vector.<Object>
        {
            var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
dataForTimelineCreation.push(new OpenSmileTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ClosedSmileTimelineData().GetTimelineData());
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
            var animateShard:AnimateShardMod = new AnimateShardMod("Anim8", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Rosalina Hair", false, "Put description here");
            return animateShard;
        }

		private static function CreateShardModForEyeL():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForEyeL();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEyeL();
            var animateShard:AnimateShardMod = new AnimateShardMod("Anim8", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Left Eye Variant 2", false, "Put description here");
            return animateShard;
        }

		private static function CreateShardModForEyeR():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForEyeR();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEyeR();
            var animateShard:AnimateShardMod = new AnimateShardMod("Anim8", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Right Eye Variant 2", false, "Put description here");
            return animateShard;
        }

		private static function CreateShardModForMouth():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForMouth();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForMouth();
            var animateShard:AnimateShardMod = new AnimateShardMod("Anim8", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Mouth Variant 2", false, "Put description here");
            return animateShard;
        }

		//}
		//End Animate Shard Region


    }
}