package animations.background
{
	import animations.TimelineDefinition
	public class TransitionDiamondTimelineData extends TimelineDefinition
	{
		public function TransitionDiamondTimelineData()
		{
			timelineData = new Object();
			timelineData.TIME_PER_FRAME = 0.03333333333333333;
			timelineData.targetName = "BGLayer2";
			var tweenPropVector:Vector.<Object> = new Vector.<Object>();
			tweenPropVector[tweenPropVector.length]= {visible:true,transformMatrix:{a:1.79998779296875,b:0,c:0,d:1.79998779296875,tx:-99.099,ty:95.3}};
			tweenPropVector[tweenPropVector.length]= {duration:1,visible:false,transformMatrix:{a:1.7199859619140625,b:0,c:0,d:1.7199859619140625,tx:-83.949,ty:105.75}};
			tweenPropVector[tweenPropVector.length]= {duration:1};
			tweenPropVector[tweenPropVector.length]= {duration:114,transformMatrix:{a:1.574005126953125,b:0,c:0,d:1.574005126953125,tx:-56.249,ty:116.2}};
			tweenPropVector[tweenPropVector.length]= {duration:1,visible:true,transformMatrix:{a:1.6200103759765625,b:0,c:0,d:1.6200103759765625,tx:-64.299,ty:112.2}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.668212890625,b:0,c:0,d:1.668212890625,tx:-74.099,ty:107.35}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.7199859619140625,b:0,c:0,d:1.7199859619140625,tx:-80.449,ty:105.35}};
			tweenPropVector[tweenPropVector.length]= {duration:1,transformMatrix:{a:1.79998779296875,b:0,c:0,d:1.79998779296875,tx:-99.099,ty:95.3}};
			timelineData.tweenProperties = tweenPropVector;
		}
	}
}