package animations 
{
	import animations.AnimateShardLibrary;
	import animations.DispObjInfo;
	import animations.TimelineLibrary;
	import flash.geom.ColorTransform;
	import org.libspark.betweenas3.BetweenAS3;
	import org.libspark.betweenas3.core.easing.IEasing;
	import org.libspark.betweenas3.core.tweens.ObjectTween;
	import org.libspark.betweenas3.core.tweens.groups.SerialTween;
	import org.libspark.betweenas3.core.tweens.groups.ParallelTween;
	import org.libspark.betweenas3.easing.*;
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
	import flash.utils.getDefinitionByName;
	//import EyeContainer;
	//import MouthContainer;
	/**
	 * Sprite subclass that handles manipulating sprites to compose an animation using tween data.
	 * @author 
	 */
	public class Canvas extends Sprite
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
		//private var elementLayoutChangeTimes:Array = [];
		//private var latestIndexOfLayoutChangeUsed:int = -1;
		//How far into the current animation we're in
		//private var frameCounter:int = 0;
		//The total number of frames in the current animation.
		//TODO: allow this to be set, which is needed for animations with non-standard frames(not 120)
		//private var currentAnimationTotalFrames:int = 120;
		
		private var latestDepthChangeTime:Number =-1;
		private var nextDepthChangeTime:Number=-1;
		
		private var latestAnimationDuration:Number;
		
		private var currentAnimationName:String;
		
		//The primary movie clip for the flash in terms as asset displaying.
		//private var m_ppppuStage:PPPPU_Stage;
		
		private var animationPaused:Boolean = false;
		
		//public var timelineLib:TimelineLibrary;
		public var shardLib:AnimateShardLibrary;
		
		public var maskedContainerIndexes:Vector.<Sprite> = new Vector.<Sprite>();
		
		//Class level arrays used during the AddTimelines function to prevent constant allocation/GC when the function is called.
		//private var timelinesPendingRemoval:Array = [];
		//private var timelinesPendingRemoval:Vector.<SerialTween> = new Vector.<SerialTween>();
		//private var timelinesOkForAdding:Array = [];
		/*Keeps track of what timeline is controlling what element. Used to avoid the getTweensOf call, which will allocate an array. 
		The element is the key and the timelinemax instance is the value.*/
		//private var elementTimelineDict:Dictionary = new Dictionary();
		
		//private var timelineControlElementDict:Dictionary = new Dictionary();
		
		//Holds the various Sprites that can be placed onto the canvas.
		private var elementDict:Dictionary = new Dictionary();
		private var actorDict:Dictionary = new Dictionary();
		private var containers:Vector.<Sprite> = new Vector.<Sprite>();
		

		//public var currentGraphicSets:Vector.<GraphicSet> = new Vector.<GraphicSet>();
		
		//private var disableActorsBasedOnGfxSetData:Vector.<DisableActorInfo> = new Vector.<DisableActorInfo>;
		//Holds assets that couldn't be added due to a missing actor. Array holds 2 values, the actor name and the asset data.
		private var assetsInStorage:Vector.<Array> = new Vector.<Array>;
		
		private var director:Director;
		
		//private var shardOverrideDataList:Vector.<Object> = new Vector.<Object>();
		
		/* Creation and Initialization */
		//{
		public function Canvas()
		{
			//Create some layers that will be what hair and accessories are typically placed into.
			/*var layer1:Sprite = new Sprite();
			var layer2:Sprite = new Sprite();
			var layer3:Sprite = new Sprite();
			var layer4:Sprite = new Sprite();*/
			//Add the layers that are intended for hair sprite use.
			AddNewSpriteInstance(new Sprite, "FrontLayer");
			AddNewSpriteInstance(new Sprite, "FrontHeadLayer");
			AddNewSpriteInstance(new Sprite, "FrontEarLayer");
			AddNewSpriteInstance(new Sprite, "BehindEarLayer");
			AddNewSpriteInstance(new Sprite, "BehindHeadLayer");
			AddNewSpriteInstance(new Sprite, "BackLayer");
			
			//Add the layers for eyes
			AddNewSpriteInstance(new Sprite, "LeftEyeLayer");
			AddNewSpriteInstance(new Sprite, "RightEyeLayer");
			
			//Add the layer for Mouth usage
			AddNewSpriteInstance(new Sprite, "MouthLayer");
			
			//Force the compilation of the easing classes so they can be used at runtime.
			Linear; Quadratic; Quad; Quart; Quartic; Custom; Back; Bounce; Circ; Circular;  Cubic; Elastic; Expo; Exponential; Physical; Quint; Quintic; Sine;
			/*AddNewActor("HairFrontLayer");
			AddNewActor("HairBehindFaceLayer");
			AddNewActor("HairBehindHeadwearLayer");
			AddNewActor("HairBackLayer");*/
		}
		
		public function Initialize(shardLibrary:AnimateShardLibrary, actorDirector:Director/*,timelineLibrary:TimelineLibrary*/):void
		{
			shardLib = shardLibrary;
			director = actorDirector;
			for (var i:int = 0, l:int = this.numChildren; i < l; ++i)
			{
				var child:Sprite = this.getChildAt(i) as Sprite;
				if (child)
				{
					child.mouseChildren = false;
					child.mouseEnabled = false;
					if (child is Actor)
					{
						AddActor(child as Actor);
					}
				}
			}
		}
		//}
		/* End of Creation and Initialization */
		
		private function GetActorByName(actorName:String):Sprite
		{
			if (actorName in actorDict)
			{
				return actorDict[actorName];
			}
			else
			{
				if (AddNewActor(actorName) == true)
				{
					return actorDict[actorName];
				}
			}
			return null;
		}
		
		public function CreateTimelineForActor(timelineData:Object):SerialTween
		{
			var target:Sprite = GetActorByName(timelineData.targetName);
			if (target == null)
			{
				return null;
			}
			return CreateTimelineFromData(timelineData, target);
		}
		
		public function CreateTimelineForSprite(timelineData:Object, displayObjContainingTarget:Sprite):SerialTween
		{
			//var targetName:String = timelineData.targetName;
			var target:Sprite = displayObjContainingTarget.getChildByName(timelineData.targetName) as Sprite;
			if (target == null)
			{
				return null;
			}
			return CreateTimelineFromData(timelineData, target);
		}
		
		protected function CreateTimelineFromData(timelineData:Object, target:Sprite):SerialTween
		{
			var tweenData:Vector.<Object> = timelineData.tweenProperties;
			var TIME_PER_FRAME:Number = timelineData.TIME_PER_FRAME;

			if (target == null)
			{
				return null;
			}
			//var target:Sprite = targetSprite;
			
			var timeline:SerialTween = null;
			var currentTweenData:Object, previousTweenData:Object;
			var currentEasing:IEasing;
			if (target)
			{
				var tweens:Array = new Array();
				//timelineControlElementDict[timeline] = target;
				
				var duration:int;

				for (var i:int = 0, l:int = tweenData.length; i < l; ++i)
				{
					currentTweenData = { };
					currentEasing = null;
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
					if ("colorTransform" in tweenData[i])
					{
						if ("brightness" in tweenData[i].colorTransform)
						{
							//Not handling this yet. NYI.
							delete tweenData[i].colorTransform;
						}
						else
						{
							currentTweenData.transform.colorTransform = tweenData[i].colorTransform;
						}
					}
					
					if ("easing" in tweenData[i])
					{
						var easeType:String = tweenData[i].easing["type"];
						var easeSubType:String = tweenData[i].easing["subtype"];
						
						var easeClass:Class;
						try
						{easeClass = getDefinitionByName("org.libspark.betweenas3.easing." + easeType) as Class;}
						catch (e:ReferenceError)
						{easeClass = null; }
						
						if (easeClass)
						{
							currentEasing = easeClass[easeSubType] as IEasing;
						}
					}
					
					if(currentEasing == null)
					{
						currentEasing = Linear.linear;
					}
					
					//Visibility fallback check for first tween. Assume that it is to be visible if there was no visible property specified.
					if (i == 0)
					{
						if (!("visible" in tweenData[i]))
						{
							currentTweenData.visible = 1.0;
							var tween:IObjectTween = BetweenAS3.to(target, { visible: 1.0 }, 0, currentEasing);
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
						var tween:IObjectTween = BetweenAS3.tween(target, currentTweenData, previousTweenData, duration * TIME_PER_FRAME, currentEasing);
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
		
		//Ran every frame to see if there are Sprites/Actors that need to be added/removed from the canvas and/or have their depths rearraigned 
		public function Update():Number
		{
			var position:Number = Number.NaN;
			if (animationPaused == false && masterTimeline) //If animation isn't paused, update
			{
				var currentTime:Number = masterTimeline.position;
				//Caching the depth orders for the compiled animation.
				var displayLayout:AnimationLayout = currentAnimationElementDepthLayout;

				//Checks to see if there are depth orders and then checks if the times for depth changes aren't set or that it's time to set the next depth orders.
				if (displayLayout.frameVector.length > 0 && (latestDepthChangeTime == -1 || (currentTime >= nextDepthChangeTime && nextDepthChangeTime >= 0) ) )
				{
					var frameLayout:LayoutFrameVector;
					//Iterate through the list of depth orders.
					for (var i:int = 0, l:int = displayLayout.frameVector.length; i < l; ++i)
					{
						frameLayout = displayLayout.frameVector[i];
						//Update the latest time a depth change happens.
						latestDepthChangeTime = frameLayout.changeTime;
						//There's more depth orders to examine. Check if the next depth order has a change time greater than the current time of the animation.
						if (i + 1 < l && currentTime < displayLayout.frameVector[i + 1].changeTime)
						{
							nextDepthChangeTime = displayLayout.frameVector[i+1].changeTime;
							break;
						}
						else if(i + 1 == l) //Reached the end of the layout vector.
						{
							if (l == 1)//There is only 1 change for the animation, so don't worry about the next depth change from here on out.
							{
								nextDepthChangeTime = -1; 
							}
							else
							{
								//Loop back to beginning if there were multiple times where element depths were changed but we reached the last point in the animation where a change will happen.
								nextDepthChangeTime = displayLayout.frameVector[0].changeTime;
							}
							break;
						}
					}
					//Finally change the depths
					ChangeElementDepths(frameLayout, true);
					//GraphicSetDisableActorCheck();
				}
				else if (displayLayout.frameVector.length == 0 && masterTimeline != null)
				{
					//If there is no display order data then there is no reason for anything to be on the canvas, remove all children. Check that the masterTimeline isn't null as this is an indicator that there are Sprites on the canvas.
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
		
		public function AddActor(actor:Actor):void
		{			
			actor.mouseChildren = actor.mouseEnabled = false;
			actorDict[actor.name] = actor;
			director.RegisterActor(actor);
			//See if there are any assets that tried to be added but couldn't since the actor didn't exist when they were loaded in.
			if (assetsInStorage.length > 0)
			{
				for (var i:int = 0, l:int = assetsInStorage.length; i < l; i++) 
				{
					if (assetsInStorage[i] != null && (assetsInStorage[i][0] as String) == actor.name)
					{
						actor.AddAsset(assetsInStorage[i][1] as AssetData);
						assetsInStorage[i] = null;							
					}
				}
			}
		}
		
		public function AddNewActor(actorName:String):Boolean
		{
			var result:Boolean;
			if (actorName in actorDict)
			{
				//Actor with same name was already added.
				result = false;
				
			}
			else
			{
				var actor:Actor = new Actor();
				actor.name = actorName;
				
				AddActor(actor);
				result = true;
				
			}
			return result;
		}
		
		public function AddAssetToActor(actorName:String, data:AssetData):void
		{
			var actor:Actor = actorDict[actorName];

			if (actor)
			{
				actor.AddAsset(data);
			}
			else
			{
				//Try to find an empty space in the vector
				for (var i:int = 0, l:int = assetsInStorage.length; i < l; i++) 
				{
					if (assetsInStorage[i] == null)
					{
						assetsInStorage[i] = [actorName, data];
						return;
					}
				}
				
				//If an empty space didn't exist, add to the end of the vector
				assetsInStorage[assetsInStorage.length] = [actorName, data];
			}
		}
		
		//Adds a new sprite to the canvas. This is typically called to add layers, which actors will be added to in order to simplify depth ordrering by grouping them together within the layer.
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
				actorDict[spriteName] = sprite;
				result = true;
			}
			return result;
		}
		
		public function ChangeGraphicSets(gfxSetList:Array):void
		{
			if (gfxSetList)
			{
				for (var i:int = 0, l:int = gfxSetList.length; i < l; i++) 
				{
					director.ChangeAssetForAllActorsBySetName(gfxSetList[i], true); 
				}
			}
			
		}
		
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
			if (layoutVector == null) { return;}
			var latestElement:Sprite = null;
			var latestMaskedContainer:Sprite = null;
			
			//Unoptimized version
			for (var vecIndex:int = 0, vecLength:int = layoutVector.length; vecIndex < vecLength; ++vecIndex )
			{
				//var element:Sprite = elementDict[layoutVector[vecIndex].GetControlObjectName()];
				var element:Sprite = actorDict[layoutVector[vecIndex].GetControlObjectName()];
				if (element)
				{
					var flag:int = layoutVector[vecIndex].GetTargetFlag();
					
					if (flag == 0)
					{
						addChild(element);
						//Add an asset loaded from an asset mod into the actor. This is a horrible way of handling it but for alpha sake it is still done. Figure out a better way to handle this, even if it means solely using graphic sets.
						/*if (elementDict[layoutVector[vecIndex].GetControlObjectName()] != null)
						{
							(element as Actor).ChangeGraphicInLayer(1, elementDict[layoutVector[vecIndex].GetControlObjectName()]);
						}*/
						latestElement = element;
						if (latestMaskedContainer != null)
						{
						latestMaskedContainer = null;
						}
					}
					else
					{
						//var targetElement:Sprite = elementDict[layoutVector[vecIndex].GetTargetObjName()];
						var targetElement:Sprite = actorDict[layoutVector[vecIndex].GetTargetObjName()];
						if (targetElement)
						{
							if (flag == 1)
							{
								targetElement.addChild(element);
								/*if (elementDict[layoutVector[vecIndex].GetControlObjectName()] != null)
								{
									(element as Actor).ChangeGraphicInLayer(1, elementDict[layoutVector[vecIndex].GetControlObjectName()]);
								}*/
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
								/*if (elementDict[layoutVector[vecIndex].GetControlObjectName()] != null)
								{
									(element as Actor).ChangeGraphicInLayer(1, elementDict[layoutVector[vecIndex].GetControlObjectName()]);
								}*/
								
							}
						}
						else
						{
							trace(element.name + " could not find dependent Actor: " + layoutVector[vecIndex].GetTargetObjName());
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
			if (masterTimeline)
			{
				//masterTimeline.stopOnComplete = false;	
				masterTimeline.gotoAndPlay(startTime);
			}
		}
		
		public function ResumePlayingAnimation():void
		{
			if (masterTimeline != null)
			{
				animationPaused = false;
				//masterTimeline.stopOnComplete = false;
				masterTimeline.play();
			}
		}
		
		public function JumpToPosition(time:Number):void
		{
			if (masterTimeline)
			{
				masterTimeline.gotoAndStop(time);
			}
		}
		
		/*Pauses the animation. Currently used, it's just here in case there is a time where the animation needs to be paused. 
		Might be useful when character editing facilities are better and they need a still to look at.*/
		public function StopAnimation():void
		{
			if (masterTimeline != null)
			{
				animationPaused = true;
				masterTimeline.stop();
			}
		}
		
		public function ChangeActorAssetsUsingCharacterData(data:Object):void
		{
			if (data)
			{
				director.ChangeAssetForActorByCharData(data);
				/*for (var name:String in data ) 
				{
					for (var i:int = 0; i < 3; i++) 
					{
						director.ChangeAssetForActorByName(name, i, data[name][i]);
					}
					
				}*/
			}
		}
		
		public function ClearAllActors():void
		{
			director.ClearAllActors();
		}
		
		public function ChangeActorAssetsUsingSetNames(data:Object):void
		{
			var setList:Array = data as Array;
			if (setList)
			{
				for (var i:int = 0, l:int = setList.length; i < l; i++) 
				{
					director.ChangeAssetForAllActorsBySetName(setList[i] as String, true);
				}
			}
		}
		
		/* Animation Creation Functions */
		//{
		public function CompileAnimation(shards:Vector.<AnimateShard>, animationName:String):void
		{
			//shardOverrideDataList = new Vector.<Object>();
			if (currentAnimationName != animationName)
			{
				//Tell the director that the animation name has changed.
				director.UpdateAnimationInUse(animationName);
			}
			currentAnimationName = animationName;
			var timelines:Array = new Array;
			var shardTimelines:Vector.<SerialTween>;
			var shardDispObjInfoVector:Vector.<DispObjInfo>;
			var finalizedLayout:Object = new Object();
			
			//Iterate through the shards
			for (var i:int = 0, l:int = shards.length; i < l; i++) 
			{
				//Cache the timelines vector of the shard
				shardTimelines = shards[i].GetTimelines();
				//Iterate through the timelines
				for (var j:int = 0, k:int = shardTimelines.length; j < k; j++) 
				{
					//Make sure the timeline exists
					if (shardTimelines[j] != null)
					{
						//add the timeline from the shard to the array of timelines to compile.
						timelines[timelines.length] = shardTimelines[j];
					}
				}
				
				/*var overwriteData:Object = shards[i].GetOverrideData();
				if (overwriteData)
				{
					shardOverrideDataList[shardOverrideDataList.length] = overwriteData;
				}*/
				
				//Cache the disp obj info vector
				shardDispObjInfoVector = shards[i].GetDispObjData();
				var shardDispInfo:DispObjInfo;
				if (shardDispObjInfoVector != null)
				{
					//Iterate through the disp obj info vector
					for (var m:int = 0, n:int = shardDispObjInfoVector.length; m < n; m++) 
					{
						shardDispInfo = shardDispObjInfoVector[m];
						//Get the time that this disp obj info is used for.
						var time:String = String(shardDispInfo.GetStartTime());
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
			//Create the animation layout from the finalized layout
			currentAnimationElementDepthLayout = new AnimationLayout();
			for (var timeAsStr:String in finalizedLayout) 
			{
				currentAnimationElementDepthLayout.AddNewFrameVector(Number(timeAsStr), finalizedLayout[timeAsStr]);
				//elementLayoutChangeTimes[elementLayoutChangeTimes.length] = Number(timeAsStr);
			}

			if (masterTimeline)
			{
				masterTimeline.stop();
				masterTimeline = null;
			}
			//Create a parallel tween out of the timelines.
			var compiledAnimation:ParallelTween = BetweenAS3.parallelTweens(timelines) as ParallelTween;
			/*if (masterTimeline && masterTimeline.isPlaying)
			{
				masterTimeline.stop();
			}*/
			
			//ClearGraphicsFromAllActorsOnCanvas();
			//ApplyCurrentGraphicSets();
			//ApplyShardOverrides();
			
			masterTimeline = compiledAnimation;	
			//Reset the latest and next times for depth changes. -1 is used to indicate that the animation is being ran for the first time and should be checked.
			latestDepthChangeTime = nextDepthChangeTime = -1;
			//GraphicSetDisableActorCheck();
			//For testing purposes.
			//director.ChangeAssetForAllActorsBySetName("Standard");
			
			//masterTimeline.gotoAndStop(0.0);
		}
		
		private function ProcessDisplayObjects(dispObjContainer:Object):void
		{
			//Check if there are any dispobjinfo instances that indicate that the object is to be displayed for the entire animation and to not be removed if there if there are multiple times in the animation that depths will change.
			if ("-1" in dispObjContainer)
			{
				var noDepthChangeDispInfoObjs:Vector.<DispObjInfo> = dispObjContainer["-1"];
				delete dispObjContainer["-1"];
				for (var animTime:String in dispObjContainer)
				{
					var dispObjDataForAnimTime:Vector.<DispObjInfo> = dispObjContainer[animTime];
					//dispObjDataForAnimTime = dispObjDataForAnimTime.concat(noDepthChangeDispInfoObjs);
					for (var i:int = 0, l:int = noDepthChangeDispInfoObjs.length; i < l; i++) 
					{
						dispObjDataForAnimTime[dispObjDataForAnimTime.length] = noDepthChangeDispInfoObjs[i];
					}
				}
			}
			//Received an object with vectors of dispobjinfo instances. There are possibly multiple instances that will overwrite each other. 
			for (var time:String in dispObjContainer) 
			{
				//The raw vector of dispObjInfo objects for a particular time of the animation.
				var dispObjDataForTimePoint:Vector.<DispObjInfo> = dispObjContainer[time];
				
				//The vector with the end result, which will be sorted by depth. Any dispobjinfo that are to have its controlDispObj be masked or added as a child will be spliced into the main vector, sortedDispObjInfo
				var sortedDispObjInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
				//var deferredDispObjInfo:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
				var overwriteTracker:Dictionary = new Dictionary();
				
				//Temporary work vector used to remove dispObjInfo that will control the same display object.
				var duplicateWorkVector:Vector.<DispObjInfo> = new Vector.<DispObjInfo>();
				for (var i:int = 0, l:int = dispObjDataForTimePoint.length; i < l; i++) 
				{
					var controlName:String = dispObjDataForTimePoint[i].GetControlObjectName();
					var dispInfoIndex:int = 0;
					if (controlName in overwriteTracker)
					{
						//replace the old index that had the dispobjinfo for the control object.
						duplicateWorkVector[overwriteTracker[controlName]] = dispObjDataForTimePoint[i];
						
					}
					else
					{
						dispInfoIndex = duplicateWorkVector.length;
						duplicateWorkVector[dispInfoIndex] = dispObjDataForTimePoint[i];
					}
					overwriteTracker[controlName] = dispInfoIndex;
				}
				
				//All duplicates dispobjinfo have been removed. Now to sort the dispobjinfo, which will be put into a vector depending on what their target name is.
				var unsortedVectorDict:Dictionary = new Dictionary();
				
				for (var j:int = 0, k:int = duplicateWorkVector.length; j < k; j++) 
				{
					var targetName:String = duplicateWorkVector[j].GetTargetObjName();
					//There is no target for this dispobjinfo.
					if (targetName == null || targetName == "")
					{
						targetName = "_TOPLEVEL";	
					}
					
					if (unsortedVectorDict[targetName] == null)
					{
						unsortedVectorDict[targetName] = new Vector.<DispObjInfo>();
					}
					
					var vector:Vector.<DispObjInfo> = unsortedVectorDict[targetName] as Vector.<DispObjInfo>;
					vector[vector.length] = duplicateWorkVector[j];
				}
				
				//Sort all the vectors
				for (var name:String in unsortedVectorDict) 
				{
					var unsortedVector:Vector.<DispObjInfo> = unsortedVectorDict[name] as Vector.<DispObjInfo>;
					SortDispObjInfoVector(unsortedVector);
				}
				
				//Combine all the now sorted vectors into one. Start off with the top level one and then splice in the others
				var finalSortedVector:Vector.<DispObjInfo> = unsortedVectorDict["_TOPLEVEL"] as Vector.<DispObjInfo>;
				delete unsortedVectorDict["_TOPLEVEL"];

				for (var m:int = 0,n:int = finalSortedVector != null ? finalSortedVector.length : -1; m < n; m++) 
				{
					var controlName:String = finalSortedVector[m].GetControlObjectName();
					if (controlName in unsortedVectorDict)
					{
						var childVector:Vector.<DispObjInfo> = unsortedVectorDict[controlName];
						//delete unsortedVectorDict[controlName];
						for (var o:int = childVector.length-1; o >=0 ; o--) 
						{
							finalSortedVector.splice(m + 1, 0, childVector[o]);
						}
						n = finalSortedVector.length;
					}
				}
				dispObjContainer[time] = finalSortedVector;	
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
		//Helper function that handles the merging for SortDispObjInfoVector().
		private function Merge(A:Vector.<DispObjInfo>, begin:int, mid:int, end:int, B:Vector.<DispObjInfo>):void
		{
			var i:int = begin, j:int = mid;
			for (var k:int = begin; k < end; k++) 
			{ 
				//if (i < mid && (j >= end || CompareDispObjInfoDepths(A[i], A[j]) == 0))
				if (i < mid && (j >= end || A[i].GetDepth() <= A[j].GetDepth()))
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
		//}
		/* End of Animation Creation Functions */

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
			return (masterTimeline) ? masterTimeline.position : Number.NaN;
		}
		
		public function IsAnimationFinished():Boolean
		{
			if (!masterTimeline || masterTimeline.position >= masterTimeline.duration)
			{
				return true;
			}
			return false;
		}
	}

}