package 
{
	import flash.display.Sprite;
	/**
	 * Graphic sets are a collection of sprites intended to be added to an Actor.
	 * @author 
	 */
	public class GraphicSet 
	{
		public var collection:Vector.<GraphicSetData>;
		public function GraphicSet() 
		{
			collection = new Vector.<GraphicSetData>();
		}
		
		public function AddAssetToSet(graphic:Sprite, actorName:String, layerInActor:int, properties:Object):Boolean
		{
			//A set can not contain multiple assets that target the same actor for the same layer.
			for (var i:int = 0, l:int = collection.length; i < l; i++) 
			{
				if (collection[i].targetActor == actorName && collection[i].layer == layerInActor)
				{
					return false;
				}
			}
			if (actorName != null && graphic != null)
			{
				collection[collection.length] = new GraphicSetData(actorName, graphic, layerInActor, properties);
				return true;
			}
			return false;
		}
		
	}

}
/*import flash.display.Sprite;

class GraphicSetData
{
	public var targetActor:String;
	public var asset:Sprite;
	public var layer:int;
	public var properties:Object;
	public function GraphicSetData(actorName:String, graphic:Sprite, layerInActor:int, assetProps:Object)
	{
		targetActor = actorName; asset = graphic; layer = layerInActor; properties = assetProps;
	}
}*/