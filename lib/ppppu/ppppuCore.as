package ppppu 
{
	//import AnimationSettings.CowgirlInfo;
	import Animations.AnimationInfo;
	import Animations.Background.*;
	import Animations.TimelineDefinition;
	import Characters.*;
	import com.greensock.easing.Linear;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.FrameLabel;
	import flash.display.Sprite;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.net.registerClassAlias;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import com.greensock.plugins.*;
	import com.greensock.data.TweenLiteVars;
	import com.greensock.*;
	import flash.geom.Rectangle;
	import ppppu.TemplateBase;
	import flash.ui.Keyboard;
	
	/**
	 * Responsible for all the various aspects of ppppuNX. 
	 * @author ppppuProgrammer
	 */
	public class ppppuCore extends MovieClip
	{
		//Holds all the timelines to be used in the program.
		private var timelineLib:TimelineLibrary = new TimelineLibrary();
		
		//A movie clip that holds all the body elements used to create an animation. The elements in this class are controlled
		//TODO: Test the extendability of the master template. Can custom elements be easily added to it without big issues?
		private var masterTemplate:MasterTemplate;// = new MasterTemplate();
		//Responsible for holding the various timelines that will be added to a template. This dictionary is 3 levels deep, which is expressed by: timelineDict[Character][Animation][Part]
		//private var timelinesDict:Dictionary = new Dictionary();
		
		
		
		private var layerInfoDict:Dictionary = new Dictionary();
		private var animInfoDict:Dictionary = new Dictionary();
		public var mainStage:PPPPU_Stage;
		//Keeps track of what keys were pressed and/or held down
		private var keyDownStatus:Array = [];
		//Contains the names of the various animations that the master template can switch between. The names are indexed by their position in the vector.
		private var animationNameIndexes:Vector.<String> = new <String>["Cowgirl", "LeanBack", "LeanForward", "Grind", "ReverseCowgirl", "Paizuri", "Blowjob", "SideRide", "Swivel", "Anal"];
		private var characterList:Vector.<ppppuCharacter> = new <ppppuCharacter>[new PeachCharacter, new RosalinaCharacter];
		private const defaultCharacter:ppppuCharacter = characterList[0];
		private const defaultCharacterName:String = defaultCharacter.GetName();
		private var currentCharacter:ppppuCharacter = defaultCharacter;
		private var currentAnimationIndex:uint = 0;
		//private var embedTweenDataConverter:TweenDataParser = new TweenDataParser();
		
		//private var charVoiceSystem:SoundEffectSystem;
		
		private var playSounds:Boolean = false;
		
		//For stopping animation
		private var lastPlayedFrame:int = -1;
		
		//private var displayWidthLimit:int;
		private var flashStartFrame:int;
		private var mainStageLoopStartFrame:int;
		
		//Settings related
		//public var settingsSaveFile:SharedObject = SharedObject.getLocal("ppppuNX");
		//public var userSettings:ppppuUserSettings = new ppppuUserSettings();
		
		public var backgroundMasterTimeline:TimelineMax = new TimelineMax({paused:true});
		
		public var DEBUG_playSpeed:Number = 1.0;
		
		//Constructor
		public function ppppuCore() 
		{
			//Create the "main stage" that holds the character template and various other movieclips such as the transition and backlight 
			mainStage = new PPPPU_Stage();
			mainStage.Backlight.visible = mainStage.OuterDiamond.visible = mainStage.InnerDiamond.visible = 
			mainStage.TransitionDiamond.visible = mainStage.Compositor.visible = mainStage.DisplayArea.visible = false;
			
			mainStage.stop();
			addChild(mainStage);
			
			//masterTemplate = //mainStage.DisplayArea.MasterTemplateInstance;
			var frameLabels:Array = mainStage.currentLabels;
			for (var i:int = 0, l:int = frameLabels.length; i < l;++i)
			{
				var label:FrameLabel = frameLabels[i] as FrameLabel;
				if (label.name == "re")
				{mainStageLoopStartFrame = label.frame; }
				else if (label.name == "Start")
				{flashStartFrame = label.frame;}
			}
			//Add an event listener that'll allow for frame checking.
			mainStage.addEventListener(Event.ENTER_FRAME, RunLoop);
			//this.cacheAsBitmap = true;
			//this.scrollRect = new Rectangle(0, 0, 480, 720);
			/*var test:CustomElementContainer = new CustomElementContainer();
			test.AddSprites(null, new DaisyHairBack(), null, new RosalinaHairBack());
			test.x = test.y = 200; 
			addChild(test);*/
			masterTemplate = mainStage.Compositor;
			masterTemplate.Initialize(timelineLib);
			//masterTemplate.visible = false;
			//characterList[0].SetID(0);
			//masterTemplate.
			
			/*A description of the parts of the ppppu stage
			 * DisplayArea - used to help center the flash. Indicates the intended view area that should be used
			 * Background - planet from space image.
			 * InnerDiamond - The inside diamonds part of the oscillating background
			 * TransitionDiamond - The diamonds that appears on the 1st and second to last frame of an animation
			 * Backlight - The light orb that appears towards the last half of an animation
			 * OuterDiamond - The image that visually surrounds the diamonds of the inner diamond sprite. Despite the name, it's not actually diamond shaped.
			 * Compositor - The movie clip containing all the parts that are controlled by gsap timeline to create a complete animation. Is an instance of the TemplateBase class*/
			
		}
		
		//Sets up the various aspects of the flash to get it ready for performing.
		public function Initialize():void
		{
			//Add the key listeners
			//TODO: Re-enable when done testing menus
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyPressCheck);
			stage.addEventListener(KeyboardEvent.KEY_UP, KeyReleaseCheck);
			
			//Initializing plugins for the GSAP library
			TweenPlugin.activate([FramePlugin, FrameLabelPlugin, TransformMatrixPlugin, VisiblePlugin, ColorTransformPlugin]);
			//Set the default Ease for the tweens
			TweenLite.defaultEase = Linear.ease;
			TweenLite.defaultOverwrite = "none";
			//Disable mouse interaction for various objects
			////mainStage.MenuLayer.mouseEnabled = true;
			//Disable mouse interaction for various objects
			mainStage.mouseEnabled = false;
			mainStage.DisplayArea.mouseEnabled = false;
			mainStage.DisplayArea.mouseChildren = false;
			//mainStage.HelpLayer.mouseEnabled = false;
			//mainStage.HelpLayer.mouseChildren = false;
			mainStage.Backlight.mouseEnabled = false;
			mainStage.Backlight.mouseChildren = false;
			mainStage.InnerDiamond.mouseEnabled = false;
			mainStage.InnerDiamond.mouseChildren = false;
			mainStage.OuterDiamond.mouseChildren = false;
			mainStage.OuterDiamond.mouseEnabled = false;
			mainStage.TransitionDiamond.mouseChildren = false;
			mainStage.TransitionDiamond.mouseEnabled = false;
			
			//Master template mouse event disabling
			masterTemplate.mouseChildren = false;
			masterTemplate.mouseEnabled = false;
			
			//AddCharacter(PeachCharacter);
			
			//masterTemplate.currentCharacter = defaultCharacter;
			for (var childIndex:uint = 0, templateChildrenCount:uint = masterTemplate.numChildren; childIndex < templateChildrenCount; ++childIndex)
			{
				//masterTemplate.getChildAt(childIndex).visible = false;
			}
			mainStage.x = (stage.stageWidth - mainStage.DisplayArea.width) / 2;	
			
			//animInfoDict["Cowgirl"] = new CowgirlInfo();
			
			//Switch the first animation.
			//SwitchTemplateAnimation(0);
			//SwitchTemplateAnimation(8);
			
			//menu = new ppppuMenu(masterTemplate);
			//menu.ChangeSlidersToCharacterValues(currentCharacter);
			//addChild(menu);
			
			//charVoiceSystem = new SoundEffectSystem();
			
			//Set timelines up for background elements.
			var backlightTLDef:TimelineDefinition = new BacklightTimelineData();
			
			backgroundMasterTimeline.add(masterTemplate.CreateTimelineFromData(backlightTLDef.GetTimelineData(), mainStage),0);
			var outerDiaTLDef:TimelineDefinition = new OuterDiamondTimelineData();
			backgroundMasterTimeline.add(masterTemplate.CreateTimelineFromData(outerDiaTLDef.GetTimelineData(), mainStage),0);
			var innerDiaTLDef:TimelineDefinition = new InnerDiamondTimelineData();
			backgroundMasterTimeline.add(masterTemplate.CreateTimelineFromData(innerDiaTLDef.GetTimelineData(), mainStage),0);
			var transitDiaTLDef:TimelineDefinition = new TransitionDiamondTimelineData();
			backgroundMasterTimeline.add(masterTemplate.CreateTimelineFromData(transitDiaTLDef.GetTimelineData(), mainStage),0);
			
			//Initialize test animation for Cowgirl animation
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, FinishedLoadingSWF);
			var cowgirlURL:URLRequest = new URLRequest("CowgirlAnimation.swf");
			loader.load(cowgirlURL);
			addChild(loader);
			
			var loader2:Loader = new Loader();
			loader2.contentLoaderInfo.addEventListener(Event.COMPLETE, FinishedLoadingSWF);
			var rosaCowgirlURL:URLRequest = new URLRequest("RosaCowgirlAnimation.swf");
			loader2.load(rosaCowgirlURL);
			addChild(loader2);
			
			//(loader as AnimationInfo).GetDataForTimelinesCreation();
			//var animation:AnimationInfo = (loader as AnimationInfo);
			//animation.GetDataForTimelinesCreation();
			//Test purposes
			SwitchCharacter(0);
			masterTemplate.visible = true;
			//SwitchTemplateAnimation(0);
			//masterTemplate.PlayAnimation(0);
			//mainStage.play();
		}
		
		//The "heart beat" of the flash. Ran every frame to monitor and react to certain, often frame sensitive, events
		private function RunLoop(e:Event):void
		{
			if (backgroundMasterTimeline.paused())
			{
				backgroundMasterTimeline.play();
				var array:Array = backgroundMasterTimeline.getChildren(true, false);
				for each (var tl:TimelineMax in array)
				{
					tl.play();
				}
			}
			var mainStageMC:MovieClip = (e.target as MovieClip);
			var frameNum:int = mainStageMC.currentFrame; //The current frame that the main stage is at.
			var animationFrame:int = ((frameNum -2) % 120) + 1; //The frame that an animation should be on. Animations are typically 120 frames / 4 seconds long
			if (animationFrame && animationFrame != lastPlayedFrame)
			{
				if (frameNum == flashStartFrame)
				{
					/*if (userSettings.firstTimeRun == true)
					{
						UpdateKeyBindsForHelpScreen();
						ToggleHelpScreen(); //Show the help screen
						characterManager.ToggleMenu();
						userSettings.firstTimeRun = false;
						settingsSaveFile.data.ppppuSettings = userSettings;
						settingsSaveFile.flush();
					}
					else
					{
						if (userSettings.showMenu)
						{
							characterManager.ToggleMenu();
						}
					}*/
					/*if (userSettings.showBackground == true)
					{
						//mainStage.TransitionDiamond.visible = //mainStage.OuterDiamond.visible = //mainStage.InnerDiamond.visible = true;
					}*/
					/*mainStage.OuterDiamond.gotoAndPlay(animationFrame);
					mainStage.InnerDiamond.gotoAndPlay(animationFrame);
					mainStage.TransitionDiamond.gotoAndPlay(animationFrame);
					mainStage.Backlight.gotoAndPlay(animationFrame);*/
					masterTemplate.visible = true;
					//Go to the 
					SwitchTemplateAnimation(currentAnimationIndex);
					masterTemplate.PlayAnimation(animationFrame);
					
					////mainStage.setChildIndex(masterTemplate, //mainStage.numChildren - 1);
				}
				masterTemplate.Update(/*animationFrame*/);
				//masterTemplate.UpdateAnchoredElements(); //Called by master template's update functions
				if (playSounds)
				{
					//charVoiceSystem.Tick(animationFrame);
				}
				//Make sure the background movie clips stay synced after reaching the loop end point on the main stage
				if (frameNum == mainStageLoopStartFrame)
				{
					/*mainStage.OuterDiamond.gotoAndPlay(animationFrame);
					mainStage.InnerDiamond.gotoAndPlay(animationFrame);
					mainStage.TransitionDiamond.gotoAndPlay(animationFrame);
					mainStage.Backlight.gotoAndPlay(animationFrame);*/
				}
			}
			lastPlayedFrame = animationFrame;
		}
		
		/*Responsible for processing all the motion xmls detailed in an animationMotions file, creating tweenLite tweens from them,
		 * and finally creating a timeline from those tweens and storing it in a dictionary*/
		/*private function ProcessMotionStaticClass(motionClass:Class, template:DisplayObject):Vector.<TimelineMax>
		{
			
			//Create an instance of the animation motion class
			var animationMotionInstance:Object = new motionClass();
			
			var timelineVector:Vector.<TimelineMax>;// = new Vector.<TimelineMax>();
			var templateAnimation:TemplateBase = template as TemplateBase;
			
			if (templateAnimation == null)
			{
				trace("Template animation is null for processing Motion Class: " + motionClass); 
				return null;
			}
			
			var charName:String = animationMotionInstance.CharacterName; //Character the animation motion is for
			var animName:String = animationMotionInstance.AnimationName; //The type of animation template that the animation motion is for
			var layerInfo:String = animationMotionInstance.LayerInfo; //Contains information that is used to rearrange the depth of elements displayed.
			
			//LayerInfo was found, so process it
			if (layerInfo != null && layerInfo.length > 0)
			{
				//LayerInfo strings are in JSON format, which is parsed as an Object
				var layerInfoObject:Object = JSON.parse(layerInfo);
				//If the layer info dictionary for the character doesn't exist, create it.
				if (layerInfoDict[charName] == null) { layerInfoDict[charName] = new Dictionary(); }
				//Set the layer info for an animation of the character
				layerInfoDict[charName][animName] = layerInfoObject;
			}
			
			//Get the description of the animation motion class
			var jsonClassDescriber:DescribeTypeJSON = new DescribeTypeJSON();
			var motionClassDescription:Object = jsonClassDescriber.describeType(motionClass, DescribeTypeJSON.INCLUDE_VARIABLES | DescribeTypeJSON.INCLUDE_TRAITS | DescribeTypeJSON.INCLUDE_ITRAITS);
			
			//Get an array of the animation motion class' variables
			var varsInMotionClass:Array = motionClassDescription.traits.variables as Array;
			var currentVarInfo:Object;
			var objectClassNames:Vector.<String> = new Vector.<String>();
			
			//Create the timeline vector
			timelineVector = new Vector.<TimelineMax>();
			
			//Run through the variables array 
			for (var index:int = 0, length:int = varsInMotionClass.length; index < length; ++index)
			{
				//Get the information of the variable at the index
				currentVarInfo = varsInMotionClass[index];
				var currentVarName:String = currentVarInfo.name as String;
				
				//Get the actual instance of the variable from the instance of the animation motion created at the beginning of this function.
				var currentVariable:Object = animationMotionInstance[currentVarName];
				//Only care about the variable if it's a byte array
				if (currentVariable is ByteArray)
				{
					//Add the name of the element into the objectClassNames vector
					objectClassNames[objectClassNames.length] = currentVarName;
					if (currentVariable.length != 0)
					{
						//Deserialize the byte array into a vector of tween data objects
						var vectorOfTweenData:Vector.<Object> = currentVariable.readObject() as Vector.<Object>;
						
						var templateElement:DisplayObject = templateAnimation[currentVarName];
						

						//Declare the timeline for the tweens
						var timelineForMotion:TimelineMax = embedTweenDataConverter.CreateTimelineFromData(templateElement, vectorOfTweenData); 
						
						//Dictionary existance checking. Create a dictionary if the specified one doesn't exist.
						
						if (timelineForMotion)
						{
							//Setting the timelines dictionary to contain the created time line.
							//timelinesDict[charName][animName][currentVarName] = timelineForMotion;
							//Adding the created timeline to timelineVector
							timelineVector[timelineVector.length] = timelineForMotion;
							//Tell the timeline to start paused, to help save on processing a little.
							//timelineForMotion.pause();
						}
					}
					else
					{
						trace("Warning! Tween data for element " + templateElement.name + " of animation " + animName + " was empty. Timeline was not constructed.");
					}
				}	
			}
			return timelineVector;
		}*/
		
		//Activated if a key is detected to be released. Sets the keys "down" status to false
		private function KeyReleaseCheck(keyEvent:KeyboardEvent):void
		{
			keyDownStatus[keyEvent.keyCode] = false;
		}
		
		/*Activated if a key is detected to be pressed and after processing logic, sets the keys "down" status to true. If this is the first 
		frame a key is detected to be down, perform the action related to that key, unless the random animation key is held down. Though 
		it was an unintentional oversight at first, people were amused by this, so it has been kept as a feature.*/
		private function KeyPressCheck(keyEvent:KeyboardEvent):void
		{
			//Check if the menus need input focus. If they do, then bail so there is no changes due to both this and the menu acting on the same input simultaneously.
			//if (menu.MenuNeedsInputFocus()) { return; }
			
			var keyPressed:int = keyEvent.keyCode;

			if(keyDownStatus[keyPressed] == undefined || keyDownStatus[keyPressed] == false || (keyPressed == 48 || keyPressed == 96))
			{
				if((keyPressed == 48 || keyPressed == 96))
				{
					var randomAnimIndex:int = Math.floor(Math.random() * animationNameIndexes.length);
					SwitchTemplateAnimation(randomAnimIndex);
					masterTemplate.PlayAnimation(0);
				}
				else if((!(49 > keyPressed) && !(keyPressed > 57)) ||  (!(97 > keyPressed) && !(keyPressed > 105)))
				{
					//keypress of 1 has a keycode of 49
					if(keyPressed > 96)
					{
						keyPressed = keyPressed - 48;
					}
					SwitchTemplateAnimation(keyPressed - 49);
					masterTemplate.PlayAnimation(0);
				}
				
				if (keyPressed == Keyboard.UP)
				{
					DEBUG_playSpeed += .05;
					masterTemplate.ChangePlaySpeed(DEBUG_playSpeed);
				}
				else if (keyPressed == Keyboard.DOWN)
				{
					DEBUG_playSpeed -= .05;
					masterTemplate.ChangePlaySpeed(DEBUG_playSpeed);
					//ScaleFromCenter(//mainStage.DisplayArea, //mainStage.DisplayArea.scaleX - .05, //mainStage.DisplayArea.scaleY - .05);
				}
				
				if (keyPressed == Keyboard.Q)
				{
					if (currentCharacter.GetID() != 0)
					{
						currentCharacter == characterList[0];
						masterTemplate.ClearTimelines();
						masterTemplate.AddTimelines(timelineLib.GetBaseTimelinesFromLibrary(0));
					}
					//masterTemplate.HairFront.ChangeDisplayedSprite(0);
				}
				else if (keyPressed == Keyboard.W)
				{
					if (currentCharacter.GetID() != 1)
					{
						currentCharacter == characterList[1];
						masterTemplate.AddTimelines(timelineLib.GetReplacementTimelinesToLibrary(0,1, "Standard"));
					}
					//masterTemplate["HairFront"].ChangeDisplayedSprite(1);
				}
				
				/*if (keyPressed == Keyboard.Z)
				{
				}
				
				//Debugger
				if (keyPressed == Keyboard.S)
				{
					//mainStage.stop();
					//mainStage.OuterDiamond.stop();
					//mainStage.InnerDiamond.stop();
					//mainStage.TransitionDiamond.stop();
					//mainStage.Backlight.stop();
					masterTemplate.StopAnimation();
				}
				else if (keyPressed == Keyboard.R)
				{
					//mainStage.play();
					//mainStage.OuterDiamond.play();
					//mainStage.InnerDiamond.play();
					//mainStage.TransitionDiamond.play();
					//mainStage.Backlight.play();
					masterTemplate.ResumePlayingAnimation();
				}
				else if (keyPressed == Keyboard.D)
				{
					masterTemplate.ToggleDebugModeText();
				}
				else if (keyPressed == Keyboard.F)
				{
					masterTemplate.ToggleHairVisibility();
				}
				else if (keyPressed == Keyboard.G)
				{
					masterTemplate.DEBUG_HairBackTesting();
				}
				else if (keyPressed == Keyboard.M)
				{
					masterTemplate.Mouth.ChangeExpression("Smile");
				}
				else if (keyPressed == Keyboard.N)
				{
					masterTemplate.Mouth.ChangeExpression("TearShape");
				}
				else if (keyPressed == Keyboard.O)
				{
					masterTemplate.Mouth.ChangeExpression("Oh");
				}
				else if (keyPressed == Keyboard.L)
				{
					var myTextLoader:URLLoader = new URLLoader();
					myTextLoader.addEventListener(Event.COMPLETE, mouthLoadTest);
					myTextLoader.addEventListener(IOErrorEvent.IO_ERROR, loadFail);
					myTextLoader.load(new URLRequest("MouthTest.txt"));
				}*/
				
			}
			/*if (keyPressed == Keyboard.LEFT)
			{
				//mainStage.prevFrame();
				var frame:int = (//mainStage.currentFrame -2) % 120 + 1;
				
				//mainStage.OuterDiamond.gotoAndStop(frame);
				//mainStage.InnerDiamond.gotoAndStop(frame);
				//mainStage.TransitionDiamond.gotoAndStop(frame);
				//mainStage.Backlight.gotoAndStop(frame);
				masterTemplate.PlayAnimation(frame);
				masterTemplate.StopAnimation();
			}
			else if (keyPressed == Keyboard.RIGHT)
			{
				//mainStage.nextFrame();
				var frame:int = (//mainStage.currentFrame -2) % 120 + 1;
				
				//mainStage.OuterDiamond.gotoAndStop(frame);
				//mainStage.InnerDiamond.gotoAndStop(frame);
				//mainStage.TransitionDiamond.gotoAndStop(frame);
				//mainStage.Backlight.gotoAndStop(frame);
				masterTemplate.PlayAnimation(frame);
				masterTemplate.StopAnimation();
			}
			if (keyPressed == Keyboard.UP)
			{
				//ScaleFromCenter(//mainStage.DisplayArea, //mainStage.DisplayArea.scaleX + .05, //mainStage.DisplayArea.scaleY + .05);
			}
			else if (keyPressed == Keyboard.DOWN)
			{
				//ScaleFromCenter(//mainStage.DisplayArea, //mainStage.DisplayArea.scaleX - .05, //mainStage.DisplayArea.scaleY - .05);
			}*/
			
			keyDownStatus[keyEvent.keyCode] = true;
		}
		
		//Switches to a templated animation of a specified name
		private function SwitchTemplateAnimation(animationIndex:uint):void
		{
			var animationName:String = animationNameIndexes[animationIndex];
			var currentCharacterName:String = currentCharacter.GetName();
			masterTemplate.currentAnimationName = animationName;

			
			if(!timelineLib.DoesBaseTimelinesForAnimationExist(animationIndex))
			{
				//CreateTimelinesForCharacterAnimation(defaultCharacterName, animationIndex);
			}
			//var defaultLayerInfo:Object = layerInfoDict[defaultCharacterName][animationName];
			var currentCharLayerInfo:Object = layerInfoDict[currentCharacterName][animationName];
			
			masterTemplate.SetElementDepthLayout(currentCharLayerInfo);
			
			
			for (var index:uint = 0, length:uint = animationNameIndexes.length; index < length; ++index)
			{
				if (animationName == animationNameIndexes[index])
				{
					masterTemplate.ChangeBaseTimelinesUsed(index);
					break;
				}
			}
			
			
			if (currentCharacter != defaultCharacter)
			{
				if (!timelineLib.DoesCharacterSetExists(animationIndex, currentCharacter.GetID(), "Standard"))
				{
					//CreateTimelinesForCharacterAnimation(currentCharacterName, animationIndex);
				}
				masterTemplate.AddTimelines(timelineLib.GetReplacementTimelinesToLibrary(animationIndex, currentCharacter.GetID(), "Standard"));
			}
			masterTemplate.ImmediantLayoutUpdate(/*(mainStage.currentFrame -2) % 120 + 1*/);
			//Change the animation info
			//masterTemplate.currentAnimationInfo = animInfoDict["Cowgirl"];
			
			//Sync the animation to the main stage's timeline (main stage's current frame - animation start frame % 120 + 1 to avoid setting it to frame 0)
			//masterTemplate.PlayAnimation((mainStage.currentFrame -2) % 120 + 1);
			currentAnimationIndex = animationIndex;
			
		}
		
		public function SwitchCharacter(charId:int):void
		{
			if (charId >= 0 && charId < characterList.length)
			{
				currentCharacter = characterList[charId];
				/*charVoiceSystem.ChangeCharacterVoiceSet(currentCharacter.GetVoiceSet());
				charVoiceSystem.ChangeCharacterVoiceChance(currentCharacter.GetVoicePlayChance());
				charVoiceSystem.ChangeCharacterVoiceCooldown(currentCharacter.GetVoiceCooldown());
				charVoiceSystem.ChangeCharacterVoiceRate(currentCharacter.GetVoicePlayRate());
				menu.ChangeSlidersToCharacterValues(currentCharacter);*/
			}
		}
		
		public function GetListOfCharacterNames():Vector.<String>
		{
			var charNameVector:Vector.<String> = new Vector.<String>();
			for (var i:int = 0, l:int = characterList.length; i < l; ++i)
			{
				charNameVector[i] = characterList[i].GetName();
			}
			return charNameVector;
		}
		
		public function GetListOfAnimationNames():Vector.<String>
		{
			return animationNameIndexes;
		}
		
		public function AddCharacter(characterClass:Class):void
		{
			var character:ppppuCharacter = new characterClass;
			character.SetID(characterList.length);
			characterList[characterList.length] = character;
		}
		
		private function ScaleFromCenter(dis:DisplayObjectContainer,sX:Number,sY:Number):void
		{
			var posX:Number = dis.x;
			var posY:Number = dis.y;
			var oldDisBounds:Rectangle = dis.getBounds(dis.parent);
			//dis.x =dis.y = 0;
			dis.scaleX = sX;
			dis.scaleY = sY;
			
			var newDisBounds:Rectangle = dis.getBounds(dis.parent);
			var xDisplacement:Number = newDisBounds.left - oldDisBounds.left;
			var yDisplacement:Number = newDisBounds.top - oldDisBounds.top;
			dis.x += xDisplacement;
			dis.y += yDisplacement;
		}
		
		private function mouthLoadTest(e:Event):void
		{
			/*var parser:ExpressionParser = new ExpressionParser();
			var expr:TimelineMax = parser.Parse(masterTemplate, masterTemplate.Mouth.ExpressionContainer, e.target.data as String);
			//var expr:TimelineMax = ExpressionParser.ParseExpression(masterTemplate, masterTemplate.Mouth.ExpressionContainer, e.target.data);
			masterTemplate.SetExpression(expr);*/
		}
		
		private function loadFail(e:IOErrorEvent):void
		{
			trace("Was unable to load file \"MouthTest.txt\"");
		}
		
		private function FinishedLoadingSWF(e:Event):void
		{
			var animInfo:AnimationInfo = e.target.content as AnimationInfo;
			//addChild(test);
			//Get stuff from target swf
			if (animInfo)
			{
				var data:Vector.<Object> = animInfo.GetDataForTimelinesCreation();
				var timelines:Vector.<TimelineMax> = new Vector.<TimelineMax>();
				var displayLayout:Object = JSON.parse(animInfo.GetDisplayOrderList());
				
				var charName:String = animInfo.GetCharacterName();
				var animName:String = animInfo.GetAnimationName();
				//If the layer info dictionary for the character doesn't exist, create it.
				if (layerInfoDict[charName] == null) 
				{ layerInfoDict[charName] = new Dictionary(); }
				//Set the layer info for an animation of the character
				layerInfoDict[charName][animName] = displayLayout;
				
				for (var i:int = 0, l:int = data.length; i < l; ++i)
				{
					timelines[timelines.length] = masterTemplate.CreateTimelineFromData(data[i],masterTemplate);
					
				}
				if (animInfo.GetCharacterName() == defaultCharacterName)
				{
					timelineLib.AddBaseTimelinesToLibrary(0, timelines);
				}
				else
				{
					timelineLib.AddReplacementTimelinesToLibrary(0, 1, "Standard", timelines);
				}
				
				
			}
			//remove it
			removeChild(e.target.loader);
		}
	}

}