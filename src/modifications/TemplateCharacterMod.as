package modifications
{
	import mx.utils.StringUtil;
	/**
	 * Character mod intended for NX/customizable versions of ppppu. No movie clip that holds all the animations is expected as this 
	 * type of character mod modifies a template animation (which are loaded in by an Animation mod) to give the desired appearance.
	 * @author 
	 */
	public class TemplateCharacterMod extends Mod implements IModdable
	{
		protected var characterName:String;
		protected var characterData:Object = { Color: { }};
		protected var animationPresets:Vector.<Array> = new Vector.<Array>;
		public function TemplateCharacterMod() 
		{
			modType = Mod.MOD_TEMPLATECHARACTER;
		}
		public override function Dispose():void
		{
			
		}
		
		public function GetCharacterName():String
		{
			return characterName;
		}
		
		public function GetCharacterData():Object
		{
			return characterData;
		}
		
		public function GetPresetAnimations():Vector.<Array>
		{
			return animationPresets;
		}
		
		public function OutputModDetails():String
		{
			return StringUtil.substitute("Character: {0}\tData:{1}", name, UtilityFunctions.ConvertObjectToString(characterData));
		}
	}

}