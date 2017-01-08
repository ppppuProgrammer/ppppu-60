package animations.background
{
	import animations.TimelineDefinition
	public class TransitionDiamondTimelineData extends TimelineDefinition
	{
		public function TransitionDiamondTimelineData()
		{
			timelineData = new Object();
			timelineData.TIME_PER_FRAME = 0.03333333333333333;
			timelineData.targetName = "TransitionDiamond";
			var tweenPropVector:Vector.<Object> = new Vector.<Object>();
			tweenPropVector[tweenPropVector.length]= {transformMatrix:{ x:-99.1, y:95.3, scaleX:1.8, scaleY:1.8}};
			tweenPropVector[tweenPropVector.length]= {duration:1,  visible:false};
			tweenPropVector[tweenPropVector.length]= {duration:116,  visible:true,transformMatrix:{ x:-64.3, y:112.2, scaleX:1.616, scaleY:1.616}};
			tweenPropVector[tweenPropVector.length]= {duration:1, transformMatrix:{ x:-74.1, y:107.35, scaleX:1.668, scaleY:1.668}};
			tweenPropVector[tweenPropVector.length]= {duration:1,  visible:false};
			tweenPropVector[tweenPropVector.length]= {duration:1,  visible:true,transformMatrix:{ x:-99.2, y:95.3, scaleX:1.8, scaleY:1.8}, colorTransform:{ redMultiplier:0.62, greenMultiplier:1, blueMultiplier:1, alphaMultiplier:1, redOffset:-59, greenOffset:22, blueOffset:102, alphaOffset:0}};
			tweenPropVector[tweenPropVector.length]= {duration:1,  visible:false};
			tweenPropVector[tweenPropVector.length]= {duration:116,  visible:true,transformMatrix:{ x:-64.3, y:112.2, scaleX:1.616, scaleY:1.616}, colorTransform:{ redMultiplier:0.62, greenMultiplier:1, blueMultiplier:1, alphaMultiplier:1, redOffset:-59, greenOffset:22, blueOffset:102, alphaOffset:0}};
			tweenPropVector[tweenPropVector.length]= {duration:1, transformMatrix:{ x:-74.1, y:107.35, scaleX:1.668, scaleY:1.668}, colorTransform:{ redMultiplier:0.62, greenMultiplier:1, blueMultiplier:1, alphaMultiplier:1, redOffset:-59, greenOffset:22, blueOffset:102, alphaOffset:0}};
			tweenPropVector[tweenPropVector.length]= {duration:1,  visible:false};
			tweenPropVector[tweenPropVector.length]= {duration:1,  visible:true,transformMatrix:{ x:-99.1, y:95.3, scaleX:1.8, scaleY:1.8}};
			timelineData.tweenProperties = tweenPropVector;
		}
	}
}