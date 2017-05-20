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
			tweenPropVector[tweenPropVector.length]= {duration:59,transformMatrix:{a:-1.2958221435546875,b:0.0519256591796875,c:-0.051910400390625,d:-1.29571533203125,tx:313.55,ty:397.75}};
			tweenPropVector[tweenPropVector.length]= {duration:1,visible:true,transformMatrix:{a:-1.2949676513671875,b:0.0731048583984375,c:-0.073028564453125,d:-1.29486083984375,tx:309.1,ty:402.1}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:-1.2955780029296875,b:0.0579376220703125,c:-0.05792236328125,d:-1.29547119140625,tx:310.75,ty:404.9}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:-1.296051025390625,b:0.0466461181640625,c:-0.046630859375,d:-1.295928955078125,tx:312.35,ty:403.35}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:-1.29644775390625,b:0.0396881103515625,c:-0.0395965576171875,d:-1.29632568359375,tx:313.75,ty:397.3}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:-1.29681396484375,b:0.018341064453125,c:-0.018310546875,d:-1.29669189453125,tx:313.15,ty:383.4}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:-1.2969818115234375,b:0.006744384765625,c:-0.006744384765625,d:-1.2968597412109375,tx:312.9,ty:370.4}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:-1.2969970703125,b:0.0006561279296875,c:-0.0006561279296875,d:-1.296875,tx:312.75,ty:362.2}};
			tweenPropVector[tweenPropVector.length]= {duration:1,visible:false,transformMatrix:{a:-1.297027587890625,b:0.000030517578125,c:-0.0000152587890625,d:-1.296905517578125,tx:312.8,ty:359.1}};
			tweenPropVector[tweenPropVector.length]= {duration:53};
			timelineData.tweenProperties = tweenPropVector;
		}
	}
}