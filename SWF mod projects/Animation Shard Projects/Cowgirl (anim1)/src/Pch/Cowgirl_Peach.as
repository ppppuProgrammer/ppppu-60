package Pch
{
	import flash.display.Sprite;
	import flash.events.Event;
	import animations.DispObjInfo;
	import modifications.AnimateShardMod;
	import modifications.TemplateAnimationMod;
	//import Animations.Cowgirl.*;
	/**
	 * ...
	 * @author 
	 */
	public class Cowgirl_Peach
	{
		//private var timelinesData:Vector.<Object> = new Vector.<Object>();
		/*public static function Cowgirl_Peach() 
		{
			modsList.push(CreateShardModForHair());
			modsList.push(CreateShardModForCrown());
			modsList.push(CreateShardModForEarringL());
			modsList.push(CreateShardModForEarringR());
			modsList.push(CreateShardModForEyeL());
			modsList.push(CreateShardModForEyeR());
			modsList.push(CreateShardModForMouth());
			//modsList.push(CreateShardModForBodyChanges());
		}*/
		
		public static function GetShardMods():Vector.<AnimateShardMod>
		{
			var shardMods:Vector.<AnimateShardMod> = new Vector.<AnimateShardMod>;
			shardMods[shardMods.length] = CreateShardModForHair();
			shardMods[shardMods.length] = CreateShardModForCrown();
			shardMods[shardMods.length] = CreateShardModForEarringL();
			shardMods[shardMods.length] = CreateShardModForEarringR();
			//shardMods[shardMods.length] = CreateShardModForBody();
			shardMods[shardMods.length] = CreateShardModForEyeL();
			shardMods[shardMods.length] = CreateShardModForEyeR();
			shardMods[shardMods.length] = CreateShardModForMouth();
			return shardMods;
		}
		
		//Hair
		//{
		private static function GetTimelineDataForHair():Vector.<Object>
		{
			var vector:Vector.<Object> = new Vector.<Object>();
			vector.push(new Hair1LTimelineData().GetTimelineData());
			vector.push(new Hair1RTimelineData().GetTimelineData());
			vector.push(new Hair2LTimelineData().GetTimelineData());
			vector.push(new Hair2RTimelineData().GetTimelineData());
			vector.push(new Hair3LTimelineData().GetTimelineData());
			vector.push(new Hair3RTimelineData().GetTimelineData());
			vector.push(new HairBackTimelineData().GetTimelineData());
			vector.push(new HairFrontTimelineData().GetTimelineData());
			return vector;
		}
		
		private static function CreateDisplayInfoForHair():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			dispInfo[dispInfo.length] = new DispObjInfo("HairBack", 200, 0, "BehindHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair3R", 400, 0, "BehindEarLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair3L", 600, 0, "BehindEarLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair1R", 200, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair1L", 400, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair2R", 600, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair2L", 800, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("HairFront", 1000, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);

			return dispInfo;
		}
		
		private static function CreateShardModForHair():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForHair();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForHair();
			var animateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Addition", "Peach", "Hair", "Standard"]), timelineData, dispInfo, "Peach Hair", false, "Adds Peach's hair to the character");
			return animateShard;
		}
		//}
		
		//Crown
		//{
		private static function GetTimelineDataForCrown():Vector.<Object>
		{
			var vector:Vector.<Object> = new Vector.<Object>();
			vector.push(new HeadwearTimelineData().GetTimelineData());
			return vector;
		}
		
		private static function CreateDisplayInfoForCrown():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			dispInfo[dispInfo.length] = new DispObjInfo("Headwear", 200, 0, "BehindEarLayer", DispObjInfo.FLAG_CHILD);
			return dispInfo;
		}
		
		private static function CreateShardModForCrown():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForCrown();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForCrown();
			var animateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Headwear", "Crown", "Peach", "Rosalina", "Standard"]), timelineData, dispInfo, "Crown", false, "Adds an crown on top of the character's head, slighty obscured by their hair. Intended for the crown of Peach or Rosalina.");
			return animateShard;
		}
		//}
		
		//Earring (L)
		//{
		private static function GetTimelineDataForEarringL():Vector.<Object>
		{
			var vector:Vector.<Object> = new Vector.<Object>();
			vector.push(new EarringLTimelineData().GetTimelineData());
			//vector.push(new EarringRTimelineData().GetTimelineData());
			return vector;
		}
		
		private static function CreateDisplayInfoForEarringL():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			
			dispInfo[dispInfo.length] = new DispObjInfo("EarringL", 1000, 0, "BehindEarLayer", DispObjInfo.FLAG_CHILD);

			return dispInfo;
		}
		
		private static function CreateShardModForEarringL():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForEarringL();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEarringL();
			var animateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Addition", "Peach", "Earrings", "Left", "Accessories", "Standard"]), timelineData, dispInfo, "Left Earring", false, "Adds an earring for the left ear. Intended for the earrings of Peach or Rosalina.");
			return animateShard;
		}
		//}
		
		//Earring (R)
		//{
		private static function GetTimelineDataForEarringR():Vector.<Object>
		{
			var vector:Vector.<Object> = new Vector.<Object>();
			//vector.push(new EarringLTimelineData().GetTimelineData());
			vector.push(new EarringRTimelineData().GetTimelineData());
			return vector;
		}
		
		private static function CreateDisplayInfoForEarringR():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			dispInfo[dispInfo.length] = new DispObjInfo("EarringR", 1200, 0, "BehindEarLayer", DispObjInfo.FLAG_CHILD);

			return dispInfo;
		}
		
		private static function CreateShardModForEarringR():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForEarringR();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEarringR();
			var animateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Addition", "Peach", "Earrings", "Right", "Accessories", "Standard"]), timelineData, dispInfo, "Right Earring", false, "Adds an earring for the right ear. Intended for the earrings of Peach or Rosalina.");
			return animateShard;
		}
		//}
		
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
		
		private static function CreateShardModForEyeL():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForEyeL();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEyeL();
			var bodyAnimateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Peach", "Eye", "Left", "Standard"]), timelineData, dispInfo, "Left Eye var 1", false, "Eye Motion: Open > Closed > Half closed. Originally used for Peach's default animation.");
			return bodyAnimateShard;
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
		
		private static function CreateShardModForEyeR():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForEyeR();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEyeR();
			var bodyAnimateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Replacement", "Peach", "Eye", "Right", "Standard"]), timelineData, dispInfo, "Right Eye var 1", false, "Eye Motion: Open > Closed > Half closed. Originally used for Peach's default animation.");
			return bodyAnimateShard;
		}
		
		private static function GetTimelineDataForMouth():Vector.<Object>
		{
			var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
			dataForTimelineCreation.push(new ClosedSmileTimelineData().GetTimelineData());
dataForTimelineCreation.push(new OpenSmileTimelineData().GetTimelineData());
			return dataForTimelineCreation;
		}
		
		private static function CreateDisplayInfoForMouth():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			dispInfo[dispInfo.length] = new DispObjInfo("OpenSmile", 200, 0, "MouthLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("ClosedSmile", 400, 0, "MouthLayer", DispObjInfo.FLAG_CHILD);

			return dispInfo;
		}		
		
		private static function CreateShardModForMouth():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForMouth();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForMouth();
			var bodyAnimateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Replacement", "Peach", "Mouth", "Standard"]), timelineData, dispInfo, "Mouth var 1", false, "Mouth motion: Closed Smile > Open smile. Originally used for Peach's default animation.");
			return bodyAnimateShard;
		}
		//}
	}

}