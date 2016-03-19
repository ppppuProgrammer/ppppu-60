package Animations 
{
	import flash.display.Sprite;
	/**
	 * Class that details various aspects of an animation
	 * @author 
	 */
	public class AnimationInfo extends Sprite
	{
		protected var timelinesData:Vector.<Object>;
		protected var displayOrderList:String;
		protected var characterName:String;
		protected var animationName:String;
		public function AnimationInfo() 
		{
			
		}
		
		public function GetDataForTimelinesCreation():Vector.<Object>
		{
			return timelinesData;
		}
		
		public function GetCharacterName():String
		{
			return characterName;
		}
		
		public function GetAnimationName():String
		{
			return animationName;
		}
		
		public function GetDisplayOrderList():String
		{
			return displayOrderList;
		}
		
	}

}