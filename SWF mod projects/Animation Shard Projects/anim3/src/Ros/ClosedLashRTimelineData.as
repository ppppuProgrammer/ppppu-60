package Ros
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
			tweenPropVector[tweenPropVector.length]= {duration:63,transformMatrix:{a:-1.52679443359375,b:0.0004425048828125,c:-0.0000152587890625,d:-1.429962158203125,tx:321.4,ty:202}};
			tweenPropVector[tweenPropVector.length]= {duration:1,visible:true,transformMatrix:{a:-1.52447509765625,b:0.00762939453125,c:-0.0000152587890625,d:-1.46331787109375,tx:321.4,ty:203.1}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:-1.5289764404296875,b:0.0067901611328125,c:-0.0000152587890625,d:-1.358917236328125,tx:321.75,ty:208.55}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:-1.532867431640625,b:0.0067596435546875,c:-0.0000152587890625,d:-1.2969970703125,tx:321.95,ty:212.35}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:-1.5362548828125,b:0.006683349609375,c:-0.0000152587890625,d:-1.27801513671875,tx:322.15,ty:214.85}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:-1.5388031005859375,b:0.001678466796875,c:-0.0000152587890625,d:-1.2801513671875,tx:322.3,ty:216.1}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:-1.54034423828125,b:0.0016937255859375,c:-0.0000152587890625,d:-1.28143310546875,tx:322.35,ty:216.8}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:-1.54107666015625,b:0.0016937255859375,c:-0.0000152587890625,d:-1.2820281982421875,tx:322.4,ty:217.15}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:-1.5408782958984375,b:0.0066986083984375,c:-0.0000152587890625,d:-1.2818603515625,tx:322.3,ty:217}};
			tweenPropVector[tweenPropVector.length]= {duration:1,visible:false,transformMatrix:{a:-1.539703369140625,b:0.0016937255859375,c:-0.0000152587890625,d:-1.2808837890625,tx:322.2,ty:213.7}};
			tweenPropVector[tweenPropVector.length]= {duration:48};
			timelineData.tweenProperties = tweenPropVector;
		}
	}
}