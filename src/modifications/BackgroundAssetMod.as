package modifications 
{
	import flash.display.Sprite;
	/**
	 * Mod to add a new background image into the background. BackgroundAssets are used for anything graphics you see behind the character.
	 * @author 
	 */
	public class BackgroundAssetMod extends Mod implements IModdable 
	{
		public var asset:Sprite;
		public var assetName:String;
		public var targetSpriteName:String;
		public var properties:Object;
		public function BackgroundAssetMod(image:Sprite, name:String, targetName:String, assetProperties:Object=null) 
		{
			modType = Mod.MOD_BACKGROUNDASSET;
			asset = image;
			assetName = name;
			targetSpriteName = targetName;
			properties = assetProperties;
		}
		
		/* INTERFACE modifications.IModdable */
		
		public function OutputModDetails():String 
		{
			return "BackgroundAssetMod::OutputModDetails() NYI";
		}
		
	}

}