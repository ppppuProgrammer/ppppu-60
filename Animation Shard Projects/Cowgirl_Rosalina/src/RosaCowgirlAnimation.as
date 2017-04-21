package
{
	import modifications.AnimateShardMod;
	import modifications.AnimationMod;
	import flash.display.Sprite;
	import flash.events.Event;
	import modifications.ModArchive;
	import animations.DispObjInfo;
	//import Animations.Cowgirl.*;
	/**
	 * ...
	 * @author 
	 */
	public class RosaCowgirlAnimation extends ModArchive
	{
		//private var timelinesData:Vector.<Object> = new Vector.<Object>();
		public function RosaCowgirlAnimation() 
		{
			modsList.push(CreateShardModForHair());
			modsList.push(CreateShardModForCrown());
			modsList.push(CreateShardModForEarringL());
			modsList.push(CreateShardModForEarringR());
			modsList.push(CreateShardModForBodyChanges());
			modsList.push(CreateShardModForEyeL());
			modsList.push(CreateShardModForEyeR());
			modsList.push(CreateShardModForMouth());
			/*timelinesData = new Vector.<Object>();
			this.addEventListener(Event.ADDED_TO_STAGE, FirstFrame);
			this.characterName = "Rosalina";
			this.animationName = "Cowgirl";
			this.displayOrderList = '{"0":{"RosaHairBack":0,"ArmL":1,"HandR":2,"ArmR":3,"ShoulderL":4,"ShoulderR":5,"Neck":6,"FrontButtR":7,"FrontButtL":8,"Chest":9,"Hips":10,"Navel":11,"MaleLegL":12,"MaleLegR":13,"RosaLowerLegR":14,"UpperLegR":15,"RosaLowerLegL":16,"UpperLegL":17,"MaleGroin":18,"MaleShaft":19.01,"MalePenisHead":19.02,"ShaftMask":19,"Groin":20,"Vulva":21,"MaleBody":22,"ClavicleR":23,"ClavicleL":24,"BoobL":25,"AreolaL":26,"NippleL":27,"RosaCrown":28,"RosaHair3R":29,"RosaHair3L":30,"RosaEarringL":31,"RosaEarringR":32,"EarL":33,"EarR":34,"Face":35,"ScleraR":36,"RosaPupilR":37.01,"EyelidR":37.02,"EyeMaskR":37,"EyelashR":38,"RosaHair1R":39,"RosaHair1L":40,"RosaHair2R":41,"RosaHair2L":42,"RosHairFront":43,"EyebrowR":44,"EyebrowL":45,"Nose":46,"RosaClosedSmile":47,"ClosedLashR":48,"ForearmR":49,"HandL":50,"ForearmL":51,"BoobR":52,"AreolaR":53,"NippleR":54}}';*/
			
		}
		
		//Hair
		//{
		private function GetTimelineDataForHair():Vector.<Object>
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
		
		private function CreateDisplayInfoForHair():Vector.<DispObjInfo>
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
		
		private function CreateShardModForHair():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForHair();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForHair();
			var animateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Addition", "Rosalina", "Hair"]), timelineData, dispInfo, "Rosalina Hair", false, "Adds Rosalina's hair (Cowgirl position)");
			return animateShard;
		}
		//}
		
		//Crown
		//{
		private function GetTimelineDataForCrown():Vector.<Object>
		{
			var vector:Vector.<Object> = new Vector.<Object>();
			vector.push(new HeadwearTimelineData().GetTimelineData());
			return vector;
		}
		
		private function CreateDisplayInfoForCrown():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			dispInfo[dispInfo.length] = new DispObjInfo("Headwear", 100, 0, "BehindEarLayer", DispObjInfo.FLAG_CHILD);
			return dispInfo;
		}
		
		private function CreateShardModForCrown():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForCrown();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForCrown();
			var animateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Addition", "Rosalina", "Crown", "Accessories"]), timelineData, dispInfo, "Rosalina Crown", false, "Adds Rosalina's crown (Cowgirl position)");
			return animateShard;
		}
		//}
		
		//Earring (L)
		//{
		private function GetTimelineDataForEarringL():Vector.<Object>
		{
			var vector:Vector.<Object> = new Vector.<Object>();
			vector.push(new EarringLTimelineData().GetTimelineData());
			return vector;
		}
		
		private function CreateDisplayInfoForEarringL():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			
			dispInfo[dispInfo.length] = new DispObjInfo("EarringL", 500, 0, "BehindEarLayer", DispObjInfo.FLAG_CHILD);
			return dispInfo;
		}
		
		private function CreateShardModForEarringL():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForEarringL();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEarringL();
			var animateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Addition", "Rosalina", "Earrings", "Left", "Accessories"]), timelineData, dispInfo, "Rosalina Earring Left", false, "Adds Rosalina's earrings for the left ear (Cowgirl position)");
			return animateShard;
		}
		//}
		
		//Earring (R)
		//{
		private function GetTimelineDataForEarringR():Vector.<Object>
		{
			var vector:Vector.<Object> = new Vector.<Object>();
			vector.push(new EarringRTimelineData().GetTimelineData());
			return vector;
		}
		
		private function CreateDisplayInfoForEarringR():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			dispInfo[dispInfo.length] = new DispObjInfo("EarringR", 600, 0, "BehindEarLayer", DispObjInfo.FLAG_CHILD);
			return dispInfo;
		}
		
		private function CreateShardModForEarringR():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForEarringR();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEarringR();
			var animateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Addition", "Rosalina", "Earrings", "Right", "Accessories"]), timelineData, dispInfo, "Rosalina Earring R", false, "Adds Rosalina's earrings for the right ear (Cowgirl position)");
			return animateShard;
		}
		//}
		
		//Body changes
		//{
		private function GetTimelineDataForBodyChanges():Vector.<Object>
		{
			var vector:Vector.<Object> = new Vector.<Object>();
			vector.push(new ArmRTimelineData().GetTimelineData());
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
			
			vector.push(new ForearmRTimelineData().GetTimelineData());
			vector.push(new HandRTimelineData().GetTimelineData());
			vector.push(new ClosedSmileTimelineData().GetTimelineData());
			
			return vector;
		}
		
		private function CreateDisplayInfoForBodyChanges():Vector.<DispObjInfo>
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
		
		private function CreateShardModForBodyChanges():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForBodyChanges();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForBodyChanges();
			var bodyAnimateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Replacement", "Rosalina", "Body"]), timelineData, dispInfo, "Rosalina Body", false, "Body animations changes for Rosalina (Cowgirl position)");
			return bodyAnimateShard;
		}
		//}
		
		
		
		
		private function GetTimelineDataForEyeL():Vector.<Object>
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
		
		private function CreateDisplayInfoForEyeL():Vector.<DispObjInfo>
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
		
		private function CreateShardModForEyeL():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForEyeL();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEyeL();
			var bodyAnimateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Replacement", "Rosalina", "Eye"]), timelineData, dispInfo, "Rosalina Left Eye", false, "Body animations changes for Rosalina (Cowgirl position)");
			return bodyAnimateShard;
		}
		
		private function GetTimelineDataForEyeR():Vector.<Object>
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
		
		private function CreateDisplayInfoForEyeR():Vector.<DispObjInfo>
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
		
		private function CreateShardModForEyeR():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForEyeR();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEyeR();
			var bodyAnimateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Replacement", "Rosalina", "Eye"]), timelineData, dispInfo, "Rosalina Right Eye", false, "Body animations changes for Rosalina (Cowgirl position)");
			return bodyAnimateShard;
		}
		
		private function GetTimelineDataForMouth():Vector.<Object>
		{
			var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
			dataForTimelineCreation.push(new ClosedSmileTimelineData().GetTimelineData());
			return dataForTimelineCreation;
		}
		
		private function CreateDisplayInfoForMouth():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
dispInfo[dispInfo.length] = new DispObjInfo("ClosedSmile", 200, 0, "MouthLayer", DispObjInfo.FLAG_CHILD);

			return dispInfo;
		}		
		
		private function CreateShardModForMouth():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForMouth();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForMouth();
			var bodyAnimateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Replacement", "Rosalina", "Mouth"]), timelineData, dispInfo, "Rosalina Mouth", false, "Body animations changes for Rosalina (Cowgirl position)");
			return bodyAnimateShard;
		}
	}

}