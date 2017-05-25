package Ros
{
	import modifications.AnimateShardMod;
	import modifications.AnimationMod;
	import flash.display.Sprite;
	import flash.events.Event;
	import animations.DispObjInfo;
	//import Animations.Cowgirl.*;
	/**
	 * ...
	 * @author 
	 */
	public class Cowgirl_Rosalina
	{
		//private var timelinesData:Vector.<Object> = new Vector.<Object>();
		/*public static function Cowgirl_Rosalina() 
		{
			modsList.push(CreateShardModForHair());
			modsList.push(CreateShardModForCrown());
			modsList.push(CreateShardModForEarringL());
			modsList.push(CreateShardModForEarringR());
			modsList.push(CreateShardModForBodyChanges());
			modsList.push(CreateShardModForEyeL());
			modsList.push(CreateShardModForEyeR());
			modsList.push(CreateShardModForMouth());			
		}*/
		
		public static function GetShardMods():Vector.<AnimateShardMod>
		{
			var shardMods:Vector.<AnimateShardMod> = new Vector.<AnimateShardMod>;
			shardMods[shardMods.length] = CreateShardModForHair();
			//shardMods[shardMods.length] = CreateShardModForCrown();
			//shardMods[shardMods.length] = CreateShardModForEarringL();
			//shardMods[shardMods.length] = CreateShardModForEarringR();
			shardMods[shardMods.length] = CreateShardModForBodyChanges();
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
			dispInfo[dispInfo.length] = new DispObjInfo("HairBack", 200, 0, "BackLayer", DispObjInfo.FLAG_CHILD);
			
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
			var animateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Addition", "Rosalina", "Hair", "Standard"]), timelineData, dispInfo, "Rosalina Hair", false, "Adds Rosalina's hair (Cowgirl position)");
			return animateShard;
		}
		//}
		
		//Crown
		//{
		/*private static function GetTimelineDataForCrown():Vector.<Object>
		{
			var vector:Vector.<Object> = new Vector.<Object>();
			vector.push(new HeadwearTimelineData().GetTimelineData());
			return vector;
		}
		
		private static function CreateDisplayInfoForCrown():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			dispInfo[dispInfo.length] = new DispObjInfo("Headwear", 100, 0, "BehindEarLayer", DispObjInfo.FLAG_CHILD);
			return dispInfo;
		}
		
		private static function CreateShardModForCrown():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForCrown();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForCrown();
			var animateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Addition", "Rosalina", "Crown", "Accessories", "Standard"]), timelineData, dispInfo, "Rosalina Crown", false, "Adds Rosalina's crown (Cowgirl position)");
			return animateShard;
		}*/
		//}
		
		//Earring (L)
		//{
		/*private static function GetTimelineDataForEarringL():Vector.<Object>
		{
			var vector:Vector.<Object> = new Vector.<Object>();
			vector.push(new EarringLTimelineData().GetTimelineData());
			return vector;
		}
		
		private static function CreateDisplayInfoForEarringL():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			
			dispInfo[dispInfo.length] = new DispObjInfo("EarringL", 500, 0, "BehindEarLayer", DispObjInfo.FLAG_CHILD);
			return dispInfo;
		}
		
		private static function CreateShardModForEarringL():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForEarringL();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEarringL();
			var animateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Addition", "Rosalina", "Earrings", "Left", "Accessories", "Standard"]), timelineData, dispInfo, "Rosalina Earring Left", false, "Adds Rosalina's earrings for the left ear (Cowgirl position)");
			return animateShard;
		}
		//}
		
		//Earring (R)
		//{
		private static function GetTimelineDataForEarringR():Vector.<Object>
		{
			var vector:Vector.<Object> = new Vector.<Object>();
			vector.push(new EarringRTimelineData().GetTimelineData());
			return vector;
		}
		
		private static function CreateDisplayInfoForEarringR():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			dispInfo[dispInfo.length] = new DispObjInfo("EarringR", 600, 0, "BehindEarLayer", DispObjInfo.FLAG_CHILD);
			return dispInfo;
		}
		
		private static function CreateShardModForEarringR():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForEarringR();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEarringR();
			var animateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Addition", "Rosalina", "Earrings", "Right", "Accessories", "Standard"]), timelineData, dispInfo, "Rosalina Earring R", false, "Adds Rosalina's earrings for the right ear (Cowgirl position)");
			return animateShard;
		}*/
		//}
		
		//Body changes
		//{
		private static function GetTimelineDataForBodyChanges():Vector.<Object>
		{
			var vector:Vector.<Object> = new Vector.<Object>();
			vector.push(new Ros.ArmRTimelineData().GetTimelineData());
			vector.push(new EyelidRTimelineData().GetTimelineData());
			vector.push(new EyeMaskRTimelineData().GetTimelineData());
			vector.push(new EyeballRTimelineData().GetTimelineData());
			vector.push(new ClosedLashRTimelineData().GetTimelineData());
			vector.push(new ScleraRTimelineData().GetTimelineData());
			vector.push(new EyelashRTimelineData().GetTimelineData());
			
			vector.push(new EyeballLTimelineData().GetTimelineData());
			vector.push(new EyelidLTimelineData().GetTimelineData());
			vector.push(new EyeMaskLTimelineData().GetTimelineData());
			vector.push(new EyelashLTimelineData().GetTimelineData());
			vector.push(new ClosedLashLTimelineData().GetTimelineData());
			vector.push(new ScleraLTimelineData().GetTimelineData());
			
			vector.push(new Ros.ForearmRTimelineData().GetTimelineData());
			vector.push(new Ros.HandRTimelineData().GetTimelineData());
			vector.push(new ClosedSmileTimelineData().GetTimelineData());
			
			return vector;
		}
		
		private static function CreateDisplayInfoForBodyChanges():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			/*dispInfo[dispInfo.length] = new DispObjInfo("BackLayer", 200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BehindHeadLayer", 400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ArmL", 600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("HandR", 800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ArmR", 1000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ShoulderL", 1200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ShoulderR", 1400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Neck", 1600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("FrontButtR", 1800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("FrontButtL", 2000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Chest", 2200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Hips", 2400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Navel", 2600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MaleLegL", 2800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MaleLegR", 3000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("LowerLegR", 3200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("UpperLegR", 3400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("LowerLegL", 3600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("UpperLegL", 3800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MaleGroin", 4000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ShaftMask", 4200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Groin", 4400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Vulva", 4600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MaleBody", 4800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ClavicleR", 5000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ClavicleL", 5200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BoobL", 5400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BoobHighlightL", 5600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("AreolaL", 5800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("NippleL", 6000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BehindEarLayer", 6200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("EarL", 6400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("EarR", 6600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("FrontEarLayer", 6800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Face", 7000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("RightEyeLayer", 7200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("LeftEyeLayer", 7400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("FrontHeadLayer", 7600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("EyebrowR", 7800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("EyebrowL", 8000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Nose", 8200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MouthLayer", 8400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ForearmR", 8600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("HandL", 8800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ForearmL", 9000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BoobR", 9200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BoobHighlightR", 9400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("AreolaR", 9600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("NippleR", 9800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("FrontLayer", 10000, 0);*/
			
			return dispInfo;
		}
		
		private static function CreateShardModForBodyChanges():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForBodyChanges();
			var dispInfo:Vector.<DispObjInfo> = null;
			var bodyAnimateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Replacement", "Rosalina", "Body", "Standard"]), timelineData, dispInfo, "Body Variant 1", false, "Body animations change that has the left arm of the character bent at an angle with their hand on their hip. Used for Rosalina's default animation.");
			return bodyAnimateShard;
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
			var bodyAnimateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Replacement", "Rosalina", "Eye", "Standard"]), timelineData, dispInfo, "Left Eye Variant 2", false, "Eye animation originally used for Rosalina");
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
			var bodyAnimateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Replacement", "Rosalina", "Eye", "Standard"]), timelineData, dispInfo, "Right Eye Variant 2", false, "Eye animation originally used for Rosalina");
			return bodyAnimateShard;
		}
		
		private static function GetTimelineDataForMouth():Vector.<Object>
		{
			var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
			dataForTimelineCreation.push(new ClosedSmileTimelineData().GetTimelineData());
			return dataForTimelineCreation;
		}
		
		private static function CreateDisplayInfoForMouth():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("ClosedSmile", 200, 0, "MouthLayer", DispObjInfo.FLAG_CHILD);

			return dispInfo;
		}		
		
		private static function CreateShardModForMouth():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForMouth();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForMouth();
			var bodyAnimateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Replacement", "Rosalina", "Mouth", "Standard"]), timelineData, dispInfo, "Mouth Variant 2", false, "Body animations changes for Rosalina");
			return bodyAnimateShard;
		}
	}

}