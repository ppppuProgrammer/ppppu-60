package modifications 
{
	/**
	 * ...
	 * @author 
	 */
	public class GraphicSetMod extends Mod implements IModdable 
	{
		//public var targetAnimationName:String;
		public var setName:String;
		//A vector of arrays. Each array is expected to be 4 indexes long, with the indexes being for the sprite, the name of the actor, the layer to be place within the actor and an object for optional properties.
		public var setData:Vector.<Array>;
		public function GraphicSetMod(/*animationName:String,*/ name:String, data:Vector.<Array>) 
		{
			modType = Mod.MOD_GRAPHICSET;
			//targetAnimationName = animationName;
			setName = name;
			setData = data;
		}
		
		/* INTERFACE modifications.IModdable */
		
		public function OutputModDetails():String 
		{
			return "GraphicSetMod::OutputModDetails() Not Yet Implemented";
		}
		
	}

}