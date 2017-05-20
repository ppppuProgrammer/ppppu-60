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
			tweenPropVector[tweenPropVector.length]= {duration:59,transformMatrix:{a:1.1339111328125,b:0.000213623046875,c:-0.0000152587890625,d:-1.0782318115234375,tx:180.5,ty:240.85}};
			tweenPropVector[tweenPropVector.length]= {duration:1,visible:true,transformMatrix:{a:1.1339111328125,b:0.000213623046875,c:-0.0000152587890625,d:-1.0782318115234375,tx:180.5,ty:246.85}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.121826171875,b:0.000030517578125,c:-0.0000152587890625,d:-0.98773193359375,tx:181.2,ty:240.05}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.11163330078125,b:0.00006103515625,c:-0.0000152587890625,d:-0.931793212890625,tx:181.85,ty:232.45}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.1033172607421875,b:0.00018310546875,c:-0.0000152587890625,d:-0.909271240234375,tx:182.35,ty:224.2}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.096832275390625,b:0.00006103515625,c:-0.0000152587890625,d:-0.9039306640625,tx:182.8,ty:215.8}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.0921630859375,b:0.00006103515625,c:-0.0000152587890625,d:-0.9001007080078125,tx:183.15,ty:210.4}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.0894012451171875,b:0.0000457763671875,c:-0.0000152587890625,d:-0.8978118896484375,tx:183.25,ty:206.9}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.0885009765625,b:0.0001678466796875,c:-0.0000152587890625,d:-0.8970489501953125,tx:183.3,ty:205.35}};
			tweenPropVector[tweenPropVector.length]= {duration:1,visible:false,transformMatrix:{a:1.0885009765625,b:0.0001678466796875,c:-0.0000152587890625,d:-0.8970489501953125,tx:183.3,ty:203}};
			tweenPropVector[tweenPropVector.length]= {duration:52};
			timelineData.tweenProperties = tweenPropVector;
		}
	}
}