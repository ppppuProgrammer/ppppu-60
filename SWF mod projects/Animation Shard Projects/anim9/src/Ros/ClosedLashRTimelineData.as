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
			tweenPropVector[tweenPropVector.length]= {duration:62,transformMatrix:{a:-1.105224609375,b:-0.0240936279296875,c:0.0284271240234375,d:-1.060760498046875,tx:292.35,ty:237.9}};
			tweenPropVector[tweenPropVector.length]= {duration:1,visible:true,transformMatrix:{a:-1.105224609375,b:-0.0240936279296875,c:0.0284271240234375,d:-1.060760498046875,tx:292.35,ty:227.9}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:-1.09539794921875,b:-0.0370635986328125,c:0.0372467041015625,d:-0.973419189453125,tx:289.9,ty:221.8}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:-1.0812835693359375,b:-0.024261474609375,c:0.0245361328125,d:-0.914794921875,tx:291.2,ty:214.45}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:-1.06951904296875,b:-0.014495849609375,c:0.0159149169921875,d:-0.8896942138671875,tx:292.75,ty:208.1}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:-1.06158447265625,b:-0.0083465576171875,c:0.007904052734375,d:-0.883148193359375,tx:294.25,ty:204}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:-1.0579833984375,b:0.0011749267578125,c:-0.0000152587890625,d:-0.880157470703125,tx:296,ty:203}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:-1.05975341796875,b:0.0106964111328125,c:-0.0079345703125,d:-0.8816375732421875,tx:298.3,ty:207.7}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:-1.063385009765625,b:0.02374267578125,c:-0.0159149169921875,d:-0.88470458984375,tx:300.6,ty:214}};
			tweenPropVector[tweenPropVector.length]= {duration:1,visible:false,transformMatrix:{a:-1.063385009765625,b:0.02374267578125,c:-0.0159149169921875,d:-0.88470458984375,tx:302.6,ty:221}};
			tweenPropVector[tweenPropVector.length]= {duration:49};
			timelineData.tweenProperties = tweenPropVector;
		}
	}
}