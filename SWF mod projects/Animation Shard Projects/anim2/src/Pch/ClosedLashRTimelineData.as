package Pch
{
	import animations.TimelineDefinition
	public class ClosedLashRTimelineData extends TimelineDefinition
	{
		public function ClosedLashRTimelineData()
		{
			timelineData = new Object();
			timelineData.TIME_PER_FRAME = 0.03333333333333333;
			timelineData.targetName = "ClosedLashR";
			var tweenPropVector:Vector.<Object> = new Vector.<Object>();
			tweenPropVector[tweenPropVector.length]= {visible:false};
			tweenPropVector[tweenPropVector.length]= {duration:59,transformMatrix:{a:-1.123291015625,b:0.0056304931640625,c:-0.0000152587890625,d:-1.0782318115234375,tx:299.1,ty:239.5}};
			tweenPropVector[tweenPropVector.length]= {duration:1,visible:true,transformMatrix:{a:-1.123291015625,b:0.0056304931640625,c:-0.0000152587890625,d:-1.0782318115234375,tx:299.1,ty:245.5}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:-1.111328125,b:0.00494384765625,c:-0.0000152587890625,d:-0.98773193359375,tx:298.55,ty:238.75}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:-1.1012420654296875,b:0.004852294921875,c:-0.0000152587890625,d:-0.931793212890625,tx:298.1,ty:231.25}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:-1.092987060546875,b:0.0047607421875,c:-0.0000152587890625,d:-0.909271240234375,tx:297.75,ty:223.1}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:-1.086578369140625,b:0.0012054443359375,c:-0.0000152587890625,d:-0.9039306640625,tx:297.5,ty:214.7}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:-1.08197021484375,b:0.001190185546875,c:-0.0000152587890625,d:-0.9001007080078125,tx:297.35,ty:209.3}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:-1.0792236328125,b:0.0012054443359375,c:-0.0000152587890625,d:-0.8978118896484375,tx:297.2,ty:205.8}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:-1.07830810546875,b:0.0046844482421875,c:-0.0000152587890625,d:-0.8970489501953125,tx:297.15,ty:204.25}};
			tweenPropVector[tweenPropVector.length]= {duration:1,visible:false,transformMatrix:{a:-1.07830810546875,b:0.0046844482421875,c:-0.0000152587890625,d:-0.8970489501953125,tx:297.15,ty:201.9}};
			tweenPropVector[tweenPropVector.length]= {duration:52};
			timelineData.tweenProperties = tweenPropVector;
		}
	}
}