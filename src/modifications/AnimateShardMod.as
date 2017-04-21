package modifications
{
	import animations.DispObjInfo;
	import mx.utils.StringUtil;
	
	/**
	 * Mod base class that will be used to define an AnimateShard, which is a group of tweens used to build an animation.
	 * @author 
	 */
	public class AnimateShardMod extends Mod implements IModdable 
	{
		//Name of the animation the AnimateShard is for.
		protected var targetAnimationName:String;
		//A list of strings that define one or more categories that the animate shard falls into.
		protected var categories:Vector.<String> = new Vector.<String>();
		// Holds the various objects that hold data used to manipulate Display Objects
		protected var timelinesData:Vector.<Object> = new Vector.<Object>();
		protected var displayObjectOrders:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
		//The name of the shard.
		protected var shardName:String;
		//Used to determine if this shard has timelines for base graphics of an animation. Timelines in a base shard have lower priority when a collision between timelines controlling the same graphic element occurs.
		protected var isBaseShard:Boolean = false;
		//A optional description of what the AnimateShard is for and what it will affect or add.
		protected var shardDescription:String;
		//Data that supersedes settings from other types, such as Colorize data of a character.
		//protected var overrideData:Object;
		public function AnimateShardMod(animationName:String, shardCategories:Vector.<String>, timelineInstructions:Vector.<Object>, dispObjData:Vector.<DispObjInfo>, animShardName:String, baseShard:Boolean, description:String/*, additionalData:Object=null*/) 
		{
			modType = MOD_ANIMATESHARD;
			targetAnimationName = animationName;
			categories = shardCategories;
			timelinesData = timelineInstructions;
			displayObjectOrders = dispObjData;
			shardName = animShardName;
			isBaseShard = baseShard;
			shardDescription = description;
			//overrideData = additionalData;
		}
		
		public function GetTargetAnimationName():String { return targetAnimationName; }
		public function GetCategories():Vector.<String> { return categories; }
		/*public function GetCategoriesString():String 
		{
			var categoriesStr:String;
			for (var i:int = 0, l:int = categories.length; i < l; i++) 
			{
				categoriesStr += categories[i];
				if(i+1 < l){categoriesStr += ", "}
			}
			return categoriesStr; 
		
		}*/
		public function GetTimelineConstructionData():Vector.<Object> { return timelinesData; }
		public function GetDisplayObjectOrders():Vector.<DispObjInfo> { return displayObjectOrders; }
		public function GetShardName():String { return shardName; }
		public function GetIfBaseShard():Boolean { return isBaseShard; }
		public function GetDescription():String { return shardDescription; }
		//public function GetOverrideData():Object { return overrideData; }
		/* INTERFACE modifications.IModdable */
		
		public function OutputModDetails():String 
		{
			var listOfSpritesWithModifiedDepths:String = "";
			if (displayObjectOrders != null)
			{
				var dispObjInfo:DispObjInfo;
				for (var i:int = 0, l:int = displayObjectOrders.length; i < l; i++) 
				{
					if (listOfSpritesWithModifiedDepths.length > 0)
					{
						listOfSpritesWithModifiedDepths += "\n";
					}
					dispObjInfo = displayObjectOrders[i];
					if (dispObjInfo.GetTargetFlag() == 0)
					{
						listOfSpritesWithModifiedDepths += "Modifies: " + dispObjInfo.GetControlObjectName();
					}
					else
					{
						listOfSpritesWithModifiedDepths += StringUtil.substitute("Modifies: {0}, Relies on: {1}",dispObjInfo.GetControlObjectName(), dispObjInfo.GetTargetObjName());
					}
								
				}
			}
			
			var spritesWithAnimationData:String = "";
			if (timelinesData != null)
			{
				for (var j:int = 0, k:int = timelinesData.length; j < k; j++) 
				{
					if (spritesWithAnimationData.length > 0)
					{
						spritesWithAnimationData += ", ";
					}
					spritesWithAnimationData += timelinesData[j].targetName;
				}
			}
			
			return StringUtil.substitute("For Animation: {0}, Shard Name: {1}, Type: {2}\nCategories: {3}\nAnimates: {4}\nChanges Depth of: {5}\nDescription: {6}", targetAnimationName, shardName, (isBaseShard) ? "Base" : "Addition", categories.join(), spritesWithAnimationData, listOfSpritesWithModifiedDepths, shardDescription);
		}
		
	}

}