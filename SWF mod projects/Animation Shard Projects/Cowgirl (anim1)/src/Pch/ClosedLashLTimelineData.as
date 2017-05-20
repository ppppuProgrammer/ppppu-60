package Pch 
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
			tweenPropVector[tweenPropVector.length]= {duration:59,transformMatrix:{a:1.22412109375,b:0.0002288818359375,c:-0.0000457763671875,d:-1.1640472412109375,tx:175.85,ty:212.1}};
			tweenPropVector[tweenPropVector.length]= {duration:1,visible:true,transformMatrix:{a:1.22412109375,b:0.0002288818359375,c:-0.0000457763671875,d:-1.1640472412109375,tx:175.85,ty:217.75}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.21112060546875,b:0.0000457763671875,c:-0.0000152587890625,d:-1.066375732421875,tx:176.65,ty:211.4}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.20013427734375,b:0.00006103515625,c:-0.0000152587890625,d:-1.0059661865234375,tx:177.3,ty:203.95}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.1911468505859375,b:0.0001983642578125,c:-0.0000152587890625,d:-0.981658935546875,tx:177.85,ty:195.8}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.1841278076171875,b:0.00006103515625,c:-0.0000152587890625,d:-0.9758758544921875,tx:178.3,ty:187.25}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.1791229248046875,b:0.00006103515625,c:-0.0000152587890625,d:-0.97174072265625,tx:178.65,ty:181.8}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.1761322021484375,b:0.0000457763671875,c:-0.0000152587890625,d:-0.96929931640625,tx:178.8,ty:178.25}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.175140380859375,b:0.00018310546875,c:-0.0000152587890625,d:-0.96844482421875,tx:178.9,ty:176.6}};
			tweenPropVector[tweenPropVector.length]= {duration:1,visible:false,transformMatrix:{a:1.175140380859375,b:0.00018310546875,c:-0.0000152587890625,d:-0.96844482421875,tx:178.9,ty:175.7}};
			tweenPropVector[tweenPropVector.length]= {duration:52};
			timelineData.tweenProperties = tweenPropVector;
		}
	}
}