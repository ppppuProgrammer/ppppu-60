package Ros
{
    import animations.AnimateShard;
    import animations.DispObjInfo;
    import modifications.AnimateShardMod;
    import modifications.ModArchive;

    public class anim3_RosalinaAnimation
    {
       /* public static function anim3_RosalinaAnimation()
        {
            modsList[modsList.length] = CreateShardModForHair();
			modsList[modsList.length] = CreateShardModForHeadwear();
			modsList[modsList.length] = CreateShardModForEarringL();
			modsList[modsList.length] = CreateShardModForEarringR();
			modsList[modsList.length] = CreateShardModForFace();
			modsList[modsList.length] = CreateShardModForEyeL();
			modsList[modsList.length] = CreateShardModForEyeR();
			modsList[modsList.length] = CreateShardModForMouth();
			
        }*/

		public static function GetShardMods():Vector.<AnimateShardMod>
		{
			var shardMods:Vector.<AnimateShardMod> = new Vector.<AnimateShardMod>;
			shardMods[shardMods.length] = CreateShardModForHair();
			//shardMods[shardMods.length] = CreateShardModForHeadwear();
			//shardMods[shardMods.length] = CreateShardModForEarringL();
			//shardMods[shardMods.length] = CreateShardModForEarringR();
			shardMods[shardMods.length] = CreateShardModForFace();
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
dispInfo[dispInfo.length] = new DispObjInfo("Hair1R", 200, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair1L", 400, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair2R", 600, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair2L", 800, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("HairFront", 1000, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);

dispInfo[dispInfo.length] = new DispObjInfo("HairBack", 200, 0, "BehindHeadLayer", DispObjInfo.FLAG_CHILD);


dispInfo[dispInfo.length] = new DispObjInfo("Hair3R", 400, 0, "BehindEarLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair3L", 600, 0, "BehindEarLayer", DispObjInfo.FLAG_CHILD);





            return dispInfo;
        }

		/*private static function CreateDisplayInfoForHeadwear():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("Headwear", 200, 0, "BehindEarLayer", DispObjInfo.FLAG_CHILD);
            return dispInfo;
        }

		private static function CreateDisplayInfoForEarringL():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("EarringL", 1000, 0, "BehindEarLayer", DispObjInfo.FLAG_CHILD);
            return dispInfo;
        }

		private static function CreateDisplayInfoForEarringR():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("EarringR", 1200, 0, "BehindEarLayer", DispObjInfo.FLAG_CHILD);
            return dispInfo;
        }*/

		private static function CreateDisplayInfoForBody():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
//dispInfo[dispInfo.length] = new DispObjInfo("Symbol 47", 800, 0, "BehindEar", DispObjInfo.FLAG_CHILD);
            return dispInfo;
        }

		private static function CreateDisplayInfoForEyeL():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("ClosedLashL", 200, 0, "LeftEyeLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("ScleraL", 400, 0, "LeftEyeLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("EyeballL", 200, 0, "EyeMaskL", DispObjInfo.FLAG_MASKED);
dispInfo[dispInfo.length] = new DispObjInfo("EyelidL", 400, 0, "EyeMaskL", DispObjInfo.FLAG_MASKED);
dispInfo[dispInfo.length] = new DispObjInfo("EyeMaskL", 600, 0, "LeftEyeLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("EyelashL", 800, 0, "LeftEyeLayer", DispObjInfo.FLAG_CHILD);
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
            return dispInfo;
        }

		//}
		//End Display Object Information Region

		//Timeline Data Region
		//{
		private static function GetTimelineDataForHair():Vector.<Object>
        {
            var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
			
			dataForTimelineCreation.push(new HairFrontTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new Hair2LTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new Hair2RTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new Hair1LTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new Hair1RTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new Hair3LTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new Hair3RTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new HairBackTimelineData().GetTimelineData());
            return dataForTimelineCreation;
        }

		/*private static function GetTimelineDataForHeadwear():Vector.<Object>
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
        }*/

		private static function GetTimelineDataForFace():Vector.<Object>
        {
            var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
			dataForTimelineCreation.push(new Ros.FaceTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new Ros.NoseTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new Ros.EarLTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new Ros.EarRTimelineData().GetTimelineData());
            return dataForTimelineCreation;
        }

		private static function GetTimelineDataForEyeL():Vector.<Object>
        {
            var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
dataForTimelineCreation.push(new ClosedLashLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new EyelashLTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new EyeMaskLTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new EyelidLTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new EyeballLTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new ScleraLTimelineData().GetTimelineData());
            return dataForTimelineCreation;
        }

		private static function GetTimelineDataForEyeR():Vector.<Object>
        {
            var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
dataForTimelineCreation.push(new EyelashRTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new EyeMaskRTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new EyelidRTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new EyeballRTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new ScleraRTimelineData().GetTimelineData());
			dataForTimelineCreation.push(new ClosedLashRTimelineData().GetTimelineData());
            return dataForTimelineCreation;
        }

		private static function GetTimelineDataForMouth():Vector.<Object>
        {
            var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
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
            var animateShard:AnimateShardMod = new AnimateShardMod("anim3", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Rosalina Hair (ver2)", false, "For use with Face ver 2 shard");
            return animateShard;
        }

		/*private static function CreateShardModForHeadwear():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForHeadwear();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForHeadwear();
            var animateShard:AnimateShardMod = new AnimateShardMod("anim3", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Headwear (ver2)", false, "Put description here");
            return animateShard;
        }

		private static function CreateShardModForEarringL():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForEarringL();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEarringL();
            var animateShard:AnimateShardMod = new AnimateShardMod("anim3", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "EarringL (ver2)", false, "Put description here");
            return animateShard;
        }

		private static function CreateShardModForEarringR():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForEarringR();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEarringR();
            var animateShard:AnimateShardMod = new AnimateShardMod("anim3", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "EarringR (ver2)", false, "Put description here");
            return animateShard;
        }*/

		private static function CreateShardModForFace():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForFace();
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>;
            var animateShard:AnimateShardMod = new AnimateShardMod("anim3", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Face ver2", false, "Put description here");
            return animateShard;
        }

		private static function CreateShardModForEyeL():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForEyeL();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEyeL();
            var animateShard:AnimateShardMod = new AnimateShardMod("anim3", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Left Eye (ver2)", false, "For use with Face ver 2 shard");
            return animateShard;
        }

		private static function CreateShardModForEyeR():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForEyeR();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEyeR();
            var animateShard:AnimateShardMod = new AnimateShardMod("anim3", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Right Eye (ver2)", false, "For use with Face ver 2 shard");
            return animateShard;
        }

		private static function CreateShardModForMouth():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForMouth();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForMouth();
            var animateShard:AnimateShardMod = new AnimateShardMod("anim3", Vector.<String>(["Categories", "Here", "Standard"]), timelineData, dispInfo, "Mouth (ver2)", false, "For use with Face ver 2 shard");
            return animateShard;
        }

		//}
		//End Animate Shard Region


    }
}