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
	public dynamic class TemplateBase extends MovieClip
	{
		/*Master timeline for the template animation. Contains all the timelines for parts of the animation that are 
		 * controlled  by series of tweens defined by a motion xml.*/
		private var masterTimeline:TimelineMax = new TimelineMax( { useFrames:false, smoothChildTiming:false, paused:true, repeat: -1 /*,onRepeat:DEBUG__MTLOutput, onRepeatParams:["{self}"], onStart:DEBUG__MTLOutput2, onStartParams:["{self}"]*/ } );
		
		public var currentAnimationName:String = "None";
		
		//An Object that contains a number of depth layout change Objects for specified frames of the current animation.
		private var currentAnimationElementDepthLayout:Object;
		//The element depth layout for the latest frame based depth change of the animation.
		private var latestFrameDepthLayout:Object;
		private var elementDepthLayoutChangeFrames:Array;
		
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
		
		public function TemplateBase()
		{
			addEventListener(Event.ADDED_TO_STAGE, TemplateAddedToStage);
		}
		
		public function Initialize(timelineLibrary:TimelineLibrary):void
		{
			timelineLib = timelineLibrary;
		}
		
		public function CreateTimelineFromData(timelineData:Object, displayObjContainingTarget:Sprite):TimelineMax
		{
			var tweenData:Vector.<Object> = timelineData.tweenProperties;
			var TIME_PER_FRAME:Number = timelineData.TIME_PER_FRAME;
			var target:Sprite = displayObjContainingTarget.getChildByName(timelineData.targetName as String) as Sprite;
			var timeline:TimelineMax = null;
			if (target)
			{
				timeline = new TimelineMax( { /*repeat: -1,*/ paused: true, useFrames:false/**/ });
				timeline.data = target;
				for (var i:int = 0, l:int = tweenData.length; i < l; ++i)
				{
					var currentTweenData:Object = tweenData[i];
					var duration:int = 0;
					if ("duration" in currentTweenData)
					{
						duration = currentTweenData.duration;
						delete currentTweenData.duration; //Remove duration from tween data so it can be passed used for the tween's var property
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
		
		/*Modifies the elements depth layout to match the latest layout that should be used. For example, if an animation has 3 layout changes
		 * at frame 1, 34 and 90 and there is a switch to this animation on the 89th frame, the layout for the 34th frame will be used. 
		 * This function should be called when the animation is switched*/
		
		//Time based version
		public function ImmediantLayoutUpdate():void
		{
			//Get current time 
			var currentTime:Number = masterTimeline.time();
			//Start at the end and work backwards
			for (var i:int = elementDepthLayoutChangeFrames.length - 1; i >= 0; --i)
			{
				var layoutChangeTime:Number = elementDepthLayoutChangeFrames[i];

				if (currentTime >= layoutChangeTime)
				{
					latestFrameDepthLayout = currentAnimationElementDepthLayout[elementDepthLayoutChangeFrames[i]];
					ChangeElementDepths(latestFrameDepthLayout);
					break; //Break out the for loop
				}
			}
			//UpdateAnchoredElements();
		}
		 
		//Frame based ver
		/*public function ImmediantLayoutUpdate(animFrame:int):void
		{
			//Start at the end and work backwards
			for (var i:int = elementDepthLayoutChangeFrames.length - 1; i >= 0; --i)
			{
				var frame:String = elementDepthLayoutChangeFrames[i];
				//frame = frame.substring(1);
				var depthChangeFrame:int = parseInt(frame, 10);
				if (animFrame >= depthChangeFrame)
				{
					latestFrameDepthLayout = currentAnimationElementDepthLayout[elementDepthLayoutChangeFrames[i]];
					ChangeElementDepths(latestFrameDepthLayout);
					break; //Break out the for loop
				}
			}
			//UpdateAnchoredElements();
		}*/
		
		
		public function ChangeElementDepths(depthLayout:Object):void
		{
			
			//If there are any maskedContainers being used, remove them.
			while ( maskedContainerIndexes.length > 0)
			{
				var container:DisplayObjectContainer = maskedContainerIndexes.pop();
				while (container.numChildren > 0)
				{
					//Put the child element in the container back where it came from
					this.addChild(container.getChildAt(0));
					
				}
				//Remove the container from the template base, allowing it to be garbage collected (optimization: Allow them to be reused, avoiding costly GC)
				this.removeChild(container);
			}
			
			var templateChildrenCount:uint = numChildren;
			var templateElements:Vector.<DisplayObject> = new Vector.<DisplayObject>(templateChildrenCount);
			//var ShaftMask:DisplayObject = null, Shaft:DisplayObject = null, HeadMask:DisplayObject = null, Head:DisplayObject = null;
			for (var i:uint = 0; i < templateChildrenCount; ++i)
			{
				templateElements[i] = getChildAt(i);
			}
			var sortedDepthElements:Array = new Array();
			for (var childIndex:uint = 0; childIndex < templateChildrenCount; ++childIndex)
			{
				var element:DisplayObject = templateElements[childIndex];
				//element.visible = false;
				var elementName:String = element.name;

				var elementTweens:Array = masterTimeline.getTweensOf(element, true);
				
				if (elementName in depthLayout)
				{	
					sortedDepthElements[sortedDepthElements.length] = [element, depthLayout[elementName]];
					
					if (elementTweens.length > 0)
					{
						var timelineToStart:TimelineMax = (elementTweens[0] as TweenLite).timeline as TimelineMax;
						if (!timelineToStart.isActive())
						{
							timelineToStart.seek(0);
							timelineToStart.play(masterTimeline.time());
						}
					}
				}
				else
				{
					//Check that there are tweens. If there are, then a timeline is currently associated with the element. Stop this timeline.
					if (elementTweens.length > 0)
					{
						//Stop the timeline to reduce processing strain
						((elementTweens[0] as TweenLite).timeline as TimelineMax).stop();
						
						//timelineToStop.stop();
					}
					element.visible = false;
				}
			}
			
			sortedDepthElements.sort(SortElementsByDepthPriority);
			
			
			
			//var topDepth:int = templateChildrenCount - 1;
			//var lastDepthIndex:int = -1;
			var latestElement:Sprite = null;
			var latestMaskedContainer:Sprite = null;
			for (var arrayPosition:int = 0, length:int = sortedDepthElements.length; arrayPosition < length; ++arrayPosition )
			{
				var currentElement:Sprite = sortedDepthElements[arrayPosition][0];
				if (currentElement)
				{
					//currentElement.visible = true;
				}
				/*If depth for the element has a decimal value then it is to be masked. Since as3 has a 1 element per mask limitation,
				what needs to be done is creating a container for all elements to be masked then have that [the container] be masked.*/
				var depth:Number = sortedDepthElements[arrayPosition][1];
				if (depth % 1 != 0)
				{
					if (!latestMaskedContainer)
					{
						latestMaskedContainer = new Sprite();
						latestMaskedContainer.name = latestElement.name + "MaskedContainer";
						var indexOfLatestElement:int = this.getChildIndex(latestElement);
						this.addChildAt(latestMaskedContainer, indexOfLatestElement);
						maskedContainerIndexes.push(latestMaskedContainer);
						latestMaskedContainer.mask = latestElement;
					}
					latestMaskedContainer.addChild(currentElement);
				}
				
				//Mask related logic
				//var maskedContainer:Sprite = new Sprite();
			
				else /*if(currentElement)*/
				{
					latestElement = currentElement;
					setChildIndex(latestElement, numChildren - 1);
					latestMaskedContainer = null;
					//trace(arrayPosition + ": " + sortedDepthElements[arrayPosition].name);
				}
				//lastDepthIndex = depthLayout[elementName];
			}	
			
		}

		
		private function SortElementsByDepthPriority(a:Array, b:Array):int
		{
			if (a[1] > b[1])
			{
				return 1;
			}
			else if (a[1] < b[1])
			{
				return -1;
			}
			else
			{
				return 0;
			}
		}
		public function ChangePlaySpeed(speed:Number):void
		{
			masterTimeline.timeScale(speed);
			//Get all timelines currently used
			//var childTimelines:Array = masterTimeline.getChildren(!true, false);
			/*for (var i:int = 0, l:int = childTimelines.length; i < l; ++i)
			{
				//Tell the child timeline to play at the specified time
				(childTimelines[i] as TimelineMax).timeScale(speed);
				//trace((childTimelines[i] as TimelineMax).data.name + "Time: " + (childTimelines[i] as TimelineMax).time());
			}*/
		}
		
		//Starts playing the currently set animation at a specified time in seconds.
		public function PlayAnimation(startTime:Number):void
		{
			if (startTime == -1)
			{
				startTime = masterTimeline.time();
			}
			//--startAtFrame;
			if (animationPaused) { animationPaused = false;}
			masterTimeline.play(startTime);
			//Get all timelines currently used
			var childTimelines:Array = masterTimeline.getChildren(!true, false);
			for (var i:int = 0, l:int = childTimelines.length; i < l; ++i)
			{
				//Tell the child timeline to play at the specified time
				(childTimelines[i] as TimelineMax).play(startTime);
			}
			if (childTimelines.length > 0)
			{
				ImmediantLayoutUpdate();
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
			//--startAtFrame;
			//var time:int = startAtFrame; //useFrames version
			//if (masterTimeline.paused() == false)
			//{
				
			//}
			//else
			//{
				masterTimeline.seek(frame);
				var childTimelines:Array = masterTimeline.getChildren(true, false);
				
				for (var i:int = 0, l:int = childTimelines.length; i < l; ++i)
				{
					(childTimelines[i] as TimelineMax).seek(frame);
				}
			//}
		}
		
		/*Pauses the animation. Currently used, it's just here in case there is a time where the animation needs to be paused. 
		Might be useful when character editing facilities are better and they need a still to look at.*/
		public function StopAnimation():void
		{
			animationPaused = true;
			masterTimeline.stop();
			/*var childTimelines:Array = masterTimeline.getChildren(true, false);
			for (var i:int = 0, l:int = childTimelines.length; i < l; ++i)
			{
				(childTimelines[i] as TimelineLite).stop();
			}*/
		}
		
		/*Removes all currently active timelines and adds the base timelines for a specified animation.*/
		public function ChangeBaseTimelinesUsed(animationIndex:uint):void
		{
			var timelines:Vector.<TimelineMax> = timelineLib.GetBaseTimelinesFromLibrary(animationIndex);
			if (timelines)
			{
				//ClearTimelines();
				AddTimelines(timelines);
			}
		}
		
		/*public function ResetToDefaultTimelines()
		{
			masterTimeline.clear();
			masterTimeline.add(defaultTimelines);
			//UpdateTimelines();
		}*/
		
		/*Removes all children timelines, which control the various body part elements of the master template, from the master timeline.
		 Additionally, these body part elements are set to be invisible. */
		public function ClearTimelines():void
		{
			//Get the timelines used currently
			var childTimelines:Array = masterTimeline.getChildren(true, false);
			var currentChildTimeline:TimelineMax;
			//Iterate through all the timelines 
			for (var i:int = 0, l:int = childTimelines.length; i < l; ++i)
			{
				currentChildTimeline = childTimelines[i] as TimelineMax;
				//The element that the timeline controls is to become invisible.
				//TODO: Test if it is more efficient, performance wise, to remove the element from the master template.
				(currentChildTimeline.data as DisplayObject).visible = false;
			}
			//Remove the array of timelines from the master timeline, leaving it clear for another animation.
			masterTimeline.remove(childTimelines);
		}
		
		//Adds the timelines contained in a vector to the master timeline.
		public function AddTimelines(timelinesToAdd:Vector.<TimelineMax>):void
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
		public function AddTimeline(tlToAdd:TimelineMax):void
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
		public function ReplaceTimeline(tlToRemove:TimelineMax, tlToAdd:TimelineMax):void
		{
			if (tlToRemove != tlToAdd)
			{
				tlToRemove.pause();
				tlToRemove.stop();
				masterTimeline.remove(tlToRemove);
				masterTimeline.add(tlToAdd, 0);
				//Start from the first tween so visibility is set correct during mid-animation switches.
				tlToAdd.seek(0);
				//Now start playing from the master timeline's current time
				tlToAdd.play(masterTimeline.time());
				//tlToAdd.seek(((((this.parent as MovieClip).currentFrame-2) % 120) * millisecPerFrame) / 1000.0);
			}
		}
		
		public function SetElementDepthLayout(layout:Object):void
		{
			
			elementDepthLayoutChangeFrames  = new Array();
			for(var index:String in layout)
			{
				elementDepthLayoutChangeFrames[elementDepthLayoutChangeFrames.length] = index;
			}
			elementDepthLayoutChangeFrames.sort(Array.NUMERIC);
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
		
		public function DEBUG__MTLOutput(masterTimeline:TimelineMax):void
		{ 
			//trace("Animation finished");
		}
		
		public function DEBUG__MTLOutput2(masterTimeline:TimelineMax):void
		{
			//trace("Animation Started at " + getTimer());
		}
		
		public function GetDurationOfCurrentAnimation():Number
		{
			return masterTimeline.duration();
		}
	}

}