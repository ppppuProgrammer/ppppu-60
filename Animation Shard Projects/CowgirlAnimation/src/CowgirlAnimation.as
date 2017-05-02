package
{
	import animations.AnimateShard;
	import animations.DispObjInfo;
	import modifications.AnimateShardMod;
	import modifications.AnimationMod;
	import flash.display.Sprite;
	import flash.events.Event;
	import modifications.ModArchive;
	import modifications.TemplateAnimationMod;
	//import Animations.Cowgirl.*;
	/**
	 * ...
	 * @author 
	 */
	public class CowgirlAnimation extends ModArchive
	{
		//private var timelinesData:Vector.<Object> = new Vector.<Object>();
		public function CowgirlAnimation() 
		{
			modsList.push(CreateShardModForFemale());
			modsList.push(CreateShardModForMale());
		}
		
		private function GetTimelineDataForMale():Vector.<Object>
		{
			var vector:Vector.<Object> = new Vector.<Object>();
			vector.push(new MaleBodyTimelineData().GetTimelineData());
			vector.push(new MaleGroinTimelineData().GetTimelineData());
			vector.push(new MaleLegLTimelineData().GetTimelineData());
			vector.push(new MaleLegRTimelineData().GetTimelineData());
			vector.push(new MalePenisHeadTimelineData().GetTimelineData());
			vector.push(new MaleShaftTimelineData().GetTimelineData());
			vector.push(new ShaftMaskTimelineData().GetTimelineData());
			vector.push(new PenisHighlightTimelineData().GetTimelineData());
			return vector;
		}
		
		private function CreateDisplayInfoForMale():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			
			dispInfo[dispInfo.length] = new DispObjInfo("MaleLegL", 3000, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleLegR", 3200, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleGroin", 4200, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("ShaftMask", 4400, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("MaleBody", 5800, 0);
dispInfo[dispInfo.length] = new DispObjInfo("MaleShaft", 400, 0, "ShaftMask", DispObjInfo.FLAG_MASKED);
dispInfo[dispInfo.length] = new DispObjInfo("MalePenisHead", 600, 0, "ShaftMask", DispObjInfo.FLAG_MASKED);
dispInfo[dispInfo.length] = new DispObjInfo("PenisHighlight", 800, 0, "ShaftMask", DispObjInfo.FLAG_MASKED);
			return dispInfo;
		}
		
		private function CreateShardModForMale():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForMale();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForMale();
			var maleAnimateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Male", "Base"]), timelineData, dispInfo, "Male_Giver", true, "Male (Giver) animations for the Cowgirl position");
			return maleAnimateShard;
		}
		
		private function GetTimelineDataForFemale():Vector.<Object>
		{
			var vector:Vector.<Object> = new Vector.<Object>();
			vector.push(new AreolaLTimelineData().GetTimelineData());
			vector.push(new AreolaRTimelineData().GetTimelineData());
			vector.push(new ArmLTimelineData().GetTimelineData());
			vector.push(new ArmRTimelineData().GetTimelineData());
			vector.push(new BoobLTimelineData().GetTimelineData());
			vector.push(new BoobRTimelineData().GetTimelineData());
			vector.push(new BoobHighlightLTimelineData().GetTimelineData());
			vector.push(new BoobHighlightRTimelineData().GetTimelineData());
			vector.push(new ChestTimelineData().GetTimelineData());
			vector.push(new ClavicleLTimelineData().GetTimelineData());
			vector.push(new ClavicleRTimelineData().GetTimelineData());	
			vector.push(new EarLTimelineData().GetTimelineData());
			vector.push(new EarRTimelineData().GetTimelineData());
			vector.push(new EyebrowLTimelineData().GetTimelineData());
			vector.push(new EyebrowRTimelineData().GetTimelineData());			
			vector.push(new FaceTimelineData().GetTimelineData());
			vector.push(new ForearmLTimelineData().GetTimelineData());
			vector.push(new ForearmRTimelineData().GetTimelineData());
			vector.push(new FrontButtLTimelineData().GetTimelineData());
			vector.push(new FrontButtRTimelineData().GetTimelineData());
			vector.push(new GroinTimelineData().GetTimelineData());
			vector.push(new HandLTimelineData().GetTimelineData());
			vector.push(new HandRTimelineData().GetTimelineData());
			vector.push(new HipsTimelineData().GetTimelineData());
			vector.push(new LowerLegLTimelineData().GetTimelineData());
			vector.push(new LowerLegRTimelineData().GetTimelineData());
			vector.push(new NavelTimelineData().GetTimelineData());
			vector.push(new NeckTimelineData().GetTimelineData());
			vector.push(new NippleLTimelineData().GetTimelineData());
			vector.push(new NippleRTimelineData().GetTimelineData());
			vector.push(new NoseTimelineData().GetTimelineData());

			
			vector.push(new ShoulderLTimelineData().GetTimelineData());
			vector.push(new ShoulderRTimelineData().GetTimelineData());
			vector.push(new UpperLegLTimelineData().GetTimelineData());
			vector.push(new UpperLegRTimelineData().GetTimelineData());
			vector.push(new VulvaTimelineData().GetTimelineData());
			return vector;
		}
		
		
		
		private function CreateDisplayInfoForFemale():Vector.<DispObjInfo>
		{
			var dispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();			
			dispInfo[dispInfo.length] = new DispObjInfo("BackLayer", 200, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("BehindHeadLayer", 400, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("ArmL", 600, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("HandR", 800, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("ArmR", 1000, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("ForearmR", 1200, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("ShoulderL", 1400, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("ShoulderR", 1600, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("Chest", 1800, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("FrontButtR", 2000, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("FrontButtL", 2200, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("Neck", 2400, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("Hips", 2600, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("Navel", 2800, 0);
			
			dispInfo[dispInfo.length] = new DispObjInfo("LowerLegR", 3400, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("UpperLegR", 3600, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("LowerLegL", 3800, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("UpperLegL", 4000, 0);
			
			dispInfo[dispInfo.length] = new DispObjInfo("BoobL", 4600, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("BoobHighlightL", 4800, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("AreolaL", 5000, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("NippleL", 5200, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("Groin", 5400, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("Vulva", 5600, 0);
			
			dispInfo[dispInfo.length] = new DispObjInfo("ClavicleR", 6000, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("ClavicleL", 6200, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("BehindEarLayer", 6400, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("EarL", 6600, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("EarR", 6800, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("FrontEarLayer", 7000, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("Face", 7200, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("RightEyeLayer", 7400, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("LeftEyeLayer", 7600, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("FrontHeadLayer", 7800, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("EyebrowR", 8000, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("EyebrowL", 8200, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("Nose", 8400, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("MouthLayer", 8600, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("HandL", 8800, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("ForearmL", 9000, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("BoobR", 9200, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("BoobHighlightR", 9400, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("AreolaR", 9600, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("NippleR", 9800, 0);
			dispInfo[dispInfo.length] = new DispObjInfo("FrontLayer", 10000, 0);
			
			
			return dispInfo;
		}
		
		private function CreateShardModForFemale():AnimateShardMod
		{
			var timelineData:Vector.<Object> = GetTimelineDataForFemale();
			var dispInfo:Vector.<DispObjInfo> = CreateDisplayInfoForFemale();
			var femaleAnimateShard:AnimateShardMod = new AnimateShardMod("Cowgirl", Vector.<String>(["Female", "Base"]), timelineData, dispInfo, "Female_Taker", true, "Female (taker) animations for the Cowgirl position");
			return femaleAnimateShard;
		}
		
		override protected function FirstFrame(e:Event):void
		{

			super.FirstFrame(e);
		}
	}

}