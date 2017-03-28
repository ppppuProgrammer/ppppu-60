package modifications 
{
	import flash.display.Sprite;
	/**
	 * Mod that allows new graphics to be added.
	 * @author 
	 */
	public class AssetsMod extends Mod implements IModdable 
	{
		public var asset:Sprite;
		public var assetName:String;
		//Used for additional data for the asset such as if the asset has any parts that could have its color changed
		public var data:Object;
		public function AssetsMod(graphic:Sprite, name:String, properties:Object=null) 
		{
			super();
			modType = MOD_ASSETS;
			asset = graphic;
			assetName = name;
			data = properties;
		}
		
		/* INTERFACE modifications.IModdable */
		
		public function OutputModDetails():String 
		{
			return "Not yet implemented";
		}
		
	}

}