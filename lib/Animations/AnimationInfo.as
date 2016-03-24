package Animations 
{
	import flash.display.Sprite;
	import Mod.ppppuMod;
	/**
	 * Class that holds the various timelines used to animate various elements on the master template/compositor to create an animation.
	 * This class is to be used as a base class.
	 * @author 
	 */
	public class AnimationInfo extends ppppuMod
	{
		protected var timelinesData:Vector.<Object>;
		protected var displayOrderList:String;
		protected var characterName:String;
		protected var animationName:String;
		
		modType:int = ppppuMod.MOD_ANIMATION; 
		
		public function AnimationInfo() 
		{
			timelinesData = new Vector.<Object>();
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