package animations 
{;
	import org.libspark.betweenas3.core.tweens.groups.SerialTween;
	import flash.utils.Dictionary;
	/**
	 * Holds all the various timelines that can be used in the program. 
	 * @author ...
	 */
	public class TimelineLibrary 
	{
		//"Enum" of additional timeline types
		public const TYPE_EXPRESSION:int = 0; //Used to fine tune the mouth graphic displayed and it's placement.
		public const TYPE_EYE:int = 1; //Used to fine tune the eye graphics displayed and their placement.
		
		/*Contains the default timelines for an animation. Is a vector (animation ids are used for indices) 
		containing a vector<SerialTween>.
		Concise version: vector[animID] > vector[timelines]*/
		private var baseTimelinesCollection:Vector.<Vector.<SerialTween>> = new Vector.<Vector.<SerialTween>>();
		
		private var extraTimelinesCollection;
		
		/*Contains additional timelines that will replace base timelines in an animation. Primarily used for body part rearraignment.
		 * Is a vector (animation id) of vectors (character) of dictionaries (animation set which is a group of timelines meant for a 
		 * certain purpose) which will use a string as a key(set name) and a vector<SerialTween> as the value. 
		 * Concise version: vector[anim] > vector[char] > dict[set] > vector[timelines]*/
		private var replacementTimelinesCollection:Vector.<Vector.<Dictionary>> = new Vector.<Vector.<Dictionary>>();
		
		/*Contains supplementary timelines to add onto the base timelines in an animation.
		 *Is a vector (animation ids) of vectors (character ids) of vectors (timeline type) of vector<SerialTween>.
		 *Concise version: vector[anim] > vector[char] > vector[type] > vector[timelines]*/
		private var supplementTimelinesCollection:Vector.<Vector.<Vector.<Vector.<SerialTween>>>> = new Vector.<Vector.<Vector.<Vector.<SerialTween>>>>();
		
		//Flag variable that tells if there is atleast 1 usable base timeline loaded.
		private var HasValidBaseTimeline:Boolean = false;
		
		public function TimelineLibrary() 
		{
			
		}
		
		/*Adding timeline(s) to library functions*/
		
		
		public function AddBaseTimelinesToLibrary(animationID:int, timelines:Vector.<SerialTween> ):void
		{
			while (animationID > baseTimelinesCollection.length)
			{
				baseTimelinesCollection[baseTimelinesCollection.length] = null;
			}
			//baseTimelinesCollection.insertAt(animationID, timelines);
			baseTimelinesCollection[animationID] = timelines;
			if (baseTimelinesCollection.length > 0) { HasValidBaseTimeline = true;}
		}
		
		public function AddReplacementTimelinesToLibrary(animationID:int, characterID:int, setName:String, timelines:Vector.<SerialTween> ):void
		{
			if (characterID == -1 || animationID == -1) { return;}
			DoesCharacterSetExists(animationID, characterID, setName);
			var timelineSetDictionary:Dictionary = replacementTimelinesCollection[animationID][characterID];
			if (timelineSetDictionary == null)
			{
				timelineSetDictionary = new Dictionary();
				replacementTimelinesCollection[animationID][characterID] = timelineSetDictionary;
			}
			timelineSetDictionary[setName] = timelines;
		}
		
		/*public function AddSupplementTimelineToLibrary(animationID:int, characterID:int, type:int, timelineName:String, timeline:SerialTween):void
		{
			var typeVector:Vector.<SerialTween> = supplementTimelinesCollection[animationID][characterID][type];
			
			var timelineWithSameNameFound:Boolean = false;
			//Check that a timeline of the given name isn't already in the vector. If it is, then write over it.
			for (var i:int = 0, l:int = typeVector.length; i < l; ++i )
			{
				if (typeVector[i].data == timelineName)
				{
					//Replace the old timeline of the given name with the new one
					typeVector[i] = timeline;
					timelineWithSameNameFound = true;
					break;//Exit the for loop
				}
			}
			if (timelineWithSameNameFound == false)
			{
				//Have the timeline's data contain the given name for it.
				timeline.data = timelineName;
				typeVector[typeVector.length] = timeline;
			}
		}*/
		
		/*Get timeline(s) from library functions*/
		
		
		public function GetBaseTimelinesFromLibrary(animationID:int):Vector.<SerialTween>
		{
			var baseTimelines:Vector.<SerialTween> = null;
			if (animationID < baseTimelinesCollection.length)
			{
				baseTimelines = baseTimelinesCollection[animationID];
			}
			return baseTimelines;
		}
		
		public function GetReplacementTimelinesToLibrary(animationID:int, characterID:int, setName:String ):Vector.<SerialTween>
		{
			var dictionary:Dictionary = replacementTimelinesCollection[animationID][characterID] as Dictionary;
			var timelines:Vector.<SerialTween> = dictionary[setName] as Vector.<SerialTween>;
			return timelines;
		}
		
		public function GetAllSupplementTimelinesOfTypeFromLibrary(animationID:int, characterID:int, type:int):Vector.<SerialTween>
		{
			CheckSupplementTimelinesVectorRange(animationID, characterID);
			var typeVector:Vector.<SerialTween> = supplementTimelinesCollection[animationID][characterID][type];
			
			return typeVector;
		}
		
		public function GetSupplementTimelineFromLibrary(animationID:int, characterID:int, type:int, timelineName:String):SerialTween
		{
			CheckSupplementTimelinesVectorRange(animationID, characterID);
			var typeVector:Vector.<SerialTween> = supplementTimelinesCollection[animationID][characterID][type];
			
			var timeline:SerialTween = null;
			for (var i:int = 0, l:int = typeVector.length; i < l; ++i )
			{
				//Commented out so Flex will shut up. The code is actually wrong but Flex will still compile this function despite it never being called anywhere in the program.
				/*if (typeVector[i].data == timelineName)
				{
					timeline = typeVector[i];
					break;
				}*/
			}
			return timeline;
		}
		
		/*Timeline existance checking*/
		
		public function DoesBaseTimelinesForAnimationExist(animationID:int):Boolean
		{
			var exists:Boolean = false;
			//Enlarge the vector so the index for animationID exists, if it doesn't already.
			while (baseTimelinesCollection.length <= animationID)
			{
				baseTimelinesCollection[baseTimelinesCollection.length] = null;
			}
			if (baseTimelinesCollection.length > 0 && baseTimelinesCollection[animationID] != null)
			{
				exists = true;
			}
			
			return exists;
		}
		
		public function DoesCharacterSetExists(animationID:int, characterID:int, setName:String):Boolean
		{
			var exists:Boolean = false;
			for (var animIndex:int = 0; animIndex <= animationID; ++animIndex )
			{
				//Fill animation vector
				
				if (replacementTimelinesCollection.length <= animIndex /*|| supplementTimelinesCollection[animIndex] == undefined*/)
				{
					replacementTimelinesCollection[animIndex] = new Vector.<Dictionary>();
				}
				
				//Fill character vector
				for (var charIndex:int = 0; charIndex <= characterID; ++charIndex )
				{
					if (replacementTimelinesCollection[animIndex].length <= charIndex /*|| supplementTimelinesCollection[animIndex][charIndex] == undefined*/)
					{
						replacementTimelinesCollection[animIndex][charIndex]  = new Dictionary();
					}
				}
			}
			
			/*while (replacementTimelinesCollection.length <= animationID)
			{
				replacementTimelinesCollection[replacementTimelinesCollection.length] = null;
			}
			while (replacementTimelinesCollection[animationID].length <= characterID)
			{
				replacementTimelinesCollection[animationID][replacementTimelinesCollection[characterID].length] = new Dictionary();
			}*/
			var dictionary:Dictionary = replacementTimelinesCollection[animationID][characterID] as Dictionary;
			if (dictionary[setName] != null)
			{
				exists = true;
			}
			
			return exists;
		}
		
		//Ensures that the given parameters will not cause a range error to be thrown when accessing the supplement timelines
		public function CheckSupplementTimelinesVectorRange(animationID:int, characterID:int/*, type:int*/):void
		{
			for (var animIndex:int = 0; animIndex <= animationID; ++animIndex )
			{
				//Fill animation vector
				
				if (supplementTimelinesCollection.length <= animIndex /*|| supplementTimelinesCollection[animIndex] == undefined*/)
				{
					supplementTimelinesCollection[animIndex] = new Vector.<Vector.<Vector.<SerialTween>>>();
				}
				
				//Fill character vector
				for (var charIndex:int = 0; charIndex <= characterID; ++charIndex )
				{
					if (supplementTimelinesCollection[animIndex].length <= charIndex /*|| supplementTimelinesCollection[animIndex][charIndex] == undefined*/)
					{
						supplementTimelinesCollection[animIndex][charIndex]  = new Vector.<Vector.<SerialTween>>();
						//Fill in the type vectors
						supplementTimelinesCollection[animIndex][charIndex][TYPE_EXPRESSION] = new Vector.<SerialTween>();
						supplementTimelinesCollection[animIndex][charIndex][TYPE_EYE] = new Vector.<SerialTween>();
					}
				}
			}
			
			
			/*while (supplementTimelinesCollection.length <= animationID)
			{
				supplementTimelinesCollection[supplementTimelinesCollection.length] = new Vector.<Vector.<Vector.<SerialTween>>>();
			}
			
			while (supplementTimelinesCollection[animationID].length <= characterID)
			{
				var something:int = supplementTimelinesCollection[animationID].length;
				
				supplementTimelinesCollection[animationID][something][TYPE_EXPRESSION] = new Vector.<SerialTween>();
				supplementTimelinesCollection[animationID][something][TYPE_EYE] = new Vector.<SerialTween>();
				
			}*/
		}
		
		public function HasValidBaseAnimation():Boolean
		{
			return HasValidBaseTimeline;
		}
	}

}