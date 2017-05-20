package Ros 
{
	import animations.TimelineDefinition
	public class ClosedLashLTimelineData extends TimelineDefinition
	{
		public function ClosedLashLTimelineData()
		{
			timelineData = new Object();
			timelineData.TIME_PER_FRAME = 0.03333333333333333;
			timelineData.targetName = "ClosedLashL";
			var tweenPropVector:Vector.<Object> = new Vector.<Object>();
			tweenPropVector[tweenPropVector.length]= {visible:false};
			tweenPropVector[tweenPropVector.length]= {duration:59,transformMatrix:{a:1.2126922607421875,b:0.006072998046875,c:0.0000152587890625,d:-1.1640472412109375,tx:177,ty:206}};
			tweenPropVector[tweenPropVector.length]= {duration:1,visible:true,transformMatrix:{a:1.2126922607421875,b:0.006072998046875,c:0.0000152587890625,d:-1.1640472412109375,tx:177,ty:216.3}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.199798583984375,b:0.0053253173828125,c:0.0000152587890625,d:-1.066375732421875,tx:177.6,ty:210.05}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.18890380859375,b:0.0052337646484375,c:0.0000152587890625,d:-1.0059661865234375,tx:178.1,ty:202.65}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.17999267578125,b:0.005126953125,c:0.0000152587890625,d:-0.981658935546875,tx:178.45,ty:194.65}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.173065185546875,b:0.00128173828125,c:0.0000152587890625,d:-0.9758758544921875,tx:178.75,ty:186}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.1680908203125,b:0.00128173828125,c:0.0000152587890625,d:-0.97174072265625,tx:178.9,ty:180.55}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.1651458740234375,b:0.00128173828125,c:0.0000152587890625,d:-0.96929931640625,tx:179.05,ty:177.05}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.16412353515625,b:0.00506591796875,c:0.0000152587890625,d:-0.96844482421875,tx:179.1,ty:175.4}};
			tweenPropVector[tweenPropVector.length]= {duration:1,visible:false,transformMatrix:{a:1.16412353515625,b:0.00506591796875,c:0.0000152587890625,d:-0.96844482421875,tx:179.1,ty:171}};
			tweenPropVector[tweenPropVector.length]= {duration:52};
			timelineData.tweenProperties = tweenPropVector;
		}
	}
}