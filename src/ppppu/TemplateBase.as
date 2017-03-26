package ppppu 
{
	import animations.AnimateShardLibrary;
	import animations.DispObjInfo;
	import animations.TimelineLibrary;
	import flash.display.SpreadMethod;
	import org.libspark.betweenas3.BetweenAS3;
	import org.libspark.betweenas3.core.tweens.ObjectTween;
	import org.libspark.betweenas3.core.tweens.groups.SerialTween;
	import org.libspark.betweenas3.core.tweens.groups.ParallelTween;
	import org.libspark.betweenas3.easing.Linear;
	import org.libspark.betweenas3.events.TweenEvent;
	import org.libspark.betweenas3.tweens.IObjectTween;
	import org.libspark.betweenas3.tweens.ITween;
	//import com.greensock.TimelineLite;
	//import com.greensock.TimelineMax;
	//import com.greensock.TweenLite;
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
	import ppppu.AnimationLayout;
	import ppppu.LayoutFrameVector;
	import ppppu.LayoutRecord;
	import animations.AnimateShard;
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
		//private var masterTimeline:TimelineMax = new TimelineMax( { useFrames:false, smoothChildTiming:false, paused:true, repeat: -1 /*,onRepeat:DEBUG__MTLOutput, onRepeatParams:["{self}"], onStart:DEBUG__MTLOutput2, onStartParams:["{self}"]*/ } );
		public var masterTimeline:ParallelTween;
		public var baseAnimationTweens:ParallelTween;
		public var additionalAnimationTweens:ParallelTween;
		//An Object that contains a number of depth layout change Objects for specified frames of the current animation.
		//private var currentAnimationElementDepthLayout:Object;
		private var currentAnimationElementDepthLayout:AnimationLayout;
		//The element depth layout for the latest frame based depth change of the animation.
		//private var latestFrameDepthLayout:Object;
		private var latestFrameDepthLayout:LayoutFrameVector;
		//Indicates the various times in the animation that the elements will be rearranged in terms of render order.
		private var elementLayoutChangeTimes:Array = [];
		//private var latestIndexOfLayoutChangeUsed:int = -1;
		//How far into the current animation we're in
		//private var frameCounter:int = 0;
		//The total number of frames in the current animation.
		//TODO: allow this to be set, which is needed for animations with non-standard frames(not 120)
		//private var currentAnimationTotalFrames:int = 120;
		
		private var latestAnimationDuration:Number;
		
		//The primary movie clip for the flash in terms as asset displaying.
		private var m_ppppuStage:PPPPU_Stage;
		
		private var animationPaused:Boolean = false;
		
		//public var timelineLib:TimelineLibrary;
		public var shardLib:AnimateShardLibrary;
		
		public var maskedContainerIndexes:Vector.<Sprite> = new Vector.<Sprite>();
		
		//Class level arrays used during the AddTimelines function to prevent constant allocation/GC when the function is called.
		//private var timelinesPendingRemoval:Array = [];
		private var timelinesPendingRemoval:Vector.<SerialTween> = new Vector.<SerialTween>();
		private var timelinesOkForAdding:Array = [];
		/*Keeps track of what timeline is controlling what element. Used to avoid the getTweensOf call, which will allocate an array. 
		The element is the key and the timelinemax instance is the value.*/
		private var elementTimelineDict:Dictionary = new Dictionary();
		
		private var timelineControlElementDict:Dictionary = new Dictionary();
		
		private var elementDict:Dictionary = new Dictionary();
		
		var containers:Vector.<Sprite> = new Vector.<Sprite>();
		
		/*sorted depth elements arrays. Split into 2 parts to */
		//Used by the ChangeElementDepths function to avoid allocation of an array every time it's called.
		//Due to experimental code, this array is not needed. When custom elements can be added and are set to a relative position, then this will be needed again.
		//private var sortedDepthElements:Array = [];
		//private var sortedDepthElements_Depth:Array = [];
		
		public function TemplateBase()
		{
			var layer1:Sprite = new Sprite();
			var layer2:Sprite = new Sprite();
			var layer3:Sprite = new Sprite();
			var layer4:Sprite = new Sprite();
			layer1.name = "HairFrontLayer";
			layer2.name = "HairBehindFaceLayer";
			layer3.name = "HairBehindHeadwearLayer";
			layer4.name = "HairBackLayer";
			addChild(layer1); addChild(layer2); addChild(layer3); addChild(layer4);
			addEventListener(Event.ADDED_TO_STAGE, TemplateAddedToStage);
		}
		
		public function Initialize(shardLibrary:AnimateShardLibrary/*timelineLibrary:TimelineLibrary*/):void
		{
			//timelineLib = timelineLibrary;
			shardLib = shardLibrary;
			
			for (var i:int = 0, l:int = this.numChildren; i < l; ++i)
			{
				var child:Sprite = this.getChildAt(i) as Sprite;
				if (child)
				{
					child.mouseChildren = false;
					child.mouseEnabled = false;
				}
			}
		}
		
		public function CreateTimelineFromData(timelineData:Object, displayObjContainingTarget:Sprite):SerialTween
		{
			var tweenData:Vector.<Object> = timelineData.tweenProperties;
			var TIME_PER_FRAME:Number = timelineData.TIME_PER_FRAME;
			var target:Sprite = elementDict[timelineData.targetName] as Sprite;
			//var target:Sprite = displayObjContainingTarget.getChildByName(timelineData.targetName as String) as Sprite;
			var timeline:SerialTween = null;
			var currentTweenData:Object, previousTweenData:Object;
			//var = null;
			if (target)
			{
				var tweens:Array = new Array();
				//timeline = new TimelineLite( { paused: true, useFrames:false });
				//timeline.data = target;
				timelineControlElementDict[timeline] = target;
				
				var duration:int;

				for (var i:int = 0, l:int = tweenData.length; i < l; ++i)
				{
					currentTweenData = { };
					//currentTweenData = tweenData[i];
					if ("transformMatrix" in tweenData[i])
					{
						
						//currentTweenData.x = tweenData[i].transformMatrix.tx;
						//currentTweenData.y = tweenData[i].transformMatrix.ty;
						//var matrix:Matrix = new Matrix(tweenData[i].transformMatrix.a, tweenData[i].transformMatrix.b, tweenData[i].transformMatrix.c, tweenData[i].transformMatrix.d, tweenData[i].transformMatrix.tx, tweenData[i].transformMatrix.ty);
						/*currentTweenData._matrix = matrix;
						currentTweenData.transform = { }; currentTweenData.transform.matrix = { };
						currentTweenData._matrix.a = tweenData[i].transformMatrix.a;
						currentTweenData._matrix.b = tweenData[i].transformMatrix.b;
						currentTweenData._matrix.c = tweenData[i].transformMatrix.c;
						currentTweenData._matrix.d = tweenData[i].transformMatrix.d;
						currentTweenData._matrix.tx = tweenData[i].transformMatrix.tx;
						currentTweenData._matrix.ty = tweenData[i].transformMatrix.ty;*/
						
						currentTweenData.transform = { }; currentTweenData.transform.matrix = { };
						currentTweenData.transform.matrix.a = tweenData[i].transformMatrix.a;
						currentTweenData.transform.matrix.b = tweenData[i].transformMatrix.b;
						currentTweenData.transform.matrix.c = tweenData[i].transformMatrix.c;
						currentTweenData.transform.matrix.d = tweenData[i].transformMatrix.d;
						currentTweenData.transform.matrix.tx = tweenData[i].transformMatrix.tx;
						currentTweenData.transform.matrix.ty = tweenData[i].transformMatrix.ty;
					}
					//Visibility fallback check for first tween. Assume that it is to be visible if there was no visible property specified.
					if (i == 0)
					{
						if (!("visible" in tweenData[i]))
						{
							currentTweenData.visible = 1.0;
							//tweens[tweens.length] = BetweenAS3.func(ChangeSpriteVisibility, [target, true]);
							var tween:IObjectTween = BetweenAS3.to(target, { visible: 1.0 }, 0, Linear.linear);
							tweens[tweens.length] = tween;
							previousTweenData = currentTweenData;
							//currentTweenData["visible"]
							//currentTweenData.visible = true;
						}
					}
					
					if ("visible" in tweenData[i])
					{
						currentTweenData.visible = Number(tweenData[i].visible);
					}
					
					if ("duration" in tweenData[i])
					{
						duration = tweenData[i].duration;
						//currentTweenData.duration = null; //Remove duration from tween data so it can be passed used for the tween's var property
					}
					else
					{
						duration = 0;
					}
					
					
					
					if (!("transformMatrix" in tweenData[i]))
					{
						currentTweenData["$x"] = 0;
						currentTweenData["$y"] = 0;
					}
					if (duration)
					{
						//timeline.to(target, duration * TIME_PER_FRAME, currentTweenData);
						var tween:IObjectTween = BetweenAS3.tween(target, currentTweenData, previousTweenData, duration * TIME_PER_FRAME, Linear.linear);
						if ("visible" in currentTweenData || "visible" in previousTweenData)
						{
							var bp:int = 5;
						}
						tweens[tweens.length] = tween;
						// time scaled
						//tweens[tweens.length] = BetweenAS3.scale(BetweenAS3.tween(target, currentTweenData, previousTweenData, duration * TIME_PER_FRAME, Linear.linear), 10);
					}
					else //duration is 0, so tween is to be set instantly.
					{
						//timeline.set(target, currentTweenData);
						var tween:IObjectTween = BetweenAS3.to(target, currentTweenData, 0, Linear.linear);
						tweens[tweens.length] = tween;
					}
					
					/*if ("visible" in tweenData[i])
					{
						var visValue:Number = tweenData[i].visible;
						var visObj:Object = new Object;
						visObj["visible"] = visValue;
						var tween:IObjectTween = BetweenAS3.to(target, visObj, 0, Linear.linear);
						tweens[tweens.length] = tween;
						//previousTweenData = currentTweenData;
						//currentTweenData["visible"] = Number(tweenData[i].visible);
						//tweens[tweens.length] = BetweenAS3.func(ChangeSpriteVisibility, [target, tweenData[i].visible]);
						/*if (target.name == "EyelidL")
					{
						trace("tween #" + i +", type: " + getQualifiedClassName(tweens[tweens.length-1]) + ", position: " + tweens[tweens.length-1].position + ", duration: " + tweens[tweens.length-1].duration);
					}*/
					//}
					/*if (track)
					{
						totalDuration += duration;
						trace("Finished reading tween data " + i + ", duration is at " + totalDuration);
					}*/
					
					previousTweenData = currentTweenData;
				}
				
				timeline = BetweenAS3.serialTweens(tweens) as SerialTween;
			}
			//trace("Created timeline for " + target.name + ".\tDuration:" + timeline.duration);
			//var tlDur:Number = timeline.duration();
			//if (tlDur > 4.0)
			//{
				//varn:Number = Math.round(timeline.duration()/TIME_PER_FRAME)*TIME_PER_FRAME;
				//timeline.duration(RoundToNearest( TIME_PER_FRAME,timeline.duration()) - 0.1);
				//var bp:int = 5;
			//}
			//trace("Duration: " + timeline.duration());
			return timeline;
			
		}
		
		public function Update():Number
		{
			var position:Number = Number.NaN;
			if (animationPaused == false && masterTimeline) //If animation isn't paused, update
			{
				var currentTime:Number = masterTimeline.position;
				//trace("Frame " + int(120*(currentTime/masterTimeline.duration)));
				var displayLayout:AnimationLayout = currentAnimationElementDepthLayout;
				//Start at the end and work backwards
				for (var i:int = displayLayout.frameVector.length -1; i >= 0; --i)
				{
					var frameLayout:LayoutFrameVector = displayLayout.frameVector[i];
					if (currentTime >= frameLayout.changeTime)
					{
						latestFrameDepthLayout = frameLayout;
						ChangeElementDepths(frameLayout, true);
						break; //Break out the for loop
					}
				}
				//position = masterTimeline.position;
			}
			if (masterTimeline)
			{
				position = masterTimeline.position;
			}
			return position;
		}
		
		//public function ChangeAnimation(displayLayout:Object, animationId:int, charId:int=-1, replaceSetName:String="Standard"):void
		public function ChangeAnimation(displayLayout:AnimationLayout, animationId:int, charId:int=-1, replaceSetName:String="Standard"):void
		{
			//var timer:int = getTimer();
			//set the element depth layout for the animation
			elementLayoutChangeTimes.length = 0;
			/*for(var index:String in displayLayout)
			{
				elementLayoutChangeTimes[elementLayoutChangeTimes.length] = Number(index);
			}*/
			for (var index:int = 0, l:int = displayLayout.frameVector.length; i < l; ++i)
			{
				elementLayoutChangeTimes[elementLayoutChangeTimes.length] = displayLayout.frameVector[index].changeTime;
			}
			currentAnimationElementDepthLayout = displayLayout;
			//trace("Change layout completed in " + (getTimer() - timer));
			//timer = getTimer();
			//Get timelines that will be added
			var timelines:Vector.<SerialTween> = null;// timelineLib.GetBaseTimelinesFromLibrary(animationId);
			if (timelines)
			{
				AddTimelines(timelines);
			}
			//trace("Add base timelines completed in " + (getTimer() - timer));
			//timer = getTimer();
			/*if (timelineLib.DoesCharacterSetExists(animationId, charId, replaceSetName))
			{
				AddTimelines(timelineLib.GetReplacementTimelinesToLibrary(animationId, charId, replaceSetName));
			}	*/
			//trace("Add replacement timelines completed in " + (getTimer() - timer));
			//trace("animation duration: " + masterTimeline.duration());
			//timer = getTimer();
			//Cause a change to the depth of the elements
			var currentTime:Number = masterTimeline.position;
			//var layoutChangeTime:Number;
			//Start at the end and work backwards
			for (var i:int = displayLayout.frameVector.length -1; i >= 0; --i)
			{
				var frameLayout:LayoutFrameVector = displayLayout.frameVector[i];
				if (currentTime >= frameLayout.changeTime)
				{
					//latestIndexOfLayoutChangeUsed = i;
					latestFrameDepthLayout = frameLayout;
					ChangeElementDepths(frameLayout);
					break; //Break out the for loop
				}
			}
			/*for (var i:int = elementLayoutChangeTimes.length - 1; i >= 0; --i)
			{
				layoutChangeTime = elementLayoutChangeTimes[i];

				if (currentTime >= layoutChangeTime)
				{
					latestFrameDepthLayout = currentAnimationElementDepthLayout[elementLayoutChangeTimes[i]];
					ChangeElementDepths(latestFrameDepthLayout);
					break; //Break out the for loop
				}
			}*/
			//trace("Depth sort and change completed in "+(getTimer() - timer));
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
		//final public function ChangeElementDepths(depthLayout:Object):void
		final public function ChangeElementDepths(depthLayout:LayoutFrameVector, justRearranging:Boolean = false):void
		{
			/*if (justRearranging)
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
					if (container.parent == this)
					{
						this.removeChild(container);
					}
				}
			}
			else
			{
				this.removeChildren();
			}*/
			this.removeChildren();
			
			for (var i:int = 0, l:int = containers.length; i < l; i++) 
			{
				containers[i].removeChildren();
			}
			var layoutVector:Vector.<DispObjInfo> = depthLayout.dispInfo;// .layoutVector;
			var latestElement:Sprite = null;
			var latestMaskedContainer:Sprite = null;
			//var currentElement:Sprite;
			//var depth:Number;
			//var timeline:SerialTween;
			//var currentElementName:String;
			//time = getTimer();
			
			//Unoptimized version
			for (var vecIndex:int = 0, vecLength:int = layoutVector.length; vecIndex < vecLength; ++vecIndex )
			{
				var element:Sprite = elementDict[layoutVector[vecIndex].GetControlObjectName()];
				if (element)
				{
					var flag:int = layoutVector[vecIndex].GetTargetFlag();
					
					if (flag == 0)
					{
						addChild(element);
						latestElement = element;
						if (latestMaskedContainer != null)
						{
						latestMaskedContainer = null;
						}
					}
					else
					{
						var targetElement:Sprite = elementDict[layoutVector[vecIndex].GetTargetObjName()];
						if (targetElement)
						{
							if (flag == 1)
							{
								targetElement.addChild(element);
								latestMaskedContainer = null;
								containers.push(targetElement);
							}
							else if (flag == 2)
							{
								if (latestMaskedContainer == null)
								{
									latestMaskedContainer = new Sprite();
									this.addChild(latestMaskedContainer);
									latestMaskedContainer.mask = targetElement;
									containers.push(latestMaskedContainer);
									//targetElement.mask = latestMaskedContainer;
								}
								latestMaskedContainer.addChild(element);
								
							}
						}
					}
				}
			}
			
			/*for (var vecIndex:int = 0, vecLength:int = layoutVector.length; vecIndex < vecLength; ++vecIndex )
			{
				var element:Sprite = layoutVector[vecIndex].element;
				if (element == null) { element = this[layoutVector[vecIndex].expectedElementName]; }
				if (element != null)
				{
					depth = layoutVector[vecIndex].depth;
					if (depth % 1 == 0)
					{
						latestElement = element;
						this.addChild(element);
						//setChildIndex(latestElement, numChildren - 1);
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
						latestMaskedContainer.addChild(element);
					}
					//timeline = elementTimelineDict[element] as TimelineLite;
					//if (timeline && !timeline.isActive())
					//{
						//timeline.seek(0);
						//timeline.play(masterTimeline.time());
					//}
				}
			}*/
			//trace("\t\tFinalization complete time(ms): " + (getTimer() - time));
			//End experimental code
			
			
		}
		
		public function ChangePlaySpeed(speed:Number):void
		{
			//masterTimeline.//timeScale(speed);
		}
		
		//Starts playing the currently set animation at a specified time in seconds.
		public function PlayAnimation(startTime:Number):void
		{
			if (startTime == -1)
			{
				startTime = masterTimeline.position;
			}
			if (animationPaused) { animationPaused = false; }
			masterTimeline.stopOnComplete = false;	
			masterTimeline.gotoAndPlay(startTime);
			
			
			//Get all timelines currently used
			//elementTimelineDict
			/*var childTimelines:Array = masterTimeline.getTweenAt//getChildren(!true, false);
			for (var i:int = 0, l:int = childTimelines.length; i < l; ++i)
			{
				//Tell the child timeline to play at the specified time
				(childTimelines[i] as SerialTween).gotoAndPlay(startTime);
			}*/
		}
		
		public function ResumePlayingAnimation():void
		{
			animationPaused = false;
			masterTimeline.stopOnComplete = false;
			masterTimeline.play();
			//Get all timelines currently used
			/*var childTimelines:Array = masterTimeline.getChildren(!true, false);
			for (var i:int = 0, l:int = childTimelines.length; i < l; ++i)
			{
				//Tell the child timeline to play at the specified time
				(childTimelines[i] as TimelineMax).play(frameCounter);
			}*/
		}
		
		public function JumpToPosition(time:Number):void
		{
				masterTimeline.gotoAndStop(time);
				/*var childTimelines:Array = masterTimeline.//getChildren(true, false);
				
				for (var i:int = 0, l:int = childTimelines.length; i < l; ++i)
				{
					//(childTimelines[i] as SerialTween).seek(frame);
					(childTimelines[i] as SerialTween).gotoAndPlay(frame*(1.0/this.stage.frameRate));
				}*/
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
			var timelines:Vector.<SerialTween> = null;// timelineLib.GetBaseTimelinesFromLibrary(animationIndex);
			if (timelines)
			{
				/*if (clearCurrentTimelines)
				{
					masterTimeline.//clear();
				}*/
				AddTimelines(timelines);
			}
		}
		
		public function CompileAnimation(shards:Vector.<AnimateShard>):void
		{
			var timelines:Array = new Array;
			var shardTimelines:Vector.<SerialTween>;
			var shardDispObjInfoVector:Vector.<DispObjInfo>;
			var finalizedLayout:Object = new Object();
			
			//var deferredDispInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
			for (var i:int = 0, l:int = shards.length; i < l; i++) 
			{
				shardTimelines = shards[i].GetTimelines();
				for (var j:int = 0, k:int = shardTimelines.length; j < k; j++) 
				{
					if (shardTimelines[j] != null)
					{
						timelines[timelines.length] = shardTimelines[j];
					}
				}
				
				shardDispObjInfoVector = shards[i].GetDispObjData();
				var shardDispInfo:DispObjInfo;
				if (shardDispObjInfoVector != null)
				{
					for (var m:int = 0, n:int = shardDispObjInfoVector.length; m < n; m++) 
					{
						shardDispInfo = shardDispObjInfoVector[m];
						//Get the time that this disp obj info is used for.
						var time:String = String(shardDispInfo.GetStartTime()) 
						if (!(time in finalizedLayout) )
						{
							finalizedLayout[time] = new Vector.<DispObjInfo>();
						}
						finalizedLayout[time].push(shardDispInfo);
						
						//finalizedLayout[time][shardDispInfo.GetControlObjectName()] = (shardDispInfo.GetTargetFlag() < 2) ? shardDispInfo.GetDepth() : ModifyDepthDataBasedOnTargetFlag(shardDispInfo.GetDepth(), shardDispInfo.GetTargetFlag());
						
					}
				}
			}
			//Need to complete the display object layout for the animation
			ProcessDisplayObjects(finalizedLayout);
			currentAnimationElementDepthLayout = new AnimationLayout();
			for (var timeAsStr:String in finalizedLayout) 
			{
				currentAnimationElementDepthLayout.AddNewFrameVector(Number(timeAsStr), finalizedLayout[timeAsStr]);
			}
			var compiledAnimation:ParallelTween = BetweenAS3.parallelTweens(timelines) as ParallelTween;
			masterTimeline = compiledAnimation;
			masterTimeline.gotoAndPlay(0.0);
		}
		
		private function ProcessDisplayObjects(dispObjContainer:Object):void
		{
			//Received an object with vectors of dispobjinfo instances. There are possibly multiple instances that will overwrite each other. 
			for (var time:String in dispObjContainer) 
			{
				//The raw vector of dispObjInfo objects for a particular time of the animation.
				var dispObjDataForTimePoint:Vector.<DispObjInfo> = dispObjContainer[time];
				
				//The vector with the end result, which will be sorted by depth. Any dispobjinfo that are to have its controlDispObj be masked or added as a child will be place at the end of the 
				var sortedDispObjInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
				var deferredDispObjInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
				var overwriteTracker:Dictionary = new Dictionary();
				
				for (var i:int = 0, l:int = dispObjDataForTimePoint.length; i < l; i++) 
				{
					if (dispObjDataForTimePoint[i].GetTargetFlag() == 0) // For normal behavior
					{
						var controlName:String = dispObjDataForTimePoint[i].GetControlObjectName();
						var dispInfoIndex:int = 0;
						if (controlName in overwriteTracker)
						{
							//replace the old index that had the dispobjinfo for the control object.
							sortedDispObjInfo[overwriteTracker[controlName]] = dispObjDataForTimePoint[i];
							
						}
						else
						{
							dispInfoIndex = sortedDispObjInfo.length;
							sortedDispObjInfo[dispInfoIndex] = dispObjDataForTimePoint[i];
						}
						overwriteTracker[controlName] = dispInfoIndex;
					}
					else //For masked or child behavior
					{
						deferredDispObjInfo[deferredDispObjInfo.length] = dispObjDataForTimePoint[i];
					}
					
				}
				
				//Handle the deferredDispObjs
				var deferredLength:int = deferredDispObjInfo.length;
				for (var j:int = 0; j < deferredLength; j++) 
				{
					var targetName:String = deferredDispObjInfo[j].GetTargetObjName();
					if (targetName in overwriteTracker)
					{
						trace(targetName + sortedDispObjInfo[overwriteTracker[targetName]].GetDepth());
						deferredDispObjInfo[j].SetTargetDepth(sortedDispObjInfo[overwriteTracker[targetName]].GetDepth());
						sortedDispObjInfo[sortedDispObjInfo.length] = deferredDispObjInfo[j];
					}
					//deferredDispObjInfo[j] = null;
				}
				
				//Need to sort the dispobjinfo by depth.
				SortDispObjInfoVector(sortedDispObjInfo);
				dispObjContainer[time] = sortedDispObjInfo;
				//trace("Finished sort");
				
				//Need to find the dispObj with a depth of 0 and flag of 0.
				/*for (var name:String in overwriteTracker) 
				{
					var startPointDispInfo:DispObjInfo = (overwriteTracker[name] as DispObjInfo);
					if (startPointDispInfo.GetDepth() == 0 && startPointDispInfo.GetTargetFlag() == 0)
					{
						sortedDispObjInfo[sortedDispObjInfo.length] = startPointDispInfo;
						delete overwriteTracker[name];
						break;
					}
				}*/
				//If a start point was found, then the 
				/*if (sortedDispObjInfo.length > 0)
				{
					
				}*/
				
			}
			
			
		}
		
		//Sorts a vector containing DispObjInfo by depth using the bottom-up merge sorting algorithm.
		private function SortDispObjInfoVector(vector:Vector.<DispObjInfo>):void
		{
			var length:int = vector.length;
			var tmpVector:Vector.<DispObjInfo> = new Vector.<DispObjInfo>(length);
			for (var width:int = 1; width < length; width = 2 * width) 
			{
				for (var i:int = 0; i < length; i = i + 2 * width)
				{
					Merge(vector, i, Math.min(i + width, length), Math.min(i + 2 * width, length), tmpVector);
				}
				
				for (var j:int = 0; j < length; j++) 
				{
					vector[j] = tmpVector[j];
				}
			}
		}
		
		private function Merge(A:Vector.<DispObjInfo>, begin:int, mid:int, end:int, B:Vector.<DispObjInfo>)
		{
			var i:int = begin, j:int = mid;
			for (var k:int = begin; k < end; k++) 
			{ 
				if (i < mid && (j >= end || CompareDispObjInfoDepths(A[i], A[j]) == 0))
				{
					B[k] = A[i];
					i = i + 1;
				}
				else
				{
					B[k] = A[j];
					j = j + 1;
				}
			}
		}
		
		
		//Compares 2 dispObjInfo instances and returns an int to indicate which info object should be moved. Returns 0 when info1 should be moved and returns 1 when info 2 should be moved.
		private function CompareDispObjInfoDepths(info1:DispObjInfo, info2:DispObjInfo):int
		{
			if (info1.GetTargetFlag() > 0 || info2.GetTargetFlag() > 0) //Target is to be masked or be a child
			{
				if (info1.GetTargetFlag() == info2.GetTargetFlag()) //Need to check both depth and target depth
				{
					if (info1.GetTargetDepth() == info2.GetTargetDepth()) //Check depth since the target depth is the same
					{
						if (info1.GetDepth() <= info2.GetDepth())
							{return 0;}
						else
							{return 1;}
					}
					else //Target depths are different, so sort by that.
					{
						if (info1.GetTargetDepth() <= info2.GetTargetDepth())
							{return 0;}
						else
							{return 1;}
					}
				}
				else if(info1.GetTargetFlag() > 0 && info2.GetTargetFlag() == 0) //Compared info1 target depth to info2's depth
				{
					if (info1.GetTargetDepth() <= info2.GetDepth())
						{return 0;}
					else
						{return 1;}
				}
				else if(info1.GetTargetFlag() == 0 && info2.GetTargetFlag() > 0) //Compared info2 target depth to info1's depth
				{
					if (info1.GetDepth() <= info2.GetTargetDepth())
						{return 0;}
					else
						{return 1;}
				}
				else //Both have a flag > 0, sort by target depth since masking and setting a parent are incompatible
				{
					if (info1.GetTargetDepth() <= info2.GetTargetDepth())
					{return 0;}
				else
					{return 1;}
				}
			}
			else
			{
				if (info1.GetDepth() <= info2.GetDepth())
				{
					return 0;
				}
				else
				{
					return 1;
				}
			}
		}
		
		/*Removes all children timelines, which control the various body part elements of the master template, from the master timeline.
		 Additionally, these body part elements are set to be invisible. */
		public function ClearTimelines():void
		{
			//Get the timelines used currently
			/*var childTimelines:Array = masterTimeline.//getChildren(true, false);
			var currentChildTimeline:SerialTween;
			//Iterate through all the timelines 
			for (var i:int = 0, l:int = childTimelines.length; i < l; ++i)
			{
				currentChildTimeline = childTimelines[i] as SerialTween;
				//The element that the timeline controls is to become invisible.
				//TODO: Test if it is more efficient, performance wise, to remove the element from the master template.
				//(currentChildTimeline.data as DisplayObject).visible = false;
				(timelineControlElementDict[currentChildTimeline] as DisplayObject).visible = false;
			}
			//Remove the array of timelines from the master timeline, leaving it clear for another animation.
			masterTimeline.;*/
		}
		
		//Adds the timelines contained in a vector to the master timeline.
		[Inline]
		final public function AddTimelines(timelinesToAdd:Vector.<SerialTween>):void
		{
			//Current way of handling when a replacement timeline doesn't exist. Works poorly by keeping the default.
			if (timelinesToAdd == null || timelinesToAdd.length == 0)
			{
				return;
			}
			var tlToAdd:SerialTween;
			var timelineDisplayObject:DisplayObject;
			var childTimeline:SerialTween;
			
			//reset the arrays involved used by this function in a way that it won't invoke an allocation or allow for garbage collection
			timelinesPendingRemoval.length = 0;
			timelinesOkForAdding.length = 0;
			
			masterTimeline = BetweenAS3.parallelTweens(ConvertVectorToArray(timelinesToAdd)) as ParallelTween;
			//masterTimeline.stopOnComplete = false;
			masterTimeline.play();
			//var addTimer:int = getTimer();
			var mtlTime:Number = masterTimeline.position;
			var eleTlDict:Dictionary = elementTimelineDict;
			for (var i:uint = 0, l:uint = timelinesToAdd.length; i < l; ++i)
			{
				tlToAdd = timelinesToAdd[i];
				//If the timeline to add is null, return out the function.
				if (tlToAdd != null) 
				{
					//The display object that the timeline controls
					//timelineDisplayObject = tlToAdd.data as DisplayObject;
					timelineDisplayObject = timelineControlElementDict[tlToAdd];
					//Check to see if the master timeline already has a nested timeline for the specified display object.
					//If it does, then replace it. Otherwise, add it.
					
					//Optimized version
					//Get timeline from the elementTimelineDict.
					childTimeline = eleTlDict[timelineDisplayObject] as SerialTween;
					//Remove old timeline for element if needed
					if (childTimeline && childTimeline != tlToAdd)
					{
						timelinesPendingRemoval[timelinesPendingRemoval.length] = childTimeline;
					}
					/*TODO:While necessary for visual correctness, the below line of code can take around 45 ms to execute. Find a way
					 * to indicate which timeline is used for an element without resorting to the dictionary or object class.*/
					eleTlDict[timelineDisplayObject] = tlToAdd;

				}
				
			}

			
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
		
		/*public function SetElementDepthLayout(layout:Object):void
		{
			//reset array
			elementLayoutChangeTimes.length = 0;
			for(var index:String in layout)
			{
				elementLayoutChangeTimes[elementLayoutChangeTimes.length] = index;
			}
			//currentAnimationElementDepthLayout = layout;
		}*/
		
		
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
			
			//unoptimized
			var element:Sprite;
			for (var i:int = 0; i < this.numChildren; i++) 
			{
				element = this.getChildAt(i) as Sprite;
				elementDict[element.name] = element;
			}
			
			this.removeChildren();
			
			removeEventListener(Event.ADDED_TO_STAGE, TemplateAddedToStage);
		}
		public function GetPPPPU_Stage():PPPPU_Stage
		{
			return m_ppppuStage;
		}
		[Inline]
		final public function RoundToNearest(roundTo:Number, value:Number):Number{
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
			return masterTimeline.duration;
		}
		
		public function GetTimeInCurrentAnimation():Number
		{
			return masterTimeline.position;
		}
		
		function ConvertVectorToArray(vector:Vector.<SerialTween>):Array
		{
			var array:Array =[];
			for (var i:int = 0; i < vector.length; ++i)
			{
				array[i] = vector[i];
			}
			return array;
		}
		
		private function ChangeSpriteVisibility(target:DisplayObject, visible:Boolean):void
		{
			target.visible = visible;
		}
		
		private function LoopAnimation(e:TweenEvent):void
		{
			masterTimeline.gotoAndPlay(0);
		}
	}

}