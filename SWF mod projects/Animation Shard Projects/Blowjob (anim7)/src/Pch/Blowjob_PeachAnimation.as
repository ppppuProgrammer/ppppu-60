package Pch
{
    import animations.AnimateShard;
    import animations.DispObjInfo;
    import modifications.AnimateShardMod;

    public class Blowjob_PeachAnimation
    {
        /*public static function Blowjob_PeachAnimation()
        {
            modsList[modsList.length] = CreateShardModForHair();
			modsList[modsList.length] = CreateShardModForHeadwear();
			modsList[modsList.length] = CreateShardModForEarringL();
			modsList[modsList.length] = CreateShardModForEarringR();
			//modsList[modsList.length] = CreateShardModForBody();
			modsList[modsList.length] = CreateShardModForEyeL();
			modsList[modsList.length] = CreateShardModForEyeR();
			//modsList[modsList.length] = CreateShardModForMouth();
			
        }*/
		
		public static function GetShardMods():Vector.<AnimateShardMod>
		{
			var shardMods:Vector.<AnimateShardMod> = new Vector.<AnimateShardMod>;
			shardMods[shardMods.length] = CreateShardModForHair();
			shardMods[shardMods.length] = CreateShardModForHeadwear();
			shardMods[shardMods.length] = CreateShardModForEarringL();
			shardMods[shardMods.length] = CreateShardModForEarringR();
			//shardMods[shardMods.length] = CreateShardModForBody();
			shardMods[shardMods.length] = CreateShardModForEyeL();
			shardMods[shardMods.length] = CreateShardModForEyeR();
			//shardMods[shardMods.length] = CreateShardModForMouth();
			return shardMods;
		}

        //Display Object Information Region
		//{
		private static function CreateDisplayInfoForHair():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("HairBack", 200, 0, "BehindHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair1L", 400, 0, "FrontEarLayer", DispObjInfo.FLAG_CHILD);
//dispInfo[dispInfo.length] = new DispObjInfo("WideMouth", 200, 0, "MouthLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair1R", 400, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair3R", 600, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair3L", 800, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair2L", 1200, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair2R", 1400, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("HairFrontAngled", 1600, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);

dispInfo[dispInfo.length] = new DispObjInfo("HairBack", 200, 2.0, "BehindHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair1L", 400, 2.0, "FrontEarLayer", DispObjInfo.FLAG_CHILD);
//dispInfo[dispInfo.length] = new DispObjInfo("WideMouth", 200, 2.0, "MouthLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair1R", 400, 2.0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair3R", 600, 2.0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair3L", 800, 2.0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair2L", 1200, 2.0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair2R", 1400, 2.0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("HairFrontAngled", 1600, 2.0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
            return dispInfo;
        }

		private static function CreateDisplayInfoForHeadwear():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("Headwear", 1000, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Headwear", 1000, 2.0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
            return dispInfo;
        }

		private static function CreateDisplayInfoForEarringL():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("EarringL", 200, 0, "FrontEarLayer", DispObjInfo.FLAG_CHILD);

dispInfo[dispInfo.length] = new DispObjInfo("EarringL", 200, 2.0, "FrontEarLayer", DispObjInfo.FLAG_CHILD);
            return dispInfo;
        }

		private static function CreateDisplayInfoForEarringR():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("EarringR", 200, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);

dispInfo[dispInfo.length] = new DispObjInfo("EarringR", 200, 2.0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
            return dispInfo;
        }

		private static function CreateDisplayInfoForBody():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();

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

dispInfo[dispInfo.length] = new DispObjInfo("ClosedLashL", 200, 2.0, "LeftEyeLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("ScleraL", 400, 2.0, "LeftEyeLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("EyeballL", 200, 2.0, "EyeMaskL", DispObjInfo.FLAG_MASKED);
dispInfo[dispInfo.length] = new DispObjInfo("EyelidL", 400, 2.0, "EyeMaskL", DispObjInfo.FLAG_MASKED);
dispInfo[dispInfo.length] = new DispObjInfo("EyeMaskL", 600, 2.0, "LeftEyeLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("EyelashL", 800, 2.0, "LeftEyeLayer", DispObjInfo.FLAG_CHILD);
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

dispInfo[dispInfo.length] = new DispObjInfo("ClosedLashR", 200, 2.0, "RightEyeLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("ScleraR", 400, 2.0, "RightEyeLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("EyeballR", 200, 2.0, "EyeMaskR", DispObjInfo.FLAG_MASKED);
dispInfo[dispInfo.length] = new DispObjInfo("EyelidR", 400, 2.0, "EyeMaskR", DispObjInfo.FLAG_MASKED);
dispInfo[dispInfo.length] = new DispObjInfo("EyeMaskR", 600, 2.0, "RightEyeLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("EyelashR", 800, 2.0, "RightEyeLayer", DispObjInfo.FLAG_CHILD);
            return dispInfo;
        }

		private static function CreateDisplayInfoForMouth():Vector.<DispObjInfo>
        {
            var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();

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
            var animateShard:AnimateShardMod = new AnimateShardMod("Blowjob", Vector.<String>(["Peach", "Hair", "Standard"]), timelineData, dispInfo, "Peach Hair", false, "Adds Peach's hair onto the character.");
            return animateShard;
        }

		private static function CreateShardModForHeadwear():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForHeadwear();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForHeadwear();
            var animateShard:AnimateShardMod = new AnimateShardMod("Blowjob", Vector.<String>(["Headwear", "Crown", "Peach", "Rosalina", "Standard"]), timelineData, dispInfo, "Crown", false, "Adds an crown on top of the character's head, slighty obscured by their hair. Intended for the crown of Peach or Rosalina.");
            return animateShard;
        }

		private static function CreateShardModForEarringL():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForEarringL();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEarringL();
            var animateShard:AnimateShardMod = new AnimateShardMod("Blowjob", Vector.<String>(["Earring", "Left", "Standard"]), timelineData, dispInfo, "Left Earring", false, "Adds an earring for the left ear. Intended for the earrings of Peach or Rosalina.");
            return animateShard;
        }

		private static function CreateShardModForEarringR():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForEarringR();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEarringR();
            var animateShard:AnimateShardMod = new AnimateShardMod("Blowjob", Vector.<String>(["Earring", "Left", "Standard"]), timelineData, dispInfo, "Right Earring", false, "Adds an earring for the right ear. Intended for the earrings of Peach or Rosalina.");
            return animateShard;
        }

		private static function CreateShardModForEyeL():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForEyeL();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEyeL();
            var animateShard:AnimateShardMod = new AnimateShardMod("Blowjob", Vector.<String>(["Eye", "Left", "Standard"]), timelineData, dispInfo, "Left Eye Variant 1", false, "Eye Motion: Closed > Open. Originally used for Peach's default animation.");
            return animateShard;
        }

		private static function CreateShardModForEyeR():AnimateShardMod
        {
            var timelineData:Vector.<Object> = GetTimelineDataForEyeR();
            var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEyeR();
            var animateShard:AnimateShardMod = new AnimateShardMod("Blowjob", Vector.<String>(["Eye", "Right", "Standard"]), timelineData, dispInfo, "Right Eye Variant 1", false, "Eye Motion: Closed > Open. Originally used for Peach's default animation.");
            return animateShard;
        }

		//}
		//End Animate Shard Region


    }
}