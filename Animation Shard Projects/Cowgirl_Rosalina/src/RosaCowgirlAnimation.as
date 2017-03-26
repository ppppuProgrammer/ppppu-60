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
			vector.push(new RosaHair1LTimelineData().GetTimelineData());
			vector.push(new RosaHair1RTimelineData().GetTimelineData());
			vector.push(new RosaHair2LTimelineData().GetTimelineData());
			vector.push(new RosaHair2RTimelineData().GetTimelineData());
			vector.push(new RosaHair3LTimelineData().GetTimelineData());
			vector.push(new RosaHair3RTimelineData().GetTimelineData());
			vector.push(new RosaHairBackTimelineData().GetTimelineData());
			vector.push(new RosHairFrontTimelineData().GetTimelineData());
			return vector;
		}
		
		private function CreateDisplayInfoForHair():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			dispInfo[dispInfo.length] = new DispObjInfo("RosHairFront", 500, 0.0, "HairFrontLayer", DispObjInfo.FLAG_CHILD);
			dispInfo[dispInfo.length] = new DispObjInfo("RosaHair2L", 400, 0.0, "HairFrontLayer", DispObjInfo.FLAG_CHILD);
			dispInfo[dispInfo.length] = new DispObjInfo("RosaHair2R", 300, 0.0, "HairFrontLayer", DispObjInfo.FLAG_CHILD);
			dispInfo[dispInfo.length] = new DispObjInfo("RosaHair1L", 200, 0.0, "HairFrontLayer", DispObjInfo.FLAG_CHILD);
			dispInfo[dispInfo.length] = new DispObjInfo("RosaHair1R", 100, 0.0, "HairFrontLayer", DispObjInfo.FLAG_CHILD);
			
			
			
			dispInfo[dispInfo.length] = new DispObjInfo("RosaHair3L", 300, 0.0, "HairBehindHeadwearLayer", DispObjInfo.FLAG_CHILD);
			dispInfo[dispInfo.length] = new DispObjInfo("RosaHair3R", 200, 0.0, "HairBehindHeadwearLayer", DispObjInfo.FLAG_CHILD);
			
			
			dispInfo[dispInfo.length] = new DispObjInfo("RosaHairBack", 100, 0.0, "HairBackLayer", DispObjInfo.FLAG_CHILD);
			/*dispInfo[dispInfo.length] = new DispObjInfo("MaleLegL", 1, 0.0, "Navel", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleLegR", 1, 0.0, "MaleLegL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleGroin", 1, 0.0, "UpperLegL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleShaft", 0, 0.0, "ShaftMask", 2);
			dispInfo[dispInfo.length] = new DispObjInfo("MalePenisHead", 1, 0.0, "ShaftMask", 2);
			dispInfo[dispInfo.length] = new DispObjInfo("ShaftMask", 1, 0.0, "MaleGroin", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleBody", 1, 0.0, "Vulva", 1);*/
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
			vector.push(new RosaCrownTimelineData().GetTimelineData());
			return vector;
		}
		
		private function CreateDisplayInfoForCrown():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			dispInfo[dispInfo.length] = new DispObjInfo("RosaCrown", 100, 0.0, "HairBehindHeadwearLayer", DispObjInfo.FLAG_CHILD);
			/*dispInfo[dispInfo.length] = new DispObjInfo("MaleLegL", 1, 0.0, "Navel", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleLegR", 1, 0.0, "MaleLegL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleGroin", 1, 0.0, "UpperLegL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleShaft", 0, 0.0, "ShaftMask", 2);
			dispInfo[dispInfo.length] = new DispObjInfo("MalePenisHead", 1, 0.0, "ShaftMask", 2);
			dispInfo[dispInfo.length] = new DispObjInfo("ShaftMask", 1, 0.0, "MaleGroin", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleBody", 1, 0.0, "Vulva", 1);*/
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
			vector.push(new RosaEarringLTimelineData().GetTimelineData());
			//vector.push(new RosaEarringRTimelineData().GetTimelineData());
			return vector;
		}
		
		private function CreateDisplayInfoForEarringL():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			
			dispInfo[dispInfo.length] = new DispObjInfo("RosaEarringL", 100, 0.0, "HairBehindFaceLayer", DispObjInfo.FLAG_CHILD);
			/*dispInfo[dispInfo.length] = new DispObjInfo("MaleLegL", 1, 0.0, "Navel", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleLegR", 1, 0.0, "MaleLegL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleGroin", 1, 0.0, "UpperLegL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleShaft", 0, 0.0, "ShaftMask", 2);
			dispInfo[dispInfo.length] = new DispObjInfo("MalePenisHead", 1, 0.0, "ShaftMask", 2);
			dispInfo[dispInfo.length] = new DispObjInfo("ShaftMask", 1, 0.0, "MaleGroin", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleBody", 1, 0.0, "Vulva", 1);*/
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
			//vector.push(new RosaEarringLTimelineData().GetTimelineData());
			vector.push(new RosaEarringRTimelineData().GetTimelineData());
			return vector;
		}
		
		private function CreateDisplayInfoForEarringR():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			dispInfo[dispInfo.length] = new DispObjInfo("RosaEarringR", 200, 0.0, "HairBehindFaceLayer", DispObjInfo.FLAG_CHILD);
			/*dispInfo[dispInfo.length] = new DispObjInfo("MaleLegL", 1, 0.0, "Navel", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleLegR", 1, 0.0, "MaleLegL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleGroin", 1, 0.0, "UpperLegL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleShaft", 0, 0.0, "ShaftMask", 2);
			dispInfo[dispInfo.length] = new DispObjInfo("MalePenisHead", 1, 0.0, "ShaftMask", 2);
			dispInfo[dispInfo.length] = new DispObjInfo("ShaftMask", 1, 0.0, "MaleGroin", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleBody", 1, 0.0, "Vulva", 1);*/
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
			vector.push(new ForearmRTimelineData().GetTimelineData());
			vector.push(new HandRTimelineData().GetTimelineData());
			vector.push(new RosaClosedSmileTimelineData().GetTimelineData());
			
			//vector.push(new RosaLowerLegLTimelineData().GetTimelineData());
			//vector.push(new RosaLowerLegRTimelineData().GetTimelineData());
			//vector.push(new RosaPupilRTimelineData().GetTimelineData());
			return vector;
		}
		
		private function CreateDisplayInfoForBodyChanges():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			//dispInfo[dispInfo.length] = new DispObjInfo("EyelidR", 1, 0.0, "", 1);
			//dispInfo[dispInfo.length] = new DispObjInfo("EyeMaskR", 1, 0.0, "", 1);
			//dispInfo[dispInfo.length] = new DispObjInfo("ForearmR", 5000, 0.0);
			//dispInfo[dispInfo.length] = new DispObjInfo("ClosedLashR", 1, 0.0);
			//dispInfo[dispInfo.length] = new DispObjInfo("RosaClosedSmile", 1, 0.0);
			
			//dispInfo[dispInfo.length] = new DispObjInfo("RosaLowerLegL", 1800, 0.0);
			//dispInfo[dispInfo.length] = new DispObjInfo("RosaLowerLegR", 1600, 0.0);
			//dispInfo[dispInfo.length] = new DispObjInfo("HandR", 300, 0.0);
			//dispInfo[dispInfo.length] = new DispObjInfo("RosaPupilR", 1, 0.0, "", 1);
			/*
			dispInfo[dispInfo.length] = new DispObjInfo("MaleLegR", 1, 0.0, "MaleLegL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleGroin", 1, 0.0, "UpperLegL", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleShaft", 0, 0.0, "ShaftMask", 2);
			dispInfo[dispInfo.length] = new DispObjInfo("MalePenisHead", 1, 0.0, "ShaftMask", 2);
			dispInfo[dispInfo.length] = new DispObjInfo("ShaftMask", 1, 0.0, "MaleGroin", 1);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleBody", 1, 0.0, "Vulva", 1);*/
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
		
		
		
		
		/*override protected function FirstFrame(e:Event):void
		{
			
			
			
			
			
			super.FirstFrame(e);

		}*/
	}

}