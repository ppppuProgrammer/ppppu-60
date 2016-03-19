package Animations 
{
	import com.greensock.TimelineMax;
	import flash.geom.Matrix;
	/**
	 * Base class to be used for creating  timelinemax friendly  from  a jsfl script to generate a subclass that details a timelinemax object. 
	 * @author ppppuProgrammer
	 */
	public class TimelineDefinition
	{
		protected var timelineData:Object=null;
		public function GetTimelineData():Object { return timelineData; }
		/*protected function GetColorMatrixFilter(brightness:Number=0, contrast:Number=0, saturation:Number=0, hue:Number=0):Matrix
		{
			var adjColor:
		}*/
	}
}