package ppppu 
{
	import com.greensock.TimelineLite;
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.*;
	//import EyeContainer;
	//import MouthContainer;
	/**
	 * ...
	 * @author 
	 */
	public dynamic class TemplateBase extends Sprite
	{
		/*Master timeline for the template animation. Contains all the timelines for parts of the animation that are 
		 * controlled  by series of tweens defined by a motion xml.*/
		private var masterTimeline:TimelineMax = new TimelineMax( { useFrames:false, smoothChildTiming:false, paused:true, repeat: -1 /*,onRepeat:DEBUG__MTLOutput, onRepeatParams:["{self}"], onStart:DEBUG__MTLOutput2, onStartParams:["{self}"]*/ } );
		
		//An Object that contains a number of depth layout change Objects for specified frames of the current animation.
		private var currentAnimationElementDepthLayout:Object;
		//The element depth layout for the latest frame based depth change of the animation.
		private var latestFrameDepthLayout:Object;
		//Indicates the various times in the animation that the elements will be rearranged in terms of render order.
		private var elementLayoutChangeTimes:Array = [];
		
		//How far into the current animation we're in
		private var frameCounter:int = 0;
		//The total number of frames in the current animation.
		//TODO: allow this to be set, which is needed for animations with non-standard frames(not 120)
		private var currentAnimationTotalFrames:int = 120;
		
		private var latestAnimationDuration:Number;
		
		//The primary movie clip for the flash in terms as asset displaying.
		private var m_ppppuStage:PPPPU_Stage;
		
		private var animationPaused:Boolean = false;
		
		public var timelineLib:TimelineLibrary;
		
		public var maskedContainerIndexes:Vector.<Sprite> = new Vector.<Sprite>();
		
		//Class level arrays used during the AddTimelines function to prevent constant allocation/GC when the function is called.
		private var timelinesPendingRemoval:Array = [];
		private var timelinesOkForAdding:Array = [];
		/*Keeps track of what timeline is controlling what element. Used to avoid the getTweensOf call, which will allocate an array. 
		The element is the key and the timelinemax instance is the value.*/
		private var elementTimelineDict:Dictionary = new Dictionary();
		/*sorted depth elements arrays. Split into 2 parts to */
		//Used by the ChangeElementDepths function to avoid allocation of an array every time it's called.
		private var sortedDepthElements:Array = [];
		//private var sortedDepthElements_Depth:Array = [];
		
		public function TemplateBase()
		{
			addEventListener(Event.ADDED_TO_STAGE, TemplateAddedToStage);
		}
		
		public function Initialize(timelineLibrary:TimelineLibrary):void
		{
			timelineLib = timelineLibrary;
		}
		
		public function CreateTimelineFromData(timelineData:Object, displayObjContainingTarget:Sprite):TimelineLite
		{
			var tweenData:Vector.<Object> = timelineData.tweenProperties;
			var TIME_PER_FRAME:Number = timelineData.TIME_PER_FRAME;
			var target:Sprite = displayObjContainingTarget.getChildByName(timelineData.targetName as String) as Sprite;
			var timeline:TimelineLite = null;
			if (target)
			{
				timeline = new TimelineLite( { paused: true, useFrames:false });
				timeline.data = target;
				var currentTweenData:Object;
				var duration:int;
				for (var i:int = 0, l:int = tweenData.length; i < l; ++i)
				{
					currentTweenData = tweenData[i];
					
					
					if ("duration" in currentTweenData)
					{
						duration = currentTweenData.duration;
						currentTweenData.duration = null; //Remove duration from tween data so it can be passed used for the tween's var property
					}
					else
					{
						duration = 0;
					}
					if (duration)
					{
						timeline.to(target, duration * TIME_PER_FRAME, currentTweenData);
					}
					else
					{
						timeline.set(target, currentTweenData);
					}
					
					//Visibility fallback check for first tween. Assume that it is to be visible if there was no visible property specified.
					if (i == 0)
					{
						if (!("visible" in currentTweenData))
						{
							currentTweenData.visible = true;
						}
					}
				}
			}
			
			return timeline;
		}
		
		public function Update():void
		{
			if (animationPaused == false) //If animation isn't paused, update
			{
				++frameCounter;
				if (frameCounter >= currentAnimationTotalFrames)
				{
					frameCounter = 0;
				}
				//ImmediantLayoutUpdate(frameCounter);
			}
		}
		
		public function ChangeAnimation(displayLayout:Object, animationId:int, charId:int=-1, replaceSetName:String="Standard"):void
		{
			var timer:int = getTimer();
			//set the element depth layout for the animation
			elementLayoutChangeTimes.length = 0;
			for(var index:String in displayLayout)
			{
				elementLayoutChangeTimes[elementLayoutChangeTimes.length] = Number(index);
			}
			currentAnimationElementDepthLayout = displayLayout;
			trace("Change layout completed in " + (getTimer() - timer));
			timer = getTimer();
			//Get timelines that will be added
			var timelines:Vector.<TimelineLite> = timelineLib.GetBaseTimelinesFromLibrary(animationId);
			if (timelines)
			{
				AddTimelines(timelines);
			}
			trace("Add base timelines completed in " + (getTimer() - timer));
			timer = getTimer();
			if (timelineLib.DoesCharacterSetExists(animationId, charId, replaceSetName))
			{
				AddTimelines(timelineLib.GetReplacementTimelinesToLibrary(animationId, charId, replaceSetName));
			}
			trace("Add replacement timelines completed in " + (getTimer() - timer));
			timer = getTimer();
			//Cause a change to the depth of the elements
			var currentTime:Number = masterTimeline.time();
			var layoutChangeTime:Number;
			//Start at the end and work backwards
			for (var i:int = elementLayoutChangeTimes.length - 1; i >= 0; --i)
			{
				layoutChangeTime = elementLayoutChangeTimes[i];

				if (currentTime >= layoutChangeTime)
				{
					latestFrameDepthLayout = currentAnimationElementDepthLayout[elementLayoutChangeTimes[i]];
					ChangeElementDepths(latestFrameDepthLayout);
					break; //Break out the for loop
				}
			}
			trace("Depth sort and change completed in "+(getTimer() - timer));
		}
		
		/*Modifies the elements depth layout to match the latest layout that should be used. For example, if an animation has 3 layout changes
		 * at frame 1, 34 and 90 and there is a switch to this animation on the 89th frame, the layout for the 34th frame will be used. 
		 * This function should be called when the animation is switched*/
		
		//Time based version
		/*public function ImmediantLayoutUpdate():void
		{
			//Get current time 
			var currentTime:Number = masterTimeline.time();
			var layoutChangeTime:Number;
			//Start at the end and work backwards
			for (var i:int = elementLayoutChangeTimes.length - 1; i >= 0; --i)
			{
				layoutChangeTime = elementLayoutChangeTimes[i];

				if (currentTime >= layoutChangeTime)
				{
					latestFrameDepthLayout = currentAnimationElementDepthLayout[elementLayoutChangeTimes[i]];
					ChangeElementDepths(latestFrameDepthLayout);
					break; //Break out the for loop
				}
			}
			//UpdateAnchoredElements();
		}*/
		
		[Inline]
		final public function ChangeElementDepths(depthLayout:Object):void
		{
			
			var container:DisplayObjectContainer;
			//If there are any maskedContainers being used, remove them.
			var maskedContainerIndexesLength:int = maskedContainerIndexes.length;
			while (maskedContainerIndexesLength--)
			{
				container = maskedContainerIndexes.pop();
				var containerChildrenNumber:int = container.numChildren;
				while (containerChildrenNumber--)
				{
					//Put the child element in the container back where it came from
					this.addChild(container.getChildAt(0));
					
				}
				//Remove the container from the template base, allowing it to be garbage collected (optimization: Allow them to be reused, avoiding costly GC)
				this.removeChild(container);
			}
			
			var templateChildrenCount:int = numChildren;
			//var templateChildIndex:int = templateChildrenCount;
			//var templateElements:Vector.<DisplayObject> = new Vector.<DisplayObject>(templateChildrenCount);
			//var ShaftMask:DisplayObject = null, Shaft:DisplayObject = null, HeadMask:DisplayObject = null, Head:DisplayObject = null;
			/*while (templateChildIndex--)
			{
				templateElements[templateChildIndex] = getChildAt(templateChildIndex);
			}*/
			sortedDepthElements.length = 0;
			var element:DisplayObject;
			var elementName:String;
			var timeline:TimelineLite;
			for (var childIndex:int = 0; childIndex < templateChildrenCount; ++childIndex)
			{
				element = this.getChildAt(childIndex);
				elementName = element.name;
				
				//Get the timeline that was last used for the element
				timeline = elementTimelineDict[element] as TimelineLite;
				if (elementName in depthLayout)
				{	
					sortedDepthElements[sortedDepthElements.length] = element;
					if (timeline && !timeline.isActive())
					{
						timeline.seek(0);
						timeline.play(masterTimeline.time());
					}
				}
				else
				{
					//Check that there are tweens. If there are, then a timeline is currently associated with the element. Stop this timeline.
					if (timeline)
					{
						//Stop the timeline to reduce processing
						timeline.stop();
						//Remove the reference of the timeline from the elementTimelineDict
						elementTimelineDict[element] = null;
					}
					element.visible = false;
				}
			}
			
			//Sort the array by using the comb sort algorithm
			var arraySize:int = sortedDepthElements.length;
			var gap:int = arraySize;
			var shrinkFactor:Number = 1.3;
			var swapped:Boolean = false;
			var swapElementHolder:DisplayObject;
			var compElementDepth1:Number;
			var compElementDepth2:Number;
			while (gap != 1 || swapped)
			{
				gap = int(gap / shrinkFactor);
				if (gap < 1) { gap = 1; }
			
				var i:int = 0;
				swapped = false;
				
				while (i + gap < arraySize)
				{
					compElementDepth1 = depthLayout[sortedDepthElements[i].name];
					compElementDepth2 = depthLayout[sortedDepthElements[i + gap].name];
					if (compElementDepth1 > compElementDepth2)
					{
						swapElementHolder = sortedDepthElements[i];
						sortedDepthElements[i] = sortedDepthElements[i + gap];
						sortedDepthElements[i + gap] = swapElementHolder;
						swapped = true;
					}
					if (compElementDepth1 == compElementDepth2)
					{
						swapped = true;
					}
					++i;
				}
			}
			
			var latestElement:Sprite = null;
			var latestMaskedContainer:Sprite = null;
			var currentElement:Sprite;
			var depth:Number;
			var currentElementName:String;
			for (var arrayPosition:int = 0, length:int = sortedDepthElements.length; arrayPosition < length; ++arrayPosition )
			{
				currentElement = sortedDepthElements[arrayPosition];
				currentElementName = currentElement.name;

				/*If depth for the element has a decimal value (depth % 1 != 0)  then it is to be masked. Since as3 has a 1 element per mask limitation,
				what needs to be done is creating a container for all elements to be masked then have that [the container] be masked.*/
				depth = depthLayout[currentElementName];
				if (depth % 1 == 0)
				{
					latestElement = currentElement;
					setChildIndex(latestElement, numChildren - 1);
					latestMaskedContainer = null;
				}
				else //Masking related logic
				{
					if (!latestMaskedContainer)
					{
						latestMaskedContainer = new Sprite();
						latestMaskedContainer.name = latestElement.name + "MaskedContainer";
						this.addChildAt(latestMaskedContainer, this.getChildIndex(latestElement));
						maskedContainerIndexes.push(latestMaskedContainer);
						latestMaskedContainer.mask = latestElement;
					}
					latestMaskedContainer.addChild(currentElement);
				}
			}	
			
		}
		
		public function ChangePlaySpeed(speed:Number):void
		{
			masterTimeline.timeScale(speed);
		}
		
		//Starts playing the currently set animation at a specified time in seconds.
		public function PlayAnimation(startTime:Number):void
		{
			if (startTime == -1)
			{
				startTime = masterTimeline.time();
			}
			if (animationPaused) { animationPaused = false;}
			masterTimeline.play(startTime);
			//Get all timelines currently used
			//elementTimelineDict
			var childTimelines:Array = masterTimeline.getChildren(!true, false);
			for (var i:int = 0, l:int = childTimelines.length; i < l; ++i)
			{
				//Tell the child timeline to play at the specified time
				(childTimelines[i] as TimelineLite).play(startTime);
			}
		}
		
		public function ResumePlayingAnimation():void
		{
			animationPaused = false;
			masterTimeline.play();
			//Get all timelines currently used
			/*var childTimelines:Array = masterTimeline.getChildren(!true, false);
			for (var i:int = 0, l:int = childTimelines.length; i < l; ++i)
			{
				//Tell the child timeline to play at the specified time
				(childTimelines[i] as TimelineMax).play(frameCounter);
			}*/
		}
		
		public function JumpToFrameAnimation(frame:uint):void
		{
				masterTimeline.seek(frame);
				var childTimelines:Array = masterTimeline.getChildren(true, false);
				
				for (var i:int = 0, l:int = childTimelines.length; i < l; ++i)
				{
					(childTimelines[i] as TimelineLite).seek(frame);
				}
		}
		
		/*Pauses the animation. Currently used, it's just here in case there is a time where the animation needs to be paused. 
		Might be useful when character editing facilities are better and they need a still to look at.*/
		public function StopAnimation():void
		{
			animationPaused = true;
			masterTimeline.stop();
		}
		
		/*Removes all currently active timelines and adds the base timelines for a specified animation.*/
		public function ChangeBaseTimelinesUsed(animationIndex:uint, clearCurrentTimelines:Boolean=false):void
		{
			var timelines:Vector.<TimelineLite> = timelineLib.GetBaseTimelinesFromLibrary(animationIndex);
			if (timelines)
			{
				if (clearCurrentTimelines)
				{
					masterTimeline.clear();
				}
				AddTimelines(timelines);
			}
		}
		
		/*Removes all children timelines, which control the various body part elements of the master template, from the master timeline.
		 Additionally, these body part elements are set to be invisible. */
		public function ClearTimelines():void
		{
			//Get the timelines used currently
			var childTimelines:Array = masterTimeline.getChildren(true, false);
			var currentChildTimeline:TimelineLite;
			//Iterate through all the timelines 
			for (var i:int = 0, l:int = childTimelines.length; i < l; ++i)
			{
				currentChildTimeline = childTimelines[i] as TimelineLite;
				//The element that the timeline controls is to become invisible.
				//TODO: Test if it is more efficient, performance wise, to remove the element from the master template.
				(currentChildTimeline.data as DisplayObject).visible = false;
			}
			//Remove the array of timelines from the master timeline, leaving it clear for another animation.
			masterTimeline.remove(childTimelines);
		}
		
		//Adds the timelines contained in a vector to the master timeline.
		[Inline]
		final public function AddTimelines(timelinesToAdd:Vector.<TimelineLite>):void
		{
			
			//Current way of handling when a replacement timeline doesn't exist. Works poorly by keeping the default.
			if (timelinesToAdd == null || timelinesToAdd.length == 0)
			{
				return;
			}
			var tlToAdd:TimelineLite;
			var timelineDisplayObject:DisplayObject;
			var childTimeline:TimelineLite;
			
			//reset the arrays involved used by this function in a way that it won't invoke an allocation or allow for garbage collection
			timelinesPendingRemoval.length = 0;
			timelinesOkForAdding.length = 0;
			for (var i:uint = 0, l:uint = timelinesToAdd.length; i < l; ++i)
			{
				tlToAdd = timelinesToAdd[i];
				//If the timeline to add is null, return out the function.
				if (tlToAdd != null) 
				{
					//The display object that the timeline controls
					timelineDisplayObject = tlToAdd.data as DisplayObject;
					
					//Check to see if the master timeline already has a nested timeline for the specified display object.
					//If it does, then replace it. Otherwise, add it.
					
					//Optimized version
					//Get timeline from the elementTimelineDict.
					childTimeline = elementTimelineDict[timelineDisplayObject] as TimelineLite;
					//Remove old timeline for element if needed
					if (childTimeline && childTimeline != tlToAdd)
					{
						timelinesPendingRemoval[timelinesPendingRemoval.length] = childTimeline;
					}
					timelinesOkForAdding[timelinesOkForAdding.length] = elementTimelineDict[timelineDisplayObject] = tlToAdd;
				}
			}
			//For cache purposes, executing functions on timelinesOkForAdding members here.
			var timelinesAddingCount:int = timelinesOkForAdding.length;		
			
			masterTimeline.remove(timelinesPendingRemoval);
			var addTimer:int = getTimer();
			masterTimeline.add(timelinesOkForAdding,0);
			//masterTimeline.addTimelines(timelinesToAdd);
			trace("\tAdd to mastertimeline took " + (getTimer() - addTimer));
		}
		
		
		//Adds the timelines contained in a vector to the master timeline.
		/*[Inline]
		final public function AddTimelines(timelinesToAdd:Vector.<TimelineMax>):void
		{
			//CUrrent way of handling when a replacement timeline doesn't exist. Works poorly by keeping the default.
			if (timelinesToAdd == null || timelinesToAdd.length == 0)
			{
				return;
			}
			
			for (var i:uint = 0, l:uint = timelinesToAdd.length; i < l; ++i)
			{
				AddTimeline(timelinesToAdd[i] as TimelineMax);
				//trace(timelinesToAdd[i].data.name + ": " + timelinesToAdd[i].duration());
			}
		}
		
		//Adds a specified Timeline to the master timeline.
		[Inline]
		final public function AddTimeline(tlToAdd:TimelineMax):void
		{
			//If the timeline to add is null, return out the function.
			if (tlToAdd == null) { return; }
			
			//The display object that the timeline controls
			var timelineDisplayObject:DisplayObject = tlToAdd.data as DisplayObject;
			//Check to see if the master timeline already has a nested timeline for the specified display object.
			//If it does, then replace it. Otherwise, add it.
			
			//Optimized version
			var elementTweens:Array = masterTimeline.getTweensOf(timelineDisplayObject, true);
			if (elementTweens.length > 0)
			{
				var childTimeline:TimelineMax = (elementTweens[0] as TweenLite).timeline as TimelineMax;
				ReplaceTimeline(childTimeline, tlToAdd);
				return;
			}
			
			//Looked through all the timelines nested in the master timeline and there were no matches for tlToAdd to override.
			masterTimeline.add(tlToAdd, 0);
			tlToAdd.seek(0);
			tlToAdd.play(masterTimeline.time());
		}
		
		//Replaces a specified timeline with another and then sets the newly added timeline to the frame that the removed one was on.
		[Inline]
		final public function ReplaceTimeline(tlToRemove:TimelineMax, tlToAdd:TimelineMax):void
		{
			if (tlToRemove != tlToAdd)
			{
				tlToRemove.pause();
				masterTimeline.remove(tlToRemove);
				masterTimeline.add(tlToAdd, 0);
				//Start from the first tween so visibility is set correct during mid-animation switches.
				tlToAdd.seek(0);
				//Now start playing from the master timeline's current time
				tlToAdd.play(masterTimeline.time());
				//tlToAdd.seek(((((this.parent as MovieClip).currentFrame-2) % 120) * millisecPerFrame) / 1000.0);
			}
		}*/
		
		public function SetElementDepthLayout(layout:Object):void
		{
			//reset array
			elementLayoutChangeTimes.length = 0;
			for(var index:String in layout)
			{
				elementLayoutChangeTimes[elementLayoutChangeTimes.length] = index;
			}
			currentAnimationElementDepthLayout = layout;
		}
		
		
		public function TemplateAddedToStage(e:Event):void
		{
			var displayObjBeingChecked:DisplayObjectContainer = this;
			while (displayObjBeingChecked != stage && !(displayObjBeingChecked is PPPPU_Stage))
			{
				displayObjBeingChecked = displayObjBeingChecked.parent;
				if (displayObjBeingChecked is PPPPU_Stage)
				{
					m_ppppuStage = displayObjBeingChecked as PPPPU_Stage;
				}
			}
			removeEventListener(Event.ADDED_TO_STAGE, TemplateAddedToStage);
		}
		public function GetPPPPU_Stage():PPPPU_Stage
		{
			return m_ppppuStage;
		}
		
		function RoundToNearest(roundTo:Number, value:Number):Number{
		return Math.round(value/roundTo)*roundTo;
		}
		
		/*public function DEBUG__MTLOutput(masterTimeline:TimelineMax):void
		{ 
			//trace("Animation finished");
		}
		
		public function DEBUG__MTLOutput2(masterTimeline:TimelineMax):void
		{
			//trace("Animation Started at " + getTimer());
		}*/
		
		public function GetDurationOfCurrentAnimation():Number
		{
			return masterTimeline.duration();
		}
		
		public function GetTimeInCurrentAnimation():Number
		{
			return masterTimeline.time();
		}
	}

}