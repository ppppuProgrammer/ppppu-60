package Pch 
{
	import animations.TimelineDefinition
	public class ClosedSmileTimelineData extends TimelineDefinition
	{
		public function ClosedSmileTimelineData()
		{
			timelineData = new Object();
			timelineData.TIME_PER_FRAME = 0.03333333333333333;
			timelineData.targetName = "ClosedSmile";
			var tweenPropVector:Vector.<Object> = new Vector.<Object>();
			tweenPropVector[tweenPropVector.length]= {visible:false};
			tweenPropVector[tweenPropVector.length]= {duration:77,transformMatrix:{a:1.426910400390625,b:-0.636383056640625,c:0.721527099609375,d:1.02777099609375,tx:191.1,ty:214.45}};
			tweenPropVector[tweenPropVector.length]= {duration:1,visible:true,transformMatrix:{a:1.426910400390625,b:-0.636383056640625,c:0.721527099609375,d:1.02777099609375,tx:193.05,ty:201.25}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.406341552734375,b:-0.65802001953125,c:0.730865478515625,d:1.0482635498046875,tx:194.5,ty:186.8}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.389801025390625,b:-0.6795501708984375,c:0.7465667724609375,d:1.0537109375,tx:195.65,ty:175.95}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.3813323974609375,b:-0.6919708251953125,c:0.7545166015625,d:1.053924560546875,tx:196.35,ty:168.55}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.3729248046875,b:-0.7015380859375,c:0.76214599609375,d:1.044921875,tx:196.85,ty:165.05}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.370941162109375,b:-0.7071685791015625,c:0.771636962890625,d:1.0397796630859375,tx:197,ty:165.25}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.3759613037109375,b:-0.702392578125,c:0.7780609130859375,d:1.0395965576171875,tx:196.65,ty:167.9}};
			tweenPropVector[tweenPropVector.length]= {duration:1,visible:false,transformMatrix:{a:1.3759613037109375,b:-0.702392578125,c:0.7780609130859375,d:1.0395965576171875,tx:196.9,ty:174.65}};
			tweenPropVector[tweenPropVector.length]= {duration:1};
			tweenPropVector[tweenPropVector.length]= {duration:34};
			timelineData.tweenProperties = tweenPropVector;
		}
	}
}