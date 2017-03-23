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
			//this.displayOrderList = '{"0":{"HairBackLayer":0,"ArmL":1,"HandR":2,"ArmR":3,"ForearmR":4,"ShoulderL":5,"ShoulderR":6,"Neck":7,"FrontButtR":8,"FrontButtL":9,"Chest":10,"Hips":11,"Navel":12,"MaleLegL":13,"MaleLegR":14,"PchLowerLegR":15,"UpperLegR":16,"PchLowerLegL":17,"UpperLegL":18,"MaleGroin":19,"MaleShaft":20.01,"MalePenisHead":20.02,"ShaftMask":20,"BoobL":21,"AreolaL":22,"NippleL":23,"Groin":24,"Vulva":25,"MaleBody":26,"ClavicleR":27,"ClavicleL":28,"HairBehindHeadwearLayer":29,"Symbol 47":30,"HairBehindFaceLayer":31,"EarR":32,"EarL":33,"Face":34,"ClosedLashR":35,"ClosedLashL":36,"ScleraR":37,"PchPupilR":38.01,"EyelidR":38.02,"EyeMaskR":38,"EyelashR":39,"ScleraL":40,"PchPupilL":41.01,"EyelidL":41.02,"EyeMaskL":41,"EyelashL":42,"HairFrontLayer":43,"EyebrowR":44,"EyebrowL":45,"Nose":46,"OpenSmile":47,"ClosedSmile":48,"HandL":49,"ForearmL":50,"BoobR":51,"AreolaR":52,"NippleR":53}}'
			//this.displayOrderList = '{"0":{"PchHairBack":0,"ArmL":1,"HandR":2,"ArmR":3,"ForearmR":4,"ShoulderL":5,"ShoulderR":6,"Neck":7,"FrontButtR":8,"FrontButtL":9,"Chest":10,"Hips":11,"Navel":12,"MaleLegL":13,"MaleLegR":14,"PchLowerLegR":15,"UpperLegR":16,"PchLowerLegL":17,"UpperLegL":18,"MaleGroin":19,"MaleShaft":20.01,"MalePenisHead":20.02,"ShaftMask":20,"BoobL":21,"AreolaL":22,"NippleL":23,"Groin":24,"Vulva":25,"MaleBody":26,"ClavicleR":27,"ClavicleL":28,"PchCrown":29,"PchHair3R":30,"PchHair3L":31,"PchEarringL":32,"PchEarringR":33,"EarR":34,"EarL":35,"Face":36,"ClosedLashR":37,"ClosedLashL":38,"ScleraR":39,"PchPupilR":40.01,"EyelidR":40.02,"EyeMaskR":40,"EyelashR":41,"ScleraL":42,"PchPupilL":43.01,"EyelidL":43.02,"EyeMaskL":43,"EyelashL":44,"PchHair1R":45,"PchHair1L":46,"PchHair2R":47,"PchHair2L":48,"PchHairFront":49,"EyebrowR":50,"EyebrowL":51,"Nose":52,"OpenSmile":53,"ClosedSmile":54,"HandL":55,"ForearmL":56,"BoobR":57,"AreolaR":58,"NippleR":59}}';
			modsList.push(CreateShardModForHair());
			modsList.push(CreateShardModForCrown());
			modsList.push(CreateShardModForEarringL());
			modsList.push(CreateShardModForEarringR());
			modsList.push(CreateShardModForBodyChanges());
		}
		
		//Hair
		//{
		private function GetTimelineDataForHair():Vector.<Object>
		{
			var vector:Vector.<Object> = new Vector.<Object>();
			vector.push(new PchHair1LTimelineData().GetTimelineData());
			vector.push(new PchHair1RTimelineData().GetTimelineData());
			vector.push(new PchHair2LTimelineData().GetTimelineData());
			vector.push(new PchHair2RTimelineData().GetTimelineData());
			vector.push(new PchHair3LTimelineData().GetTimelineData());
			vector.push(new PchHair3RTimelineData().GetTimelineData());
			vector.push(new PchHairBackTimelineData().GetTimelineData());
			vector.push(new PchHairFrontTimelineData().GetTimelineData());
			return vector;
		}
		
		private function CreateDisplayInfoForHair():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
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
			var animateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Addition", "Peach", "Hair"]), timelineData, dispInfo, "Peach Hair", false, "Adds Peach's hair (Cowgirl position)");
			return animateShard;
		}
		//}
		
		//Crown
		//{
		private function GetTimelineDataForCrown():Vector.<Object>
		{
			var vector:Vector.<Object> = new Vector.<Object>();
			vector.push(new PchCrownTimelineData().GetTimelineData());
			return vector;
		}
		
		private function CreateDisplayInfoForCrown():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
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
			var animateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Addition", "Peach", "Crown", "Accessories"]), timelineData, dispInfo, "Peach Crown", false, "Adds Peach's crown (Cowgirl position)");
			return animateShard;
		}
		//}
		
		//Earring (L)
		//{
		private function GetTimelineDataForEarringL():Vector.<Object>
		{
			var vector:Vector.<Object> = new Vector.<Object>();
			vector.push(new PchEarringLTimelineData().GetTimelineData());
			//vector.push(new PchEarringRTimelineData().GetTimelineData());
			return vector;
		}
		
		private function CreateDisplayInfoForEarringL():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
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
			var animateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Addition", "Peach", "Earrings", "Left", "Accessories"]), timelineData, dispInfo, "Peach Earring Left", false, "Adds Peach's earrings for the left ear (Cowgirl position)");
			return animateShard;
		}
		//}
		
		//Earring (R)
		//{
		private function GetTimelineDataForEarringR():Vector.<Object>
		{
			var vector:Vector.<Object> = new Vector.<Object>();
			//vector.push(new PchEarringLTimelineData().GetTimelineData());
			vector.push(new PchEarringRTimelineData().GetTimelineData());
			return vector;
		}
		
		private function CreateDisplayInfoForEarringR():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
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
			var animateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Addition", "Peach", "Earrings", "Right", "Accessories"]), timelineData, dispInfo, "Peach Earring R", false, "Adds Peach's earrings for the right ear (Cowgirl position)");
			return animateShard;
		}
		//}
		
		//Body changes
		//{
		private function GetTimelineDataForBodyChanges():Vector.<Object>
		{
			var vector:Vector.<Object> = new Vector.<Object>();
			vector.push(new PchLowerLegLTimelineData().GetTimelineData());
			vector.push(new PchLowerLegRTimelineData().GetTimelineData());
			vector.push(new PchPupilLTimelineData().GetTimelineData());
			vector.push(new PchPupilRTimelineData().GetTimelineData());
			return vector;
		}
		
		private function CreateDisplayInfoForBodyChanges():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			/*dispInfo[dispInfo.length] = new DispObjInfo("MaleLegL", 1, 0.0, "Navel", 1);
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
			var bodyAnimateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Replacement", "Peach", "Body"]), timelineData, dispInfo, "Peach Body", false, "Body animations changes for Peach (Cowgirl position)");
			return bodyAnimateShard;
		}
		//}
		
		
		/*override protected function FirstFrame(e:Event):void
		{
			
			/*hairLayerAssignments.push(new HairPlacementInfo("PchHairFront", "HairFrontLayer", 0));
			hairLayerAssignments.push(new HairPlacementInfo("PchHair2L", "HairFrontLayer", 1));
			hairLayerAssignments.push(new HairPlacementInfo("PchHair2R", "HairFrontLayer", 2));
			hairLayerAssignments.push(new HairPlacementInfo("PchHair1L", "HairFrontLayer", 3));
			hairLayerAssignments.push(new HairPlacementInfo("PchHair1R", "HairFrontLayer", 4));
			
			hairLayerAssignments.push(new HairPlacementInfo("PchEarringR", "HairBehindFaceLayer", 0));
			hairLayerAssignments.push(new HairPlacementInfo("PchEarringL", "HairBehindFaceLayer", 1));
			
			hairLayerAssignments.push(new HairPlacementInfo("PchHair3L", "HairBehindHeadwearLayer", 0));
			hairLayerAssignments.push(new HairPlacementInfo("PchHair3R", "HairBehindHeadwearLayer", 1));
			hairLayerAssignments.push(new HairPlacementInfo("PchCrown", "HairBehindHeadwearLayer", 2));
			
			hairLayerAssignments.push(new HairPlacementInfo("PchHairBack", "HairBackLayer", 0));
			
			super.FirstFrame(e);
		}*/
	}

}