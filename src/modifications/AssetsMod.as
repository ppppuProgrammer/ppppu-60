package modifications 
{
	import flash.display.Sprite;
	import mx.utils.StringUtil;
	/**
	 * Mod that allows new graphics to be added.
	 * @author 
	 */
	public class AssetsMod extends Mod implements IModdable 
	{
		public var asset:Sprite;
		//The actor that the asset is for.
		public var targetActorName:String;
		//The graphic set that the asset wishes to be a part of.
		public var setName:String;
		//Used for additional data for the asset such as if the asset has any parts that could have its color changed
		public var data:Object;
		public var layer:int;
		public function AssetsMod(graphic:Sprite, actorName:String, gfxSetName:String, actorLayer:int, properties:Object=null) 
		{
			super();
			modType = MOD_ASSETS;
			asset = graphic;
			setName = gfxSetName;
			targetActorName = actorName;
			data = properties;
			layer = actorLayer;
		}
		
		/* INTERFACE modifications.IModdable */
		
		public function OutputModDetails():String 
		{
			return StringUtil.substitute("Adds Sprite for Actor: {0}, Graphic Set: {1}, Data: {2}", targetActorName, setName, UtilityFunctions.ConvertObjectToString(data));
		}
		
	}

}