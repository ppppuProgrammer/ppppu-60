package Ros
{
    import animations.AnimateShard;
    import animations.DispObjInfo;
    import modifications.AnimateShardMod;

    public class ReverseCowgirl_RosalinaAnimation
    {
        /*public static function ReverseCowgirl_RosalinaAnimation()
        {
            modsList[modsList.length] = CreateShardModForHair();
			modsList[modsList.length] = CreateShardModForHeadwear();
			modsList[modsList.length] = CreateShardModForEarringL();
			modsList[modsList.length] = CreateShardModForEarringR();
			//modsList[modsList.length] = CreateShardModForBody();
			modsList[modsList.length] = CreateShardModForEyeL();
			modsList[modsList.length] = CreateShardModForEyeR();
			modsList[modsList.length] = CreateShardModForMouth();
			
        }*/
		
		public static function GetShardMods():Vector.<AnimateShardMod>
		{
			var shardsList:Vector.<AnimateShardMod> = new Vector.<AnimateShardMod>;
			shardsList[shardsList.length] = CreateShardModForHair();
			//shardsList[shardsList.length] = CreateShardModForHeadwear();
			//shardsList[shardsList.length] = CreateShardModForEarringL();
			//shardsList[shardsList.length] = CreateShardModForEarringR();
			//shardsList[shardsList.length] = CreateShardModForBody();
			//shardsList[shardsList.length] = CreateShardModForEyeL();
			shardsList[shardsList.length] = CreateShardModForEyeR();
			shardsList[shardsList.length] = CreateShardModForMouth();
			return shardsList;
		}

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
dispInfo[dispInfo.length] = new DispObjInfo("HairFrontAngled", 1000, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);;
            return dispInfo;
        }

		private static function CreateDisplayInfoForHeadwear():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("Headwear", 400, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
            return dispInfo;
        }

		private static function CreateDisplayInfoForEarringL():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("EarringL", 200, 0, "BehindHeadLayer", DispObjInfo.FLAG_CHILD);
            return dispInfo;
        }

		private static function CreateDisplayInfoForEarringR():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("EarringR", 200, 0, "FrontEarLayer", DispObjInfo.FLAG_CHILD);
            return dispInfo;
        }

		private static function CreateDisplayInfoForBody():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();

            return dispInfo;
        }

		/*private static function CreateDisplayInfoForEyeL():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("ClosedLashL", 200, 0, "LeftEyeLayer", DispObjInfo.FLAG_CHILD);
            return dispInfo;
        }*/

		private static function CreateDisplayInfoForEyeR():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("ClosedLashR", 200, 0, "RightEyeLayer", DispObjInfo.FLAG_CHILD);
            return dispInfo;
        }

		private static function CreateDisplayInfoForMouth():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("ClosedSmile", 200, 0, "MouthLayer", DispObjInfo.FLAG_CHILD);
            return dispInfo;
        }

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

		private static function GetTimelineDataForHeadwear():Vector.<Object>
        {
            var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
dataForTimelineCreation.push(new HeadwearTimelineData().GetTimelineData());
            return dataForTimelineCreation;
        }

		private static function GetTimelineDataForEarringL():Vector.<Object>
        {
            var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
dataForTimelineCreation.push(new EarringLTimelineData().GetTimelineData());
            return dataForTimelineCreation;
        }

		private static function GetTimelineDataForEarringR():Vector.<Object>
        {
            var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
dataForTimelineCreation.push(new EarringRTimelineData().GetTimelineData());
            return dataForTimelineCreation;
        }

		private static function GetTimelineDataForBody():Vector.<Object>
        {
            var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();

            return dataForTimelineCreation;
        }

		/*private static function GetTimelineDataForEyeL():Vector.<Object>
        {
            var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
dataForTimelineCreation.push(new ClosedLashLTimelineData().GetTimelineData());
            return dataForTimelineCreation;
        }*/

		private static function GetTimelineDataForEyeR():Vector.<Object>
        {
            var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
dataForTimelineCreation.push(new ClosedLashRTimelineData().GetTimelineData());

            return dataForTimelineCreation;
        }

		private static function GetTimelineDataForMouth():Vector.<Object>
        {
            var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
dataForTimelineCreation.push(new ClosedSmileTimelineData().GetTimelineData());
            return dataForTimelineCreation;
        }

		private static function CreateShardModForHair():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForHair();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForHair();
            var animateShard:AnimateShardMod = new AnimateShardMod("Reverse Cowgirl", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Rosalina Hair", false, "Put description here");
            return animateShard;
        }

		private static function CreateShardModForHeadwear():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForHeadwear();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForHeadwear();
            var animateShard:AnimateShardMod = new AnimateShardMod("Reverse Cowgirl", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Rosalina Headwear", false, "Put description here");
            return animateShard;
        }

		private static function CreateShardModForEarringL():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForEarringL();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEarringL();
            var animateShard:AnimateShardMod = new AnimateShardMod("Reverse Cowgirl", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Rosalina EarringL", false, "Put description here");
            return animateShard;
        }

		private static function CreateShardModForEarringR():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForEarringR();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEarringR();
            var animateShard:AnimateShardMod = new AnimateShardMod("Reverse Cowgirl", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Rosalina EarringR", false, "Put description here");
            return animateShard;
        }

		private static function CreateShardModForBody():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForBody();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForBody();
            var animateShard:AnimateShardMod = new AnimateShardMod("Reverse Cowgirl", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Rosalina Body", false, "Put description here");
            return animateShard;
        }

		/*private static function CreateShardModForEyeL():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForEyeL();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEyeL();
            var animateShard:AnimateShardMod = new AnimateShardMod("Reverse Cowgirl", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Rosalina EyeL", false, "Put description here");
            return animateShard;
        }*/

		private static function CreateShardModForEyeR():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForEyeR();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEyeR();
            var animateShard:AnimateShardMod = new AnimateShardMod("Reverse Cowgirl", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Right Eye var 2", false, "Put description here");
            return animateShard;
        }

		private static function CreateShardModForMouth():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForMouth();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForMouth();
            var animateShard:AnimateShardMod = new AnimateShardMod("Reverse Cowgirl", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Mouth var 2", false, "Put description here");
            return animateShard;
        }

		
    }
}