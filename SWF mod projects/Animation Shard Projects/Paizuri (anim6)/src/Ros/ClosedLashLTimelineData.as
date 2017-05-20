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
			tweenPropVector[tweenPropVector.length]= {duration:59,transformMatrix:{a:1.2958221435546875,b:-0.0518951416015625,c:-0.051910400390625,d:-1.29571533203125,tx:179.8,ty:403.2}};
			tweenPropVector[tweenPropVector.length]= {duration:1,visible:true,transformMatrix:{a:1.2949676513671875,b:-0.0729522705078125,c:-0.073028564453125,d:-1.29486083984375,tx:175.45,ty:409.8}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.2955780029296875,b:-0.0579071044921875,c:-0.05792236328125,d:-1.29547119140625,tx:177.05,ty:411}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.296051025390625,b:-0.0466156005859375,c:-0.046630859375,d:-1.295928955078125,tx:178.6,ty:408.3}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.29644775390625,b:-0.0395355224609375,c:-0.0395965576171875,d:-1.29632568359375,tx:179.95,ty:401.5}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.29681396484375,b:-0.018310546875,c:-0.018310546875,d:-1.29669189453125,tx:179.3,ty:385.4}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.2969818115234375,b:-0.006744384765625,c:-0.006744384765625,d:-1.2968597412109375,tx:179,ty:371.25}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.2969970703125,b:-0.0006561279296875,c:-0.0006561279296875,d:-1.296875,tx:178.85,ty:362.45}};
			tweenPropVector[tweenPropVector.length]= {duration:1,visible:false,transformMatrix:{a:1.297027587890625,b:0,c:-0.0000152587890625,d:-1.296905517578125,tx:178.9,ty:359.25}};
			tweenPropVector[tweenPropVector.length]= {duration:53};
			timelineData.tweenProperties = tweenPropVector;
		}
	}
}