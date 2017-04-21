package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import animations.DispObjInfo;
	import modifications.AnimateShardMod;
	import modifications.ModArchive;
	import modifications.TemplateAnimationMod;
	//import Animations.Cowgirl.*;
	/**
	 * ...
	 * @author 
	 */
	public class CowgirlAnimation_Peach extends ModArchive
	{
		//private var timelinesData:Vector.<Object> = new Vector.<Object>();
		public function CowgirlAnimation_Peach() 
		{
			//this.displayOrderList = '{"0":{"HairBackLayer":0,"ArmL":1,"HandR":2,"ArmR":3,"ForearmR":4,"ShoulderL":5,"ShoulderR":6,"Neck":7,"FrontButtR":8,"FrontButtL":9,"Chest":10,"Hips":11,"Navel":12,"MaleLegL":13,"MaleLegR":14,"PchLowerLegR":15,"UpperLegR":16,"PchLowerLegL":17,"UpperLegL":18,"MaleGroin":19,"MaleShaft":20.01,"MalePenisHead":20.02,"ShaftMask":20,"BoobL":21,"AreolaL":22,"NippleL":23,"Groin":24,"Vulva":25,"MaleBody":26,"ClavicleR":27,"ClavicleL":28,"HairBehindHeadwearLayer":29,"Symbol 47":30,"HairBehindFaceLayer":31,"EarR":32,"EarL":33,"Face":34,"ClosedLashR":35,"ClosedLashL":36,"ScleraR":37,"PchPupilR":38.01,"EyelidR":38.02,"EyeMaskR":38,"EyelashR":39,"ScleraL":40,"PchPupilL":41.01,"EyelidL":41.02,"EyeMaskL":41,"EyelashL":42,"FrontHeadLayer":43,"EyebrowR":44,"EyebrowL":45,"Nose":46,"OpenSmile":47,"ClosedSmile":48,"HandL":49,"ForearmL":50,"BoobR":51,"AreolaR":52,"NippleR":53}}'
			//this.displayOrderList = '{"0":{"PchHairBack":0,"ArmL":1,"HandR":2,"ArmR":3,"ForearmR":4,"ShoulderL":5,"ShoulderR":6,"Neck":7,"FrontButtR":8,"FrontButtL":9,"Chest":10,"Hips":11,"Navel":12,"MaleLegL":13,"MaleLegR":14,"PchLowerLegR":15,"UpperLegR":16,"PchLowerLegL":17,"UpperLegL":18,"MaleGroin":19,"MaleShaft":20.01,"MalePenisHead":20.02,"ShaftMask":20,"BoobL":21,"AreolaL":22,"NippleL":23,"Groin":24,"Vulva":25,"MaleBody":26,"ClavicleR":27,"ClavicleL":28,"PchCrown":29,"PchHair3R":30,"PchHair3L":31,"PchEarringL":32,"PchEarringR":33,"EarR":34,"EarL":35,"Face":36,"ClosedLashR":37,"ClosedLashL":38,"ScleraR":39,"PchPupilR":40.01,"EyelidR":40.02,"EyeMaskR":40,"EyelashR":41,"ScleraL":42,"PchPupilL":43.01,"EyelidL":43.02,"EyeMaskL":43,"EyelashL":44,"PchHair1R":45,"PchHair1L":46,"PchHair2R":47,"PchHair2L":48,"PchHairFront":49,"EyebrowR":50,"EyebrowL":51,"Nose":52,"OpenSmile":53,"ClosedSmile":54,"HandL":55,"ForearmL":56,"BoobR":57,"AreolaR":58,"NippleR":59}}';
			modsList.push(CreateShardModForHair());
			modsList.push(CreateShardModForCrown());
			modsList.push(CreateShardModForEarringL());
			modsList.push(CreateShardModForEarringR());
			modsList.push(CreateShardModForEyeL());
			modsList.push(CreateShardModForEyeR());
			modsList.push(CreateShardModForMouth());
			//modsList.push(CreateShardModForBodyChanges());
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
			dispInfo[dispInfo.length] = new DispObjInfo("Hair1R", 400, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair1L", 600, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair2R", 800, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair2L", 1000, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("HairFront", 1200, 0, "FrontHeadLayer", DispObjInfo.FLAG_CHILD);

dispInfo[dispInfo.length] = new DispObjInfo("Hair3R", 600, 0, "BehindEarLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Hair3L", 800, 0, "BehindEarLayer", DispObjInfo.FLAG_CHILD);
//dispInfo[dispInfo.length] = new DispObjInfo("Symbol 47", 1000, 0, "BehindEarLayer", DispObjInfo.FLAG_CHILD);

dispInfo[dispInfo.length] = new DispObjInfo("HairBack", 400, 0, "BackLayer", DispObjInfo.FLAG_CHILD);

			return dispInfo;
		}
		
		private function CreateShardModForHair():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForHair();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForHair();
			var animateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Addition", "Peach", "Hair"]), timelineData, dispInfo, "Peach Hair", false, "Adds Peach's hair (Cowgirl position)");
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
			dispInfo[dispInfo.length] = new DispObjInfo("Headwear", 400, 0, "BehindEarLayer", DispObjInfo.FLAG_CHILD);
			return dispInfo;
		}
		
		private function CreateShardModForCrown():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForCrown();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForCrown();
			var animateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Addition", "Peach", "Crown", "Accessories"]), timelineData, dispInfo, "Peach Crown", false, "Adds Peach's crown (Cowgirl position)");
			return animateShard;
		}
		//}
		
		//Earring (L)
		//{
		private function GetTimelineDataForEarringL():Vector.<Object>
		{
			var vector:Vector.<Object> = new Vector.<Object>();
			vector.push(new EarringLTimelineData().GetTimelineData());
			//vector.push(new EarringRTimelineData().GetTimelineData());
			return vector;
		}
		
		private function CreateDisplayInfoForEarringL():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			
			dispInfo[dispInfo.length] = new DispObjInfo("EarringL", 1200, 0, "BehindEarLayer", DispObjInfo.FLAG_CHILD);

			return dispInfo;
		}
		
		private function CreateShardModForEarringL():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForEarringL();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEarringL();
			var animateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Addition", "Peach", "Earrings", "Left", "Accessories"]), timelineData, dispInfo, "Peach Earring Left", false, "Adds Peach's earrings for the left ear (Cowgirl position)");
			return animateShard;
		}
		//}
		
		//Earring (R)
		//{
		private function GetTimelineDataForEarringR():Vector.<Object>
		{
			var vector:Vector.<Object> = new Vector.<Object>();
			//vector.push(new EarringLTimelineData().GetTimelineData());
			vector.push(new EarringRTimelineData().GetTimelineData());
			return vector;
		}
		
		private function CreateDisplayInfoForEarringR():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			dispInfo[dispInfo.length] = new DispObjInfo("EarringR", 1400, 0, "BehindEarLayer", DispObjInfo.FLAG_CHILD);

			return dispInfo;
		}
		
		private function CreateShardModForEarringR():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForEarringR();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForEarringR();
			var animateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Addition", "Peach", "Earrings", "Right", "Accessories"]), timelineData, dispInfo, "Peach Earring R", false, "Adds Peach's earrings for the right ear (Cowgirl position)");
			return animateShard;
		}
		//}
		
		//Body changes
		//{
		private function GetTimelineDataForBodyChanges():Vector.<Object>
		{
			var vector:Vector.<Object> = new Vector.<Object>();
			return vector;
		}
		
		private function CreateDisplayInfoForBodyChanges():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			return dispInfo;
		}
		
		/*private function GetTimelineDataFor():Vector.<Object>
		{
			var vector:Vector.<Object> = new Vector.<Object>();
			return vector;
		}
		
		private function CreateDisplayInfoFor():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			

			return dispInfo;
		}*/
		
		private function CreateShardModForBodyChanges():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForBodyChanges();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForBodyChanges();
			var bodyAnimateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Replacement", "Peach", "Body"]), timelineData, dispInfo, "Peach Body", false, "Body animations changes for Peach (Cowgirl position)");
			return bodyAnimateShard;
		}
		
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
			var bodyAnimateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Replacement", "Peach", "Eye"]), timelineData, dispInfo, "Peach Left Eye", false, "Body animations changes for Peach (Cowgirl position)");
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
			var bodyAnimateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Replacement", "Peach", "Eye"]), timelineData, dispInfo, "Peach Right Eye", false, "Body animations changes for Peach (Cowgirl position)");
			return bodyAnimateShard;
		}
		
		private function GetTimelineDataForMouth():Vector.<Object>
		{
			var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
			dataForTimelineCreation.push(new ClosedSmileTimelineData().GetTimelineData());
dataForTimelineCreation.push(new OpenSmileTimelineData().GetTimelineData());
			return dataForTimelineCreation;
		}
		
		private function CreateDisplayInfoForMouth():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			dispInfo[dispInfo.length] = new DispObjInfo("OpenSmile", 200, 0, "MouthLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("ClosedSmile", 400, 0, "MouthLayer", DispObjInfo.FLAG_CHILD);

			return dispInfo;
		}		
		
		private function CreateShardModForMouth():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForMouth();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForMouth();
			var bodyAnimateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Replacement", "Peach", "Mouth"]), timelineData, dispInfo, "Peach Mouth", false, "Body animations changes for Peach (Cowgirl position)");
			return bodyAnimateShard;
		}
		//}
	}

}