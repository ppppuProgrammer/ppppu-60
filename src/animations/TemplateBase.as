package animations 
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
	import animations.AnimationLayout;
	import animations.LayoutFrameVector;
	import animations.LayoutRecord;
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
		//public var baseAnimationTweens:ParallelTween;
		//public var additionalAnimationTweens:ParallelTween;
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
		
		private var latestFrameDepthChangeTime:Number =-1;
		private var nextFrameDepthChangeTime:Number=-1;
		
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
		
		private var containers:Vector.<Sprite> = new Vector.<Sprite>();
		
		/* Creation and Initialization */
		//{
		public function TemplateBase()
		{
			//Create some layers that will be what hair and accessories are typically placed into.
			/*var layer1:Sprite = new Sprite();
			var layer2:Sprite = new Sprite();
			var layer3:Sprite = new Sprite();
			var layer4:Sprite = new Sprite();*/
			AddNewSpriteInstance(new Sprite, "HairFrontLayer");
			AddNewSpriteInstance(new Sprite, "HairBehindFaceLayer");
			AddNewSpriteInstance(new Sprite, "HairBehindHeadwearLayer");
			AddNewSpriteInstance(new Sprite, "HairBackLayer");
			//addChild(); addChild(); addChild(); addChild();
			addEventListener(Event.ADDED_TO_STAGE, TemplateAddedToStage);
		}
		
		public function Initialize(shardLibrary:AnimateShardLibrary/*timelineLibrary:TimelineLibrary*/):void
		{
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
			
			//Adds any child display objects into the element dictionary. Unoptimized and display objects ideally would not be children of the template base in the first place.
			var element:Sprite;
			for (var i:int = 0; i < this.numChildren; i++) 
			{
				element = this.getChildAt(i) as Sprite;
				elementDict[element.name] = element;
			}
			
			this.removeChildren();
			
			removeEventListener(Event.ADDED_TO_STAGE, TemplateAddedToStage);
		}
		//}
		/* End of Creation and Initialization */
		
		public function CreateTimelineFromData(timelineData:Object, displayObjContainingTarget:Sprite):SerialTween
		{
			var tweenData:Vector.<Object> = timelineData.tweenProperties;
			var TIME_PER_FRAME:Number = timelineData.TIME_PER_FRAME;
			var target:Sprite = elementDict[timelineData.targetName] as Sprite;
			var timeline:SerialTween = null;
			var currentTweenData:Object, previousTweenData:Object;
			if (target)
			{
				var tweens:Array = new Array();
				timelineControlElementDict[timeline] = target;
				
				var duration:int;

				for (var i:int = 0, l:int = tweenData.length; i < l; ++i)
				{
					currentTweenData = { };
					//currentTweenData = tweenData[i];
					if ("transformMatrix" in tweenData[i])
					{						
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
							var tween:IObjectTween = BetweenAS3.to(target, { visible: 1.0 }, 0, Linear.linear);
							tweens[tweens.length] = tween;
							previousTweenData = currentTweenData;
						}
					}
					
					if ("visible" in tweenData[i])
					{
						currentTweenData.visible = Number(tweenData[i].visible);
					}
					
					if ("duration" in tweenData[i])
					{
						duration = tweenData[i].duration;
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
						tweens[tweens.length] = tween;
					}
					else //duration is 0, so tween is to be set instantly.
					{
						var tween:IObjectTween = BetweenAS3.to(target, currentTweenData, 0, Linear.linear);
						tweens[tweens.length] = tween;
					}
					
					previousTweenData = currentTweenData;
				}
				
				timeline = BetweenAS3.serialTweens(tweens) as SerialTween;
			}
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

				if (displayLayout.frameVector.length > 0 && (latestFrameDepthChangeTime == -1 || (currentTime >= nextFrameDepthChangeTime && nextFrameDepthChangeTime >= 0) ) )
				{
					var frameLayout:LayoutFrameVector;
					//Start at the end and work backwards
					for (var i:int = 0, l:int = displayLayout.frameVector.length; i < l; ++i)
					{
						frameLayout = displayLayout.frameVector[i];
						latestFrameDepthChangeTime = frameLayout.changeTime;
						//There's more frame vectors to examine. Check if the next frame vector has a change time greater than the current time of the animation.
						if (i + 1 < l && currentTime < displayLayout.frameVector[i + 1].changeTime)
						{
							nextFrameDepthChangeTime = displayLayout.frameVector[i+1].changeTime;
							break;
						}
						else if(i + 1 == l) //Reached the end of the layout vector.
						{
							if (l == 1)//There is only 1 change for the animation, so don't worry about it anymore.
							{
								nextFrameDepthChangeTime = -1; 
							}
							else
							{
								//Loop back to beginning if there were multiple times where element depths were changed but we reached the last point in the animation where a change will happen.
								nextFrameDepthChangeTime = displayLayout.frameVector[0].changeTime;
							}
							break;
						}
					}
					ChangeElementDepths(frameLayout, true);
				}
				else if (displayLayout.frameVector.length == 0 && masterTimeline != null)
				{
					this.removeChildren();
					masterTimeline = null;
				}
				//position = masterTimeline.position;
			}
			if (masterTimeline)
			{
				position = masterTimeline.position;
			}
			return position;
		}
		
		public function AddNewSpriteInstance(sprite:Sprite, spriteName:String):Boolean
		{
			var result:Boolean;
			if (spriteName in elementDict)
			{
				//Sprite with same name was already added.
				result = false;
			}
			else
			{
				sprite.name = spriteName;
				sprite.mouseChildren = sprite.mouseEnabled = false;
				elementDict[spriteName] = sprite;
				result = true;
			}
			return result;
		}
		
		//public function ChangeAnimation(displayLayout:Object, animationId:int, charId:int=-1, replaceSetName:String="Standard"):void
		/*public function ChangeAnimation(displayLayout:AnimationLayout, animationId:int, charId:int=-1, replaceSetName:String="Standard"):void
		{
			//var timer:int = getTimer();
			//set the element depth layout for the animation
			elementLayoutChangeTimes.length = 0;

			for (var index:int = 0, l:int = displayLayout.frameVector.length; i < l; ++i)
			{
				elementLayoutChangeTimes[elementLayoutChangeTimes.length] = displayLayout.frameVector[index].changeTime;
			}
			currentAnimationElementDepthLayout = displayLayout;
			if (timelines)
			{
				AddTimelines(timelines);
			}
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
								}
								latestMaskedContainer.addChild(element);
								
							}
						}
					}
				}
			}			
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
		}
		
		public function ResumePlayingAnimation():void
		{
			animationPaused = false;
			masterTimeline.stopOnComplete = false;
			masterTimeline.play();
		}
		
		public function JumpToPosition(time:Number):void
		{
				masterTimeline.gotoAndStop(time);
		}
		
		/*Pauses the animation. Currently used, it's just here in case there is a time where the animation needs to be paused. 
		Might be useful when character editing facilities are better and they need a still to look at.*/
		public function StopAnimation():void
		{
			animationPaused = true;
			masterTimeline.stop();
		}
		
		/* Animation Creation Functions */
		//{
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
				elementLayoutChangeTimes[elementLayoutChangeTimes.length] = Number(timeAsStr);
			}

			if (masterTimeline)
			{
				masterTimeline.stop();
				masterTimeline = null;
			}
			var compiledAnimation:ParallelTween = BetweenAS3.parallelTweens(timelines) as ParallelTween;
			if (masterTimeline && masterTimeline.isPlaying)
			{
				masterTimeline.stop();
			}
			masterTimeline = compiledAnimation;	
			latestFrameDepthChangeTime = nextFrameDepthChangeTime = -1;
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
						//trace(targetName + sortedDispObjInfo[overwriteTracker[targetName]].GetDepth());
						deferredDispObjInfo[j].SetTargetDepth(sortedDispObjInfo[overwriteTracker[targetName]].GetDepth());
						sortedDispObjInfo[sortedDispObjInfo.length] = deferredDispObjInfo[j];
					}
					//deferredDispObjInfo[j] = null;
				}
				
				//Need to sort the dispobjinfo by depth.
				SortDispObjInfoVector(sortedDispObjInfo);
				dispObjContainer[time] = sortedDispObjInfo;				
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
		
		private function Merge(A:Vector.<DispObjInfo>, begin:int, mid:int, end:int, B:Vector.<DispObjInfo>):void
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
		
		
		//Compares 2 dispObjInfo instances and returns an int to indicate which info object should be moved for the merge sort. Returns 0 when info1 should be moved and returns 1 when info 2 should be moved.
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
		//}
		/* End of Animation Creation Functions */
		
		
		public function GetPPPPU_Stage():PPPPU_Stage
		{
			return m_ppppuStage;
		}
		[Inline]
		final public function RoundToNearest(roundTo:Number, value:Number):Number{
		return Math.round(value/roundTo)*roundTo;
		}
		
		public function GetDurationOfCurrentAnimation():Number
		{
			if (!masterTimeline) { return Number.NaN; }
			return masterTimeline.duration;
		}
		
		public function GetTimeInCurrentAnimation():Number
		{
			return masterTimeline.position;
		}
		
		/*private function ConvertVectorToArray(vector:Vector.<SerialTween>):Array
		{
			var array:Array =[];
			for (var i:int = 0; i < vector.length; ++i)
			{
				array[i] = vector[i];
			}
			return array;
		}*/
		
		/*private function ChangeSpriteVisibility(target:DisplayObject, visible:Boolean):void
		{
			target.visible = visible;
		}*/
		
		private function LoopAnimation(e:TweenEvent):void
		{
			masterTimeline.gotoAndPlay(0);
		}
	}

}