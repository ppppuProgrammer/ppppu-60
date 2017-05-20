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
			tweenPropVector[tweenPropVector.length]= {duration:62,transformMatrix:{a:1.11553955078125,b:0.0301361083984375,c:0.0284271240234375,d:-1.060760498046875,tx:174,ty:236.1}};
			tweenPropVector[tweenPropVector.length]= {duration:1,visible:true,transformMatrix:{a:1.11553955078125,b:0.0301361083984375,c:0.0284271240234375,d:-1.060760498046875,tx:175.7,ty:226.1}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.105560302734375,b:0.0423736572265625,c:0.0372467041015625,d:-0.973419189453125,tx:174.25,ty:218.7}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.09136962890625,b:0.0293426513671875,c:0.0245361328125,d:-0.914794921875,tx:177.05,ty:212.6}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.0795745849609375,b:0.019500732421875,c:0.0159149169921875,d:-0.8896942138671875,tx:179.85,ty:207.15}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.07159423828125,b:0.0096435546875,c:0.007904052734375,d:-0.883148193359375,tx:182.2,ty:204.1}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.0679779052734375,b:0.0000457763671875,c:-0.0000152587890625,d:-0.880157470703125,tx:184.3,ty:204.05}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.06976318359375,b:-0.0095672607421875,c:-0.0079345703125,d:-0.8816375732421875,tx:186.45,ty:209.85}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.073516845703125,b:-0.019134521484375,c:-0.0159149169921875,d:-0.88470458984375,tx:188.35,ty:217.15}};
			tweenPropVector[tweenPropVector.length]= {duration:1,visible:false,transformMatrix:{a:1.073516845703125,b:-0.019134521484375,c:-0.0159149169921875,d:-0.88470458984375,tx:188.35,ty:223.15}};
			tweenPropVector[tweenPropVector.length]= {duration:1};
			tweenPropVector[tweenPropVector.length]= {duration:48};
			timelineData.tweenProperties = tweenPropVector;
		}
	}
}