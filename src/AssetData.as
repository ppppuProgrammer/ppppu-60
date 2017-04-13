package 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author 
	 */
	public class AssetData
	{
		//The name of the graphic set that this asset originates from.
		public var setName:String;
		//The graphic that will be added to the Actor
		public var asset:Sprite;
		//The layer in the Actor that the asset will be added to.
		public var layer:int;
		//Various properties that are for the asset, such as colorable and disableActor data.
		public var properties:Object;
		public function AssetData(gfxSetName:String, graphic:Sprite, layerInActor:int, assetProps:Object)
		{
			setName = gfxSetName; asset = graphic; layer = layerInActor; properties = assetProps;
		}
	}

}