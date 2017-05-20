package
{
	import Pch.Blowjob_PeachAnimation;
	import Ros.Blowjob_RosalinaAnimation;
	import animations.AnimateShard;
	import animations.DispObjInfo;
	import modifications.AnimateShardMod;
	import modifications.AnimationMod;
	import flash.display.Sprite;
	import flash.events.Event;
	import modifications.ModArchive;
	import modifications.TemplateAnimationMod;
	
	/**
	 * ...
	 * @author 
	 */
	public class BlowjobAnimation extends ModArchive
	{
		
		
		public function BlowjobAnimation() 
		{
			modsList.push(CreateShardModForFemale());
			modsList.push(CreateShardModForMale());
			modsList = modsList.concat(Blowjob_PeachAnimation.GetShardMods(), Blowjob_RosalinaAnimation.GetShardMods());
		}
		
		private function GetTimelineDataForMale():Vector.<Object>
		{
			var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
dataForTimelineCreation.push(new MaleBodyTimelineData().GetTimelineData());
dataForTimelineCreation.push(new MaleGroinTimelineData().GetTimelineData());
dataForTimelineCreation.push(new MaleLegRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new MaleLegLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ShaftMask2TimelineData().GetTimelineData());
dataForTimelineCreation.push(new PenisHighlightTimelineData().GetTimelineData());
dataForTimelineCreation.push(new MalePenisHeadTimelineData().GetTimelineData());
dataForTimelineCreation.push(new MaleShaft2TimelineData().GetTimelineData());
			return dataForTimelineCreation;
		}
		
		private function CreateDisplayInfoForMale():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			dispInfo[dispInfo.length] = new DispObjInfo("MaleLegL", 3000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MaleLegR", 3200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MaleGroin", 6800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ShaftMask2", 7000, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleShaft2", 200, 0, "ShaftMask2", DispObjInfo.FLAG_MASKED);
dispInfo[dispInfo.length] = new DispObjInfo("MalePenisHead", 400, 0, "ShaftMask2", DispObjInfo.FLAG_MASKED);
dispInfo[dispInfo.length] = new DispObjInfo("PenisHighlight", 600, 0, "ShaftMask2", DispObjInfo.FLAG_MASKED);
dispInfo[dispInfo.length] = new DispObjInfo("MaleBody", 7200, 0);


			
dispInfo[dispInfo.length] = new DispObjInfo("MaleLegL", 3000, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("MaleLegR", 3200, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("ShaftMask2", 6800, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("MaleShaft2", 200, 2.0, "ShaftMask2", DispObjInfo.FLAG_MASKED);
dispInfo[dispInfo.length] = new DispObjInfo("MalePenisHead", 400, 2.0, "ShaftMask2", DispObjInfo.FLAG_MASKED);
//dispInfo[dispInfo.length] = new DispObjInfo("PenisHighlight", 600, 2.0, "ShaftMask2", DispObjInfo.FLAG_MASKED);
dispInfo[dispInfo.length] = new DispObjInfo("MaleGroin", 7000, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("MaleBody", 7200, 2.0);
			return dispInfo;
		}
		
		private function CreateShardModForMale():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForMale();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForMale();
			var maleAnimateShard:AnimateShardMod = new AnimateShardMod("Blowjob", Vector.<String>(["Male", "Base", "Standard"]), timelineData, dispInfo, "Male (Standard)", true, "Male (Giver) animations for the Blowjob position");
			return maleAnimateShard;
		}
		
		private function GetTimelineDataForFemale():Vector.<Object>
		{
			var dataForTimelineCreation:Vector.<Object> = new Vector.<Object>();
dataForTimelineCreation.push(new ForearmLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new HandLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ForearmRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new HandRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new EyebrowLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new EyebrowRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new NoseTimelineData().GetTimelineData());
dataForTimelineCreation.push(new EarRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new FaceAngled3TimelineData().GetTimelineData());
dataForTimelineCreation.push(new EarLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ClavicleLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ClavicleRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new NeckTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ShoulderRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ShoulderLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new NippleRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new AreolaRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new BoobHighlightRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new BoobRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new NippleLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new AreolaLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new BoobHighlightLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new BoobLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ChestTimelineData().GetTimelineData());
dataForTimelineCreation.push(new Hips2TimelineData().GetTimelineData());
dataForTimelineCreation.push(new ArmLTimelineData().GetTimelineData());
dataForTimelineCreation.push(new ArmRTimelineData().GetTimelineData());
dataForTimelineCreation.push(new WideMouthTimelineData().GetTimelineData());
			return dataForTimelineCreation;
		}
		
		
		
		private function CreateDisplayInfoForFemale():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			dispInfo[dispInfo.length] = new DispObjInfo("BackLayer", 200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BehindHeadLayer", 400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ArmR", 600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ArmL", 800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Hips2", 1000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Chest", 1200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BoobL", 1400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BoobHighlightL", 1600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("AreolaL", 1800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("NippleL", 2000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BoobR", 2200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BoobHighlightR", 2400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("AreolaR", 2600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("NippleR", 2800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ShoulderL", 3400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ShoulderR", 3600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("Neck", 3800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ClavicleR", 4000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ClavicleL", 4200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("BehindEarLayer", 4400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("EarL", 4600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("FrontEarLayer", 4800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("FaceAngled3", 5000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("EarR", 5200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("LeftEyeLayer", 5400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("RightEyeLayer", 5600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MouthLayer", 5800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("WideMouth", 200, 0, "MouthLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Nose", 6000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("EyebrowR", 6200, 0);
dispInfo[dispInfo.length] = new DispObjInfo("EyebrowL", 6400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("FrontHeadLayer", 6600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("HandR", 7400, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ForearmR", 7600, 0);
dispInfo[dispInfo.length] = new DispObjInfo("HandL", 7800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("ForearmL", 8000, 0);
dispInfo[dispInfo.length] = new DispObjInfo("FrontLayer", 8200, 0);
			
			dispInfo[dispInfo.length] = new DispObjInfo("BackLayer", 200, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("BehindHeadLayer", 400, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("ArmR", 600, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("ArmL", 800, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("Hips2", 1000, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("Chest", 1200, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("BoobL", 1400, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("BoobHighlightL", 1600, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("AreolaL", 1800, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("NippleL", 2000, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("BoobR", 2200, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("BoobHighlightR", 2400, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("AreolaR", 2600, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("NippleR", 2800, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("ShoulderL", 3400, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("ShoulderR", 3600, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("Neck", 3800, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("ClavicleR", 4000, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("ClavicleL", 4200, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("BehindEarLayer", 4400, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("EarL", 4600, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("FrontEarLayer", 4800, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("FaceAngled3", 5000, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("EarR", 5200, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("LeftEyeLayer", 5400, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("RightEyeLayer", 5600, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("MouthLayer", 5800, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("WideMouth", 200, 2.0, "MouthLayer", DispObjInfo.FLAG_CHILD);
dispInfo[dispInfo.length] = new DispObjInfo("Nose", 6000, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("EyebrowR", 6200, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("EyebrowL", 6400, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("FrontHeadLayer", 6600, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("HandR", 7400, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("ForearmR", 7600, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("HandL", 7800, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("ForearmL", 8000, 2.0);
dispInfo[dispInfo.length] = new DispObjInfo("FrontLayer", 8200, 2.0);
			return dispInfo;
		}
		
		private function CreateShardModForFemale():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForFemale();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForFemale();
			var femaleAnimateShard:AnimateShardMod = new AnimateShardMod("Blowjob", Vector.<String>(["Female", "Base", "Standard"]), timelineData, dispInfo, "Female (Standard)", true, "Female (taker) animations for the Blowjob position");
			return femaleAnimateShard;
		}
		
	}
	
}