package modifications
{
	import modifications.Mod;
	/**
	 * Class that holds the various timelines used to animate various elements on the master template/compositor to create an animation.
	 * This class is to be used as a base class.
	 * @author 
	 */
	public class TemplateAnimationMod extends Mod implements IModdable
	{
		//contains the data that used to define all the timelines (a series of tweens affecting 1 particular Sprite/Movieclip) for the animation
		protected var timelinesData:Vector.<Object>;
		protected var displayOrderList:String="";
		//Controls whether the animation is to be interpretted as Basis (true) or Additive (false). Basis defines animations with the commonly used graphics such as the character's bodies. Additive defines animations that are to add onto a basis animation, controlling character specific graphics such as hair and accessories.
		protected var isBasisTemplate:Boolean;
		//The name of the animation this template defines (if Basis) or will add to (if Additive)
		protected var animationName:String = null;
		
		protected var bodyTypeName:String = null;
		//If the template is Basis this is used to define the body type of the animation (for instance, some characters may be "Standard" body type and another may be "Shortstack"). If Additive, this defines what character these animations are for.
		protected var characterName:String = null;
		protected var dynamicHairMovement:Boolean = false;
		protected var hairLayerAssignments:Vector.<HairPlacementInfo> = new Vector.<HairPlacementInfo>();
		
		
		public function TemplateAnimationMod() 
		{
			modType = Mod.MOD_TEMPLATEANIMATION; 
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
		
		public function GetBodyTypeName():String
		{
			return bodyTypeName;
		}
		
		public function GetAnimationName():String
		{
			return animationName;
		}
		
		public function GetIfBasisTemplate():Boolean
		{
			return isBasisTemplate;
		}
		
		public function GetDisplayOrderList():String
		{
			return displayOrderList;
		}
		
		public override function Dispose():void
		{
			
		}
		
		public function OutputModDetails():String
		{
			return "";
		}
	}

}