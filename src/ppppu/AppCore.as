package ppppu 
{
	/*body type > animation > variation

Currently:
animation > body > timelines
animation > character > timelines

animation:
character:
body:
variant:

goals:
There should be a base animation that a complete animation is built off of

base + character specific body parts + character hair

how to accomplish base + rosa body parts + peach hair (char is peach)
* Can't have timelines tied to character.
Need to set base. Need to add/replace with rosa body parts timelines. Need to then add peach hair timelines.*/
	//import AnimationSettings.CowgirlInfo;
	import animations.TimelineLibrary;
	import com.jacksondunstan.signals.*;
	import flash.system.System;
	import modifications.AnimationMod;
	import animations.background.*;
	import modifications.TemplateAnimationMod;
	import modifications.TemplateCharacterMod;
	import org.libspark.betweenas3.BetweenAS3;
	import org.libspark.betweenas3.core.tweens.groups.ParallelTween;
	import org.libspark.betweenas3.core.tweens.groups.SerialTween;
	//import animations.background.BacklightTimelineData;
	//import animations.background.InnerDiamondTimelineData;
	//import animations.background.OuterDiamondTimelineData;
	//import animations.background.TransitionDiamondTimelineData;
	import animations.TimelineDefinition;
	import characters.*;
	import characters.PeachCharacter;
	import characters.Character;
	import characters.RosalinaCharacter;
	import com.greensock.easing.Linear;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
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
	import flash.events.TimerEvent;
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
	import modifications.ModArchive;
	import modifications.MusicMod;
	import modifications.Mod;
	import ppppu.MusicPlayer;
	import ppppu.TemplateBase;
	import flash.ui.Keyboard;
	import flash.utils.*;
	
	/**
	 * Responsible for all the various aspects of ppppuNX. 
	 * @author ppppuProgrammer
	 */
	public class AppCore extends Sprite implements Slot1, Slot2
	{
		//Holds all the timelines to be used in the program.
		private var timelineLib:TimelineLibrary = new TimelineLibrary();
		
		//A movie clip that holds all the body elements used to create an animation. The elements in this class are controlled
		//TODO: Test the extendability of the master template. Can custom elements be easily added to it without big issues?
		private var masterTemplate:MasterTemplate;// = new MasterTemplate();
		//Responsible for holding the various timelines that will be added to a template. This dictionary is 3 levels deep, which is expressed by: timelineDict[Animation][Character][Part]
		//private var timelinesDict:Dictionary = new Dictionary();
		
		
		
		private var layerInfoDict:Dictionary = new Dictionary();
		private var animInfoDict:Dictionary = new Dictionary();
		public var mainStage:PPPPU_Stage;
		//Keeps track of what keys were pressed and/or held down
		private var keyDownStatus:Array = [];
		//Contains the names of the various animations that the master template can switch between. The names are indexed by their position in the vector.
		private var animationNameIndexes:Vector.<String> = new Vector.< String > ();// ["Cowgirl", "LeanBack", "LeanForward", "Grind", "ReverseCowgirl", "Paizuri", "Blowjob", "SideRide", "Swivel", "Anal"];
		private var basisBodyTypes:Vector.<String> = new Vector.<String>();
		private var characterList:Vector.<Character> = new Vector.<Character>();//[new PeachCharacter, new RosalinaCharacter];
		private var defaultCharacter:Character;// = characterList[0];
		private var defaultCharacterName:String;// = defaultCharacter.GetName();
		private var currentCharacter:Character;// = defaultCharacter;
		private var currentAnimationIndex:int = -1;
		public var currentAnimationName:String = "None";
		//private var embedTweenDataConverter:TweenDataParser = new TweenDataParser();
		
		private var musicPlayer:ppppu.MusicPlayer = new ppppu.MusicPlayer();
		//private var charVoiceSystem:SoundEffectSystem;
		
		private var playSounds:Boolean = false;
		
		//For stopping animation
		//private var lastPlayedFrame:int = -1;
		
		//private var displayWidthLimit:int;
		//private var flashStartFrame:int;
		//private var mainStageLoopStartFrame:int;
		
		//Settings related
		//public var settingsSaveFile:SharedObject = SharedObject.getLocal("ppppuNX");
		//public var userSettings:ppppuUserSettings = new ppppuUserSettings();
		
		//Counter to see just how long the flash has been running in milliseconds. Used for timing purposes such as controlling when to change characters.
		public var ppppuRunTimeCounter:Number = 0;
		private var previousUpdateTime:Number;
		//private var runTimer:Timer;
		private var firstTimeInLoop:Boolean = true;
		//public var counter:int = 0;
		
		//Holds the duration of the master timeline contained in the master template. Used to avoid needing to call masterTemplate.GetDurationOfCurrentAnimation in the run loop.
		private var animationDuration:Number = 0;
		
		public var backgroundMasterTimeline:ParallelTween;
		public var bgMasterTimelineChildren:Array = new Array();
		
		public var DEBUG_playSpeed:Number = 1.0;
		
		private var startupLoader:LoaderMax = new LoaderMax( { name:"Startup", onComplete:StartupLoadsComplete, onChildComplete:FinishedLoadingSWF } );
		
		CONFIG::debug
		private var devMenu:DeveloperMenu = new DeveloperMenu();

		private var devMenuSignaller1:Signal1 = new Signal1();
		private var devMenuSignaller2:Signal2 = new Signal2();
		
		//Constructor
		public function AppCore() 
		{
			//Create the "main stage" that holds the character template and various other movieclips such as the transition and backlight 
			mainStage = new PPPPU_Stage();
			mainStage.Backlight.visible = mainStage.OuterDiamond.visible = mainStage.InnerDiamond.visible = 
			mainStage.TransitionDiamond.visible = mainStage.Compositor.visible = mainStage.DisplayArea.visible = false;
			
			//mainStage.stop();
			//Hide the master template until everything is initialized
			mainStage.Compositor.visible = false;
			addChild(mainStage);
			mainStage.stopAllMovieClips();
			//masterTemplate = //mainStage.DisplayArea.MasterTemplateInstance;
			//Add an event listener that'll allow for frame checking.
			//mainStage.addEventListener(Event.ENTER_FRAME, RunLoop);
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
			
			//Add the characters
			AddCharacter(PeachCharacter);
			AddCharacter(RosalinaCharacter);
			
			CONFIG::TweenLib == "GSAP"
			{
			//Initializing plugins for the GSAP library
			TweenPlugin.activate([FramePlugin, FrameLabelPlugin, TransformMatrixPlugin, VisiblePlugin, ColorTransformPlugin]);
			//Set the default Ease for the tweens
			TweenLite.defaultEase = Linear.ease;
			TweenLite.defaultOverwrite = "none";
			}
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
			/*var backlightTLDef:TimelineDefinition = new BacklightTimelineData();
			bgMasterTimelineChildren[bgMasterTimelineChildren.length] = masterTemplate.CreateTimelineFromData(backlightTLDef.GetTimelineData(), mainStage);
			//backgroundMasterTimeline.add(bgMasterTimelineChildren[bgMasterTimelineChildren.length-1], 0);
			var outerDiaTLDef:TimelineDefinition = new OuterDiamondTimelineData();
			bgMasterTimelineChildren[bgMasterTimelineChildren.length] = masterTemplate.CreateTimelineFromData(outerDiaTLDef.GetTimelineData(), mainStage);
			//backgroundMasterTimeline.add(bgMasterTimelineChildren[bgMasterTimelineChildren.length-1], 0);
			var innerDiaTLDef:TimelineDefinition = new InnerDiamondTimelineData();
			bgMasterTimelineChildren[bgMasterTimelineChildren.length] = masterTemplate.CreateTimelineFromData(innerDiaTLDef.GetTimelineData(), mainStage);
			//backgroundMasterTimeline.add(bgMasterTimelineChildren[bgMasterTimelineChildren.length-1], 0);
			var transitDiaTLDef:TimelineDefinition = new TransitionDiamondTimelineData();
			bgMasterTimelineChildren[bgMasterTimelineChildren.length] = masterTemplate.CreateTimelineFromData(transitDiaTLDef.GetTimelineData(), mainStage);
			//backgroundMasterTimeline.add(bgMasterTimelineChildren[bgMasterTimelineChildren.length-1], 0);
			
			backgroundMasterTimeline = BetweenAS3.parallelTweens(bgMasterTimelineChildren) as ParallelTween;
			backgroundMasterTimeline.stopOnComplete = false;*/
			musicPlayer.SetUpdateRate(stage.frameRate);
			
			//(loader as AnimationInfo).GetDataForTimelinesCreation();
			//var animation:AnimationInfo = (loader as AnimationInfo);
			//animation.GetDataForTimelinesCreation();
			//Test purposes
			
			//
			//masterTemplate.PlayAnimation(0);
			//mainStage.play();
			
			CONFIG::debug
			{
				addChild(devMenu);
				devMenu.SetupHooksToApp(this);
				SetupDevMenuHooks();
				
			}
			
			startupLoader.autoLoad = true;
			startupLoader.append(new SWFLoader("TCHAR_Peach.swf"));
			startupLoader.append(new SWFLoader("CowgirlAnimation.swf"));
			startupLoader.append(new SWFLoader("CowgirlAnimation_Peach.swf"));
			//startupLoader.append(new SWFLoader("PistonAnimation.swf"));
			//startupLoader.append(new SWFLoader("LeanTowardsAnimation.swf"));
			//startupLoader.append(new SWFLoader("RosaCowgirlAnimation.swf"));
			//startupLoader.append(new SWFLoader("RosaPistonAnimation.swf"));
			//startupLoader.append(new SWFLoader("RosaLeanTowardsAnimation.swf"));
			//startupLoader.append(new SWFLoader("bbskywayMusic.swf"));
			
			//LoaderMax.parse(["./bbskywayMusic.swf", "RosaLeanTowardsAnimation.swf"], { name:"parsedLoader"} );
			//startupLoader.load();
		}
		
		//The "heart beat" of the flash. Ran every frame to monitor and react to certain, often frame sensitive, events
		private function RunLoop(e:Event):void
		{
			//Checks if the timeline lib has a valid base animation set. If it doesn't, return until there is one loaded in.
			CONFIG::debug
			{
			if (devMenu.ReadyCheck() == false)
			{
				return;
			}
			}
			if (!timelineLib.HasValidBaseAnimation())
			{
				return;
			}

			if (firstTimeInLoop)
			{
				System.pauseForGCIfCollectionImminent(1);
				System.pauseForGCIfCollectionImminent(1);
				SwitchCharacter(0);
				//SwitchTemplateAnimation(0);
				//backgroundMasterTimeline.gotoAndPlay(0);
				//var bgTimelines:Array = backgroundMasterTimeline.getChildren(true, false);
				/*for each (var tl:TimelineLite in bgMasterTimelineChildren)
				{
					tl.play(0);
				}*/
				//masterTemplate.PlayAnimation(0);
				masterTemplate.visible = true;
				firstTimeInLoop = false;
				//previousUpdateTime = backgroundMasterTimeline.position;// .totalTime();//(getTimer() / 1000.0);
				ppppuRunTimeCounter = 0;
				musicPlayer.PlayMusic(musicPlayer.GetIdOfMusicByName(currentCharacter.GetDefaultMusicName()));

				//trace("bg:" + backgroundMasterTimeline.time() + " char:" +masterTemplate.GetTimeInCurrentAnimation() + " run: " + ppppuRunTimeCounter);
			}

				var animationPosition:Number = masterTemplate.Update();
				CONFIG::debug
				{
					devMenuSignaller2.dispatch("timeText", animationPosition);
					devMenuSignaller2.dispatch("updatedAnimation", masterTemplate);
				}

			/*else
			{
				var latestUpdateTime:Number = backgroundMasterTimeline.totalTime();// (getTimer() / 1000.0);
				ppppuRunTimeCounter += (latestUpdateTime - previousUpdateTime);
				//trace(ppppuRunTimeCounter);
				previousUpdateTime = latestUpdateTime;
				//trace("bg:" + backgroundMasterTimeline.totalTime() + " char:" +masterTemplate.GetTimeInCurrentAnimation() + " run: " + ppppuRunTimeCounter);
			}
			
			//Note: This assumes that master timeline's time and the run loop's time are sync'd. Worse case might require accessing the master timeline's time every update.
			if (ppppuRunTimeCounter >= animationDuration)
			{
				//Time to switch to a random animation and the other character
				//Hardcoded for 60 fps test. Do not do this for the NX version
				var currentCharID:int = currentCharacter.GetID();
				if (currentCharID == 1)
				{
					SwitchCharacter(0);
				}
				else
				{
					SwitchCharacter(++currentCharID);
				}
				
				var randomAnimSelect:int = Math.floor((Math.random() * animationNameIndexes.length));
				while (!timelineLib.DoesBaseTimelinesForAnimationExist(randomAnimSelect))
				{
					randomAnimSelect = Math.floor((Math.random() * animationNameIndexes.length));
				}
				System.pauseForGCIfCollectionImminent(1);
				//var startFuncTime:int = getTimer();
				SwitchTemplateAnimation(randomAnimSelect);
				//trace("SwitchTemplateAnimation complete time(ms): " + (getTimer() - startFuncTime));
				ppppuRunTimeCounter -= animationDuration;
			}
				//if (playSounds)
				//{
					//charVoiceSystem.Tick(animationFrame);
				//}*/
		}
		
		private function StartupLoadsComplete(e:LoaderEvent):void
		{
			//Add an event listener that'll allow for frame checking.
			mainStage.addEventListener(Event.ENTER_FRAME, RunLoop);
			
			
			//mainStage.play();
			//lastRecordedTime = getTimer();
			
			//TweenLite.ticker.addEventListener("tick", RunLoop,false,0,true);
			//runTimer = new Timer(1000.0 / stage.frameRate);
			//runTimer.addEventListener(TimerEvent.TIMER, this.RunLoop);
			//runTimer.start();
			e.currentTarget.unload();
			e.currentTarget.dispose();
		}
		
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
					//SwitchTemplateAnimation(randomAnimIndex);
					masterTemplate.PlayAnimation(-1);
				}
				else if((!(Keyboard.NUMBER_0 > keyPressed) && !(keyPressed > Keyboard.NUMBER_9 )) ||  (!(97 > keyPressed) && !(keyPressed > 105)))
				{
					//keypress of 1 has a keycode of 49
					if(keyPressed > 96)
					{
						keyPressed = keyPressed - 48;
					}
					if (timelineLib.DoesBaseTimelinesForAnimationExist(keyPressed - 49))
					{
					//SwitchTemplateAnimation(keyPressed - 49);
					}
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
				
				/*if (keyPressed == Keyboard.Q)
				{
					if (currentCharacter.GetID() != 0)
					{
						currentCharacter = characterList[0];
						//masterTemplate.ClearTimelines();
						masterTemplate.AddTimelines(timelineLib.GetBaseTimelinesFromLibrary(this.currentAnimationIndex));
						masterTemplate.SetElementDepthLayout(layerInfoDict[currentCharacter.GetName()][currentAnimationName]);
						masterTemplate.ImmediantLayoutUpdate();
						//masterTemplate.ResumePlayingAnimation();
					}
					//masterTemplate.HairFront.ChangeDisplayedSprite(0);
				}
				else if (keyPressed == Keyboard.W)
				{
					if (currentCharacter.GetID() != 1)
					{
						//Can crash if character isn't found, range error.
						currentCharacter = characterList[1];
						masterTemplate.AddTimelines(timelineLib.GetReplacementTimelinesToLibrary(this.currentAnimationIndex, currentCharacter.GetID(), "Standard"));
						masterTemplate.SetElementDepthLayout(layerInfoDict[currentCharacter.GetName()][currentAnimationName]);
						masterTemplate.ImmediantLayoutUpdate();
						//masterTemplate.ResumePlayingAnimation();
					}
					//masterTemplate["HairFront"].ChangeDisplayedSprite(1);
				}*/
				
				//Debugger
				if (keyPressed == Keyboard.S)
				{
					//mainStage.stop();
					backgroundMasterTimeline.stop();
					masterTemplate.StopAnimation();
				}
				else if (keyPressed == Keyboard.R)
				{
					backgroundMasterTimeline.play();
					//var bgTimelines:Array = backgroundMasterTimeline.getChildren(true, false);
					for each (var tl:TimelineLite in bgMasterTimelineChildren)
					{
						tl.play(0);
					}
					masterTemplate.ResumePlayingAnimation();
				}
				keyDownStatus[keyEvent.keyCode] = true;
			}
		}
		
		//Switches to a templated animation of a specified name
		private function SwitchTemplateAnimation(animationIndex:uint, bodyType:int):void
		{
			if (animationIndex >= animationNameIndexes.length || bodyType == -1) { return;}
			var animationName:String = animationNameIndexes[animationIndex];
			var currentCharacterName:String = currentCharacter.GetName();
			currentAnimationName = animationName;
			var bodyTypeString:String = basisBodyTypes[bodyType];

			
			//if(!timelineLib.DoesBaseTimelinesForAnimationExist(animationIndex))
			//{
				//return;
				//CreateTimelinesForCharacterAnimation(defaultCharacterName, animationIndex);
			//}
			//var defaultLayerInfo:Object = layerInfoDict[defaultCharacterName][animationName];
			/*var currentCharLayerInfo:Object = layerInfoDict[currentCharacterName][animationName];
			if (currentCharLayerInfo == null && currentCharacterName != defaultCharacterName)
			{
				currentCharLayerInfo = layerInfoDict[defaultCharacterName][animationName];
			}*/
			var currentCharAnimLayout:AnimationLayout = layerInfoDict[animationName][bodyTypeString];
			/*if (currentCharAnimLayout == null && currentCharacterName != defaultCharacterName)
			{
				currentCharAnimLayout = layerInfoDict[animationName][defaultCharacterName];
			}*/
			//masterTemplate.ChangeAnimation(currentCharLayerInfo, animationIndex, currentCharacter.GetID(), "Standard");
			masterTemplate.ChangeAnimation(currentCharAnimLayout, animationIndex, currentCharacter.GetID(), bodyTypeString);
			/*masterTemplate.SetElementDepthLayout(currentCharLayerInfo);
			
			masterTemplate.ChangeBaseTimelinesUsed(animationIndex);
			
			if (currentCharacter != defaultCharacter)
			{
				if (timelineLib.DoesCharacterSetExists(animationIndex, currentCharacter.GetID(), "Standard"))
				{
					masterTemplate.AddTimelines(timelineLib.GetReplacementTimelinesToLibrary(animationIndex, currentCharacter.GetID(), "Standard"));
				}
			}
			
			masterTemplate.ImmediantLayoutUpdate();*/
			
			animationDuration = masterTemplate.GetDurationOfCurrentAnimation();
			CONFIG::debug
			{
				devMenuSignaller2.dispatch("animationDuration", animationDuration);
			}
			currentAnimationIndex = animationIndex;
		}
		
		[Inline]
		final public function SwitchCharacter(charId:int):void
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
			var character:Character = new characterClass;
			character.SetID(characterList.length);
			if (characterList.length == 0)
			{
				defaultCharacter = character;
				defaultCharacterName = character.GetName();
			}
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
		
		private function FinishedLoadingSWF(e:LoaderEvent):void
		{
			var mod:Mod = (e.target.content.rawContent as Mod);
			//Add the mod to the stage so the first frame function can get started, allowing the content to be ready to be used.
			addChild(mod);
			var modType:int = mod.GetModType();
			//If the mod type is an archive we'll need to iterate through the mod list it has and process them seperately
			if (modType == Mod.MOD_ARCHIVE)
			{
				var archive:ModArchive = mod as ModArchive;
				if (archive)
				{
					var archiveModList:Vector.<Mod> = archive.GetModsList();
					var childMod:Mod;
					for (var i:int = 0, l:int = archiveModList.length; i < l; ++i)
					{
						childMod = archiveModList[i];
						ProcessMod(childMod, modType);
					}
				}
				archive = null;
			}
			else
			{
				//A singular mod. Just need to process it.
				ProcessMod(mod, modType);
			}
			//remove the mod file.
			removeChild(mod);
			mod = null;
			//e.target.unload();
			//e.target.dispose();
		}
		
		/*Processes a mod and then adds it into ppppu. Returns true if mod was successfully added and false if a problem was encounter
		and the mod could not be added.*/
		private function ProcessMod(mod:Mod, modType:int):Boolean
		{
			if (modType == Mod.MOD_TEMPLATEANIMATION)
			{
				var animation:TemplateAnimationMod = mod as TemplateAnimationMod;
				if (animation)
				{
					var data:Vector.<Object> = animation.GetDataForTimelinesCreation();

					var timelines:Vector.<SerialTween> = new Vector.<SerialTween>();
					
					var displayOrderCommands:String = animation.GetDisplayOrderList();
					var displayLayout:Object = null;
					if (displayOrderCommands.length > 0)
					{
						displayLayout = JSON.parse(animation.GetDisplayOrderList());
					}
					
					var charName:String = animation.GetCharacterName();
					var animName:String = animation.GetAnimationName();
					var bodyName:String = animation.GetBodyTypeName();
					
					var animationIndex:int = animationNameIndexes.indexOf(animName);
					//Animations can not be added until the default character has their data for the particular animation loaded in.
					if (animationIndex == -1)
					{
						animationIndex = animationNameIndexes.length;
						animationNameIndexes[animationIndex] = animName;
						
						CONFIG::debug
						{
						devMenu.AddNewAnimation(animName);
						}
					}
					
					//If the layer info dictionary for the animation doesn't exist, create it.
					if (layerInfoDict[animName] == null) 
					{ layerInfoDict[animName] = new Dictionary(); }
					//If the layer info dictionary for the character doesn't exist, create it.
					//if (layerInfoDict[animName][charName] == null) 
					//{ layerInfoDict[animName][charName] = new Dictionary(); }
					//{ layerInfoDict[bodyName] = new Dictionary(); }
					//Set the layer info for an animation of the character
					//layerInfoDict[charName][animName] = displayLayout;
					
					
					//If animation is to be used as the basis, it might define a new body type.  
					if (animation.GetIfBasisTemplate() == true)
					{
						//bodyName is used to define the name of the body type in the case of a basis animation.
						//So check that the body type of the mod is not already in the basis body types list.
						if (basisBodyTypes.indexOf(bodyName) == -1)
						{
							
							basisBodyTypes[basisBodyTypes.length] = bodyName;
							CONFIG::debug
							{
							devMenu.AddNewBodyType(bodyName);
							}
							
							layerInfoDict[animName][bodyName] = ConvertLayoutObjectToAnimationLayout(displayLayout);
						}
					}
					else
					{
						if (layerInfoDict[animName][charName] == null && displayLayout != null)
						{
							layerInfoDict[animName][charName] = ConvertLayoutObjectToAnimationLayout(displayLayout);
						}
					}
					
					
					for (var i:int = 0, l:int = data.length; i < l; ++i)
					{
						timelines[timelines.length] = masterTemplate.CreateTimelineFromData(data[i], masterTemplate);
						//timelines[i].play();
						
					}
					if (animation.GetIfBasisTemplate() == true)
					{
						timelineLib.AddBaseTimelinesToLibrary(animationIndex, timelines);
					}
					else
					{
						timelineLib.
						/*var charID:int = -1;
						for (var x:int = 0, y:int = characterList.length; x < y; ++x)
						{
							if (charName == characterList[x].GetName())
							{
								charID = x; 
							}
						}
						timelineLib.AddReplacementTimelinesToLibrary(animationIndex, charID, "Standard", timelines);*/
					}
					return true;
				}
			}
			else if (modType == Mod.MOD_TEMPLATECHARACTER)
			{
				var tcharacter:TemplateCharacterMod = mod as TemplateCharacterMod;
				if (tcharacter)
				{
					var charName:String = tcharacter.GetCharacterName();
					CONFIG::debug
					{
					devMenu.AddNewCharacter(charName);
					}
				}
				
			}
			else if (modType == Mod.MOD_MUSIC)
			{
				var music:MusicMod = mod as MusicMod;
				if (music)
				{
					musicPlayer.AddMusic(music.GetMusicData(), music.GetName(), music.GetStartLoopTime(), music.GetEndLoopTime(), music.GetStartTime());
				}
			}
			else if (modType == Mod.MOD_ASSETS)
			{
				
			}
			return false;
		}
		
		private function ConvertLayoutObjectToAnimationLayout(entireLayoutObj:Object):AnimationLayout
		{
			if (entireLayoutObj == null) { return null;}
			var animLayout:AnimationLayout = new AnimationLayout();
			for (var frameKey:String in entireLayoutObj)
			{
				animLayout.AddNewFrameVector(parseFloat(frameKey), entireLayoutObj[frameKey], masterTemplate);
			}
			return animLayout;
		}
		CONFIG::debug
		{
		private function SetupDevMenuHooks():void
		{
			devMenuSignaller1.addSlot(devMenu);
			devMenuSignaller2.addSlot(devMenu);
		}
		
		private function AddNewLineToDevOutputWindow(message:String):void
		{
			devMenuSignaller1.dispatch(message);
		}
		}
		
		public function onSignal1(targetName:*):void
		{
			var target:String = targetName as String;
			if (target == "animPlayButton")
			{
				masterTemplate.ResumePlayingAnimation();
			}
			else if (target == "animPauseButton")
			{
				masterTemplate.StopAnimation();
			}
			else if (target.search(RegExp(/[+-]\d*.F/)) > -1)
			{
				var sign:int = target.charAt(0) == "-"? -1:1;
				target = target.substring(1, target.length -1);
				var frameAmount:int = int(target);
				var position:Number = masterTemplate.GetTimeInCurrentAnimation();
				position = roundToNearest(1.0 / stage.frameRate, position);
				position +=  (sign * frameAmount)*(1.0 / stage.frameRate);
				masterTemplate.JumpToPosition(position);
				devMenuSignaller2.dispatch("timeText",masterTemplate.GetTimeInCurrentAnimation());
			}
		}
		
		public function onSignal2(targetName:*, value:*):void
		{
			/*if (targetName == "animationSelector")
			{
				SwitchTemplateAnimation(value);
				devMenuSignaller2.dispatch("elementSelector", timelineLib.GetBaseTimelinesFromLibrary(value));
			}*/
			if (targetName == "setAnimationButton")
			{
				//value is expected to be an array with 3 values; animation index, body type index, and character index.
				if (value[0] == value[1] == -1)
				{
					return;
				}
				
				SwitchTemplateAnimation(value[0], value[1]);
			}
			else if (targetName == "setFrameButton")
			{
				
				masterTemplate.JumpToPosition(value * (1.0 / stage.frameRate));
				//masterTemplate.ResumePlayingAnimation();
			}
			else if (targetName == "setAnimationTime")
			{
				masterTemplate.JumpToPosition(value);
			}
			else if (targetName == "characterSelector")
			{
				SwitchCharacter(value);
			}
		}
		function roundToNearest(roundTo:Number, value:Number):Number{
			return Math.round(value/roundTo)*roundTo;
		}
	}

}