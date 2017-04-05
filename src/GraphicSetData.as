package 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author 
	 */
	public class GraphicSetData
	{
		public var targetActor:String;
		public var asset:Sprite;
		public var layer:int;
		public var properties:Object;
		public function GraphicSetData(actorName:String, graphic:Sprite, layerInActor:int, assetProps:Object)
		{
			targetActor = actorName; asset = graphic; layer = layerInActor; properties = assetProps;
		}
	}

}