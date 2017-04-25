package  
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
	import adobe.utils.CustomActions;
	import animations.AnimateShard;
	import animations.AnimateShardLibrary;
	import animations.AnimationLayout;
	import animations.AnimationList;
	import animations.Director;
	import animations.ExchangeableBackground;
	import animations.TimelineLibrary;
	import com.greensock.loading.BinaryDataLoader;
	import com.jacksondunstan.signals.*;
	import flash.system.System;
	import menu.DeveloperMenu;
	import menu.MainMenu;
	import modifications.AnimateShardMod;
	import modifications.AnimationMod;
	import animations.background.*;
	import modifications.AssetsMod;
	import modifications.BackgroundAssetMod;
	import modifications.TemplateAnimationMod;
	import modifications.TemplateCharacterMod;
	import mx.utils.StringUtil;
	import org.libspark.betweenas3.BetweenAS3;
	import org.libspark.betweenas3.core.tweens.groups.ParallelTween;
	import org.libspark.betweenas3.core.tweens.groups.SerialTween;
	//import animations.background.BacklightTimelineData;
	//import animations.background.InnerDiamondTimelineData;
	//import animations.background.OuterDiamondTimelineData;
	//import animations.background.TransitionDiamondTimelineData;
	import animations.TimelineDefinition;
	import characters.*;
	import characters.Character;
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
	import audio.MusicPlayer;
	import animations.Canvas;
	import flash.ui.Keyboard;
	import flash.utils.*;
	
	/**
	 * Responsible for all the various aspects of ppppuNX. 
	 * @author ppppuProgrammer
	 */
	public class AppCore extends Sprite implements Slot1, Slot2
	{
		//Holds all the timelines to be used in the program.
		//private var timelineLib:TimelineLibrary = new TimelineLibrary();
		
		
		private var shardLib:AnimateShardLibrary = new AnimateShardLibrary();
		
		
		//A movie clip that holds all the body elements used to create an animation. This is to be a reference to a canvas instance created in the main stage (this is done for performance reasons, performance tanks if the canvas was created in as3.)
		private var canvas:Canvas;// = new MasterTemplate();
		//
		//private var director:Director;
		//Responsible for holding the various timelines that will be added to a template. This dictionary is 3 levels deep, which is expressed by: timelineDict[Animation][Character][Part]
		//private var timelinesDict:Dictionary = new Dictionary();
		
		
		
		private var layerInfoDict:Dictionary = new Dictionary();
		private var animInfoDict:Dictionary = new Dictionary();
		//Main Stage is the movie clip where a major of the graphics are displayed
		public var mainStage:MainStage;
		//Keeps track of what keys were pressed and/or held down
		private var keyDownStatus:Array = [];
		//Contains the names of the various animations that the master template can switch between. The names are indexed by their position in the vector.
		private var animationNameIndexes:Vector.<String> = new Vector.< String > ();// ["Cowgirl", "LeanBack", "LeanForward", "Grind", "ReverseCowgirl", "Paizuri", "Blowjob", "SideRide", "Swivel", "Anal"];
		//private var basisBodyTypes:Vector.<String> = new Vector.<String>();
		private var characterManager:CharacterManager;
		
		private var characterList:Vector.<Character> = new Vector.<Character>();//[new PeachCharacter, new RosalinaCharacter];
		private var currentCharacter:Character;// = defaultCharacter;
		//private var currentAnimationIndex:int = -1;
		public var currentAnimationName:String = "None";
		//private var embedTweenDataConverter:TweenDataParser = new TweenDataParser();
		
		//private var musicPlayer:ppppu.MusicPlayer = new ppppu.MusicPlayer();
		//private var charVoiceSystem:SoundEffectSystem;
		
		//private var playSounds:Boolean = false;
		
		
		//public var characterList:Vector.<Character> = new Vector.<Character>();
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
		
		//private var startupLoader:LoaderMax = new LoaderMax( { name:"Startup", onComplete:StartupLoadsComplete, onChildComplete:FinishedLoadingSWF } );
		private var colorizer:Colorizer = new Colorizer();
		
		private var mainMenu:MainMenu;
		
		CONFIG::debug
		private var devMenu:DeveloperMenu;// = new menu.DeveloperMenu();

		private var menuSignal1:Signal1 = new Signal1();
		private var menuSignal2:Signal2 = new Signal2();
		
		private var modsLoadedAtStartUp:Array;
		
		private var graphicSets:Dictionary = new Dictionary();
		
		//Constructor
		public function AppCore() 
		{
			//Create the "main stage" that holds the character template and various other movieclips such as the transition and backlight 
			mainStage = new MainStage();
			mainStage.Backlight.visible = mainStage.OuterDiamond.visible = mainStage.InnerDiamond.visible = 
			mainStage.TransitionDiamond.visible = mainStage.DisplayArea.visible = mainStage.Compositor.visible = false;
			
			//mainStage.stop();
			//Hide the master template until everything is initialized
			//mainStage.Compositor.visible = false;
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
			canvas = mainStage.Compositor;
			//canvas = new Canvas;
			
			//mainStage.addChild(canvas);
			
			
			//director = new Director(colorizer);
			//startupLoader.autoLoad = true;
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
		public function Initialize(startupMods:Array = null):void
		{
			characterManager = new CharacterManager();
			var director:Director = new Director(colorizer);
			canvas.Initialize(shardLib, director);
			//Add the key listeners
			//TODO: Re-enable when done testing menus
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyPressCheck);
			stage.addEventListener(KeyboardEvent.KEY_UP, KeyReleaseCheck);
			
			//Add the characters
			//AddCharacter(PeachCharacter);
			//AddCharacter(RosalinaCharacter);
			
			/*CONFIG::TweenLib == "GSAP"
			{
			//Initializing plugins for the GSAP library
			TweenPlugin.activate([FramePlugin, FrameLabelPlugin, TransformMatrixPlugin, VisiblePlugin, ColorTransformPlugin]);
			//Set the default Ease for the tweens
			TweenLite.defaultEase = Linear.ease;
			TweenLite.defaultOverwrite = "none";
			}*/
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
			canvas.mouseChildren = false;
			canvas.mouseEnabled = false;
			
			//AddCharacter(PeachCharacter);
			
			//masterTemplate.currentCharacter = defaultCharacter;
			
			mainStage.x = (stage.stageWidth - mainStage.DisplayArea.width) / 2;	
			CONFIG::debug
			{
				mainStage.x = 0;	
			}
			//animInfoDict["Cowgirl"] = new CowgirlInfo();
			
			//Switch the first animation.
			//SwitchTemplateAnimation(0);
			//SwitchTemplateAnimation(8);
			
			//menu = new ppppuMenu(masterTemplate);
			//menu.ChangeSlidersToCharacterValues(currentCharacter);
			//addChild(menu);
			
			//charVoiceSystem = new SoundEffectSystem();
			
			//Set timelines up for background elements.
			var bg:Array = [];
			bg.push(canvas.CreateTimelineForSprite(new BacklightTimelineData().GetTimelineData(), mainStage));
			bg.push(canvas.CreateTimelineForSprite(new InnerDiamondTimelineData().GetTimelineData(), mainStage));
			bg.push(canvas.CreateTimelineForSprite(new OuterDiamondTimelineData().GetTimelineData(), mainStage));
			bg.push(canvas.CreateTimelineForSprite(new TransitionDiamondTimelineData().GetTimelineData(), mainStage));
			backgroundMasterTimeline = BetweenAS3.parallelTweens(bg) as ParallelTween;
			backgroundMasterTimeline.stopOnComplete = false;
			
			var planetBGMod:BackgroundAssetMod = new BackgroundAssetMod(new PlanetBackground, "Standard", "Background", null);
			var outerBGMod:BackgroundAssetMod = new BackgroundAssetMod(new OuterDiamondBG, "Standard", "OuterDiamond", null);
			
			var innerBGMod:BackgroundAssetMod = new BackgroundAssetMod(new InnerDiamondBG, "Standard", "InnerDiamond", null);
			var transitionBGMod:BackgroundAssetMod = new BackgroundAssetMod(new TransitionDiamondBG, "Standard", "TransitionDiamond", null);
			var lightBGMod:BackgroundAssetMod = new BackgroundAssetMod(new Light, "Standard", "Backlight", null);
			ProcessMod(planetBGMod);
			ProcessMod(outerBGMod);
			ProcessMod(innerBGMod);
			ProcessMod(transitionBGMod);
			ProcessMod(lightBGMod);
			mainStage.InnerDiamond.SelectBackgroundAsset(0);
			mainStage.OuterDiamond.SelectBackgroundAsset(0);
			mainStage.TransitionDiamond.SelectBackgroundAsset(0);
			//mainStage.Background.SelectBackgroundAsset(0);
			mainStage.Backlight.SelectBackgroundAsset(0);
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
			//musicPlayer.SetUpdateRate(stage.frameRate);
			
			//(loader as AnimationInfo).GetDataForTimelinesCreation();
			//var animation:AnimationInfo = (loader as AnimationInfo);
			//animation.GetDataForTimelinesCreation();
			//Test purposes
			
			//
			//masterTemplate.PlayAnimation(0);
			//mainStage.play();
			
			registerClassAlias("AnimationList", animations.AnimationList);
			
			
			
			//CONFIG::debug
			//{
				//devMenu = new DeveloperMenu(this, director);
				//devMenu.x = 480;
				//addChild(devMenu);
				////devMenu.SetupHooksToApp(this);
				//SetupDevMenuHooks();
				
			//}
			mainMenu = new MainMenu(this, director);
			mainMenu.x = 480;
			//addChild(mainMenu);
			
			modsLoadedAtStartUp = startupMods;
		}
		
		private function ProcessStartupMods():void
		{
			if (modsLoadedAtStartUp != null)
			{
				var startupModNum:int = modsLoadedAtStartUp.length;
				for (var i:int = 0; i < startupModNum; ++i)
				{
					try
					{
						var successfulModAdd:Boolean = ProcessMod(modsLoadedAtStartUp[i]);
						if (successfulModAdd == false)
						{
							//logger.warn("Mod that could not be added: " + startupMods[i].UrlLoadedFrom);
						}
					}
					catch (e:Error)
					{
						//logger.error("Failed to load " + getQualifiedClassName(startupMods[i]) + "\nCall stack:\n" + e.getStackTrace());
					}
					finally
					{
						modsLoadedAtStartUp[i] = null;
					}
				}
			}
			modsLoadedAtStartUp = null;
			mainStage.addEventListener(Event.ENTER_FRAME, RunLoop);
		}
		
		//The "heart beat" of the flash. Ran every frame to monitor and react to certain, often frame sensitive, events
		private function RunLoop(e:Event):void
		{

			if (firstTimeInLoop)
			{
				System.pauseForGCIfCollectionImminent(1);
				System.pauseForGCIfCollectionImminent(1);
				//SwitchCharacter(0);
				//SwitchTemplateAnimation(0);
				//backgroundMasterTimeline.gotoAndPlay(0);
				//var bgTimelines:Array = backgroundMasterTimeline.getChildren(true, false);
				/*for each (var tl:TimelineLite in bgMasterTimelineChildren)
				{
					tl.play(0);
				}*/
				//masterTemplate.PlayAnimation(0);
				canvas.visible = true;
				firstTimeInLoop = false;
				//previousUpdateTime = backgroundMasterTimeline.position;// .totalTime();//(getTimer() / 1000.0);
				ppppuRunTimeCounter = 0;
				
				//musicPlayer.PlayMusic(musicPlayer.GetIdOfMusicByName(currentCharacter.GetDefaultMusicName()));

				//trace("bg:" + backgroundMasterTimeline.time() + " char:" +masterTemplate.GetTimeInCurrentAnimation() + " run: " + ppppuRunTimeCounter);
			}

				var animationPosition:Number = canvas.Update();
				CONFIG::debug
				{
					menuSignal2.dispatch("timeText", animationPosition);
					menuSignal2.dispatch("updatedAnimation", canvas);
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
		
		/*private function StartupLoadsComplete(e:LoaderEvent):void
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
					//SwitchTemplateAnimation(randomAnimIndex);
					canvas.PlayAnimation(-1);
				}
				else if((!(Keyboard.NUMBER_0 > keyPressed) && !(keyPressed > Keyboard.NUMBER_9 )) ||  (!(97 > keyPressed) && !(keyPressed > 105)))
				{
					//keypress of 1 has a keycode of 49
					if(keyPressed > 96)
					{
						keyPressed = keyPressed - 48;
					}
					/*if (timelineLib.DoesBaseTimelinesForAnimationExist(keyPressed - 49))
					{
					//SwitchTemplateAnimation(keyPressed - 49);
					}*/
					canvas.PlayAnimation(0);
				}
				
				if (keyPressed == Keyboard.UP)
				{
					DEBUG_playSpeed += .05;
					canvas.ChangePlaySpeed(DEBUG_playSpeed);
				}
				else if (keyPressed == Keyboard.DOWN)
				{
					DEBUG_playSpeed -= .05;
					canvas.ChangePlaySpeed(DEBUG_playSpeed);
					//ScaleFromCenter(//mainStage.DisplayArea, //mainStage.DisplayArea.scaleX - .05, //mainStage.DisplayArea.scaleY - .05);
				}
				
				
				
				//Debugger
				if (keyPressed == Keyboard.S)
				{
					//mainStage.stop();
					backgroundMasterTimeline.stop();
					canvas.StopAnimation();
				}
				else if (keyPressed == Keyboard.R)
				{
					backgroundMasterTimeline.play();
					//var bgTimelines:Array = backgroundMasterTimeline.getChildren(true, false);
					for each (var tl:TimelineLite in bgMasterTimelineChildren)
					{
						tl.play(0);
					}
					canvas.ResumePlayingAnimation();
				}
				keyDownStatus[keyEvent.keyCode] = true;
			}
		}
		
		[Inline]
		final public function SwitchCharacter(charId:int):void
		{
			if (charId >= 0 && charId < characterList.length)
			{
				currentCharacter = characterList[charId];
				var charData:Object = currentCharacter.data;
				if ("Color" in charData)
				{
					colorizer.ChangeColorsUsingCharacterData(charData.Color);
				}
				if ("GraphicSets" in charData)
				{
					canvas.ChangeGraphicSets(charData.GraphicSets);
				}
				//canvas.ApplyShardOverrides();
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
			/*if (characterList.length == 0)
			{
				defaultCharacter = character;
				defaultCharacterName = character.GetName();
			}*/
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
		
		/*private function FinishedLoadingSWF(e:LoaderEvent):void
		{
			var mod:Mod = (e.target.content.rawContent as Mod);
			//Add the mod to the stage so the first frame function can get started, allowing the content to be ready to be used.
			addChild(mod);
			ProcessMod(mod);
			//remove the mod file.
			removeChild(mod);
			mod = null;
			//e.target.unload();
			//e.target.dispose();
		}*/
		
		/*Processes a mod and then adds it into ppppu. Returns true if mod was successfully added and false if a problem was encounter
		and the mod could not be added.*/
		private function ProcessMod(mod:Mod):Boolean
		{
			//var modClassName:String = getQualifiedClassName(mod);
			var addedMod:Boolean = false;
			if (mod == null)
			{
				//logger.warn(modClassName + " is not a ppppuXi mod!");
				return addedMod;
			}
			
			var modType:int = mod.GetModType();
			
			if (modType == Mod.MOD_TEMPLATECHARACTER)
			{
				var tcharacter:TemplateCharacterMod = mod as TemplateCharacterMod;
				if (tcharacter)
				{
					var charName:String = tcharacter.GetCharacterName();
					var character:Character = new Character(charName, tcharacter.GetCharacterData(), true);
					if (characterManager.CheckIfCharacterCanBeAdded(character))
					{
						characterManager.AddCharacter(character);
						menuSignal2.dispatch("AddNewCharacter", character.GetName());
					}
					//characterList[characterList.length] = character;
					//CONFIG::debug
					//{
						
					//devMenu.AddNewCharacter(charName);
					//}
				}
				
			}
			else if (modType == Mod.MOD_ANIMATESHARD)
			{
				var shardMod:AnimateShardMod = mod as AnimateShardMod;
				if (shardMod)
				{
					var animationName:String = shardMod.GetTargetAnimationName();
					var animationIndex:int = animationNameIndexes.indexOf(animationName);
					if (animationIndex == -1)
					{
						animationIndex = animationNameIndexes.length;
						animationNameIndexes[animationIndex] = animationName;
						
						//CONFIG::debug
						//{
						menuSignal2.dispatch("AddNewAnimation", animationName);
						//devMenu.AddNewAnimation(animationName);
						//}
					}
					
					var timelines:Vector.<SerialTween> = new Vector.<SerialTween>();
					var data:Vector.<Object> = shardMod.GetTimelineConstructionData();
					for (var i:int = 0, l:int = data.length; i < l; ++i)
					{
						timelines[timelines.length] = canvas.CreateTimelineForActor(data[i]);
						if (timelines[timelines.length-1] == null)
						{
							CONFIG::debug
							{
							menuSignal1.dispatch("Animation " + animationName + ": Could not create timeline for element " + data[i].targetName);
							}
						}
					}
					var shard:AnimateShard = new AnimateShard(timelines, shardMod.GetDisplayObjectOrders());
					var shardAddResult:Boolean = shardLib.AddShardToLibrary(animationIndex, shard, shardMod.GetShardName(), shardMod.GetIfBaseShard());
					
					if (!shardAddResult)
					{
						trace("Can not add shard \"" + shardMod.GetShardName() + "\" for animation " + animationNameIndexes[animationIndex] + " (id " + animationIndex +")");
					}
					
					
					var categories:Vector.<String> = shardMod.GetCategories();
					var categoriesStr:String = "";
					for (var i:int = 0, l:int = categories.length; i < l; i++) 
					{
						categoriesStr += categories[i];
						if(i+1 < l){categoriesStr += ", "}
					} 
					
					
					//construct the info text for the shard.
					var shardInfo:String = StringUtil.substitute("Categories:  {0}\nDescription: {1}", categoriesStr, shardMod.GetDescription());
					shardLib.SetInformationForShard(shard, shardInfo);
				}
			}
			else if (modType == Mod.MOD_MUSIC)
			{
				var music:MusicMod = mod as MusicMod;
				if (music)
				{
					//musicPlayer.AddMusic(music.GetMusicData(), music.GetName(), music.GetStartLoopTime(), music.GetEndLoopTime(), music.GetStartTime());
				}
			}
			else if (modType == Mod.MOD_ASSET)
			{
				var assetMod:AssetsMod = mod as AssetsMod;
				if (assetMod)
				{
					var assetData:AssetData = new AssetData(assetMod.setName, assetMod.asset, assetMod.layer, assetMod.data);
					canvas.AddAssetToActor(assetMod.targetActorName, assetData);
					CONFIG::debug
					{
						//devMenu.AddNewGraphicSet(assetMod.setName);
					}
					//Handle colorable data now <- scratch that, Actors should send a command to have assets with Colorable data be added for colorization.
					/*if (assetData.properties != null)
					{
						if ("Colorable" in assetData.properties)
						{
							var colorableData:Object = assetData.properties.Colorable;
							if (colorableData != null)
							{
								colorizer.AddColorizeData(assetData.asset,colorableData);
							}
						}
					}*/
					
					//For graphic sets this needs to be changed. Assets should be added to a graphic set. To be used the Actor necessary for the asset needs to be added and that will be handled when a timeline is created.
					/*if (canvas.AddNewSpriteInstance(assetMod.asset, assetMod.assetName))
					{
						addedMod = true;
						//Asset was added, so can see if it had additional data and make use of it
						if (assetMod.data != null)
						{
							if ("Colorable" in assetMod.data)
							{
								var colorableData:Object = assetMod.data.Colorable;
								if (colorableData != null)
								{
									colorizer.AddColorizeData(assetMod.asset,colorableData);
								}
							}
						}
					}*/
				}
				
				else
				{
					trace("Failed to add asset: " + assetMod.setName + ", " + assetMod.asset);
				}
			}
			else if (modType == Mod.MOD_BACKGROUNDASSET)
			{
				var bgAsset:BackgroundAssetMod = mod as BackgroundAssetMod;
				if (bgAsset)
				{
					if (bgAsset.asset && bgAsset.assetName && bgAsset.assetName.length > 0)
					{
						bgAsset.name = bgAsset.assetName;
						var targetExBg:ExchangeableBackground = mainStage.getChildByName(bgAsset.targetSpriteName) as ExchangeableBackground;
						if (targetExBg)
						{
							if (targetExBg.AddNewBackgroundAsset(bgAsset.asset))
							{
								if (bgAsset.properties && "Colorable" in bgAsset.properties)
								{
									colorizer.AddColorizeData(bgAsset.asset, bgAsset.properties.Colorable);
								}
							}
						}
					}
				}
			}
			else if (modType == Mod.MOD_SOUNDASSET)
			{
				
			}
			/*else if (modType == Mod.MOD_GRAPHICSET)
			{
				var graphicSet:GraphicSetMod = mod as GraphicSetMod;
				if (graphicSet)
				{
					var gfxSet:GraphicSet = new GraphicSet();
					var assetData:Array;
					for (var j:int = 0, k:int = graphicSet.setData.length; j < k; j++) 
					{
						assetData = graphicSet.setData[j];
						var assetProperties:Object = assetData[3] as Object;
						if (gfxSet.AddAssetToSet(assetData[0] as Sprite, assetData[1] as String, assetData[2] as int, assetProperties))
						{
							//New graphic asset was added to the set, now can see if there was colorable data.
							if (assetProperties != null)
							{
								if ("Colorable" in assetProperties)
								{
									var colorableData:Object = assetProperties.Colorable;
									if (colorableData != null)
									{
										colorizer.AddColorizeData(assetData[0] as Sprite, colorableData);
									}
								}
							}
						}
					}
					if (!(graphicSet.setName in graphicSets))
					{
						graphicSets[graphicSet.setName] = gfxSet;
						CONFIG::debug
						{
							//devMenu.AddNewGraphicSet(graphicSet.setName);
						}
					}
					
				}
			}*/
			//If the mod type is an archive we'll need to iterate through the mod list it has and process them seperately
			else if (modType == Mod.MOD_ARCHIVE)
			{
				var archive:ModArchive = mod as ModArchive;
				if (archive)
				{
					
					//logger.info("\t* Processing archive mod: " + modClassName + "*");
					var archiveModList:Vector.<Mod> = archive.GetModsList();
					var childMod:Mod;
					var	numArchMods:int = archiveModList.length;	//SMLSE OPTIMIZE ATTEMPT
					for (var i:int = 0; i < numArchMods; ++i)
					{
						childMod = archiveModList[i];
						ProcessMod(childMod);
					}
					addedMod = true;
					//logger.info("\t* Finished processing archive mod " + modClassName + "*");
				}
				else 
				{
					//logger.error(modClassName + " was not a valid archive mod.");
				}
			}
			mod.Dispose();
			mod = null;
			return addedMod;
		}
		
		/*private function ConvertLayoutObjectToAnimationLayout(entireLayoutObj:Object):AnimationLayout
		{
			if (entireLayoutObj == null) { return null;}
			var animLayout:AnimationLayout = new AnimationLayout();
			for (var frameKey:String in entireLayoutObj)
			{
				animLayout.AddNewFrameVector(parseFloat(frameKey), entireLayoutObj[frameKey], masterTemplate);
			}
			return animLayout;
		}*/
		//CONFIG::debug
		//{
		public function SetupMenuHooks(target1:Slot1=null, target2:Slot2=null):void
		{
			if (target1 != null)
			{
				menuSignal1.addSlot(target1);
			}
			if (target2 != null)
			{
				menuSignal2.addSlot(target2);
			}
		}
		
		/*private function AddNewLineToDevOutputWindow(message:String):void
		{
			devMenuSignaller1.dispatch(message);
		}
		}*/
		
		public function onSignal1(targetName:*):void
		{
			var target:String = targetName as String;
			if (target == "animPlayButton")
			{
				canvas.ResumePlayingAnimation();
				backgroundMasterTimeline.gotoAndPlay(canvas.GetTimeInCurrentAnimation());
			}
			else if (target == "animPauseButton")
			{
				canvas.StopAnimation();
				backgroundMasterTimeline.stop();
			}
			else if (target.search(RegExp(/[+-]\d*.F/)) > -1)
			{
				var sign:int = target.charAt(0) == "-"? -1:1;
				target = target.substring(1, target.length -1);
				var frameAmount:int = int(target);
				var position:Number = canvas.GetTimeInCurrentAnimation();
				position = roundToNearest(1.0 / stage.frameRate, position);
				position +=  (sign * frameAmount)*(1.0 / stage.frameRate);
				canvas.JumpToPosition(position);
				backgroundMasterTimeline.gotoAndStop(position);
				menuSignal2.dispatch("timeText",canvas.GetTimeInCurrentAnimation());
			}
			else if (target == "MenuFinishedInitializing")
			{
				this.ProcessStartupMods();
			}
		}
		
		public function onSignal2(targetName:*, value:*):void
		{
			/*if (targetName == "animationSelector")
			{
				SwitchTemplateAnimation(value);
				devMenuSignaller2.dispatch("elementSelector", timelineLib.GetBaseTimelinesFromLibrary(value));
			}*/
			/*if (targetName == "setAnimationButton")
			{
				//value is expected to be an array with 3 values; animation index, body type index, and character index.
				if ((value[0] as int) == (value[1] as int) == -1)
				{
					return;
				}
				
				SwitchTemplateAnimation(value[0] as uint, value[1] as int);
			}
			else */if (targetName == "setFrameButton")
			{
				var position:Number = (value as int) * (1.0 / stage.frameRate);
				canvas.JumpToPosition(position);
				backgroundMasterTimeline.gotoAndStop(position);
				//masterTemplate.ResumePlayingAnimation();
			}
			else if (targetName == "setAnimationTime")
			{
				canvas.JumpToPosition(value as Number);
				backgroundMasterTimeline.gotoAndStop(value as Number);
			}
			else if (targetName == "characterSelector")
			{
				SwitchCharacter(value as int);
				
			}
			else if (targetName == "shardTypeSelector" || targetName == "animationSelector")
			{
				//CONFIG::debug
				//{
					menuSignal2.dispatch("UpdateShardsCombobox", shardLib.GetListOfShardNames(value[0] as int, value[1] as Boolean));
				//devMenu.UpdateShardsCombobox(shardLib.GetListOfShardNames(value[0] as int, value[1] as Boolean));
				//}
			}
			else if (targetName == "shardSelector")
			{
				var shard:AnimateShard = shardLib.GetShard(value[0] as int, value[1] as Boolean, value[2] as String);
				//menuSignal2.dispatch("SetSelectedShard", shard);
				menuSignal2.dispatch("SetShardDescription", /*[shard,*/ shardLib.GetInformationOnShard(shard)/*]*/);
				
				////devMenu.SetSelectedShard(shard);
				////devMenu.set
			}
			else if (targetName == "CompileAnimationFromAnimationList")
			{
				//Compiles an animation by using an animation list. Goes through the list and builds a vector of shards then passes the vector to the canvas.
				//Value is an animation list.
				var animList:AnimationList = value as AnimationList;
				//Make sure animation list exists and is the supported version of the list for the program.
				if (animList)
				{
					var animationId:int = animationNameIndexes.indexOf(animList.TargetAnimationName);
					var shardsForAnimation:Vector.<AnimateShard> = shardLib.GetListOfShards(animationId, animList.ShardNameList, animList.ShardTypeList);
					canvas.CompileAnimation(shardsForAnimation, animList.TargetAnimationName);
					backgroundMasterTimeline.gotoAndStop(canvas.GetTimeInCurrentAnimation());
					var animationDuration:Number = canvas.GetDurationOfCurrentAnimation();
					//CONFIG::debug
					//{
						menuSignal2.dispatch("animationDuration", animationDuration);
					//}
				}
			}
			/*else if (targetName == "UpdateGraphicSetsUsed")
			{
				var gfxSetNames:Vector.<String> = value as Vector.<String>;
				var setsToUse:Vector.<GraphicSet> = new Vector.<GraphicSet>();
				for (var j:int = 0, k:int = gfxSetNames.length; j < k; j++) 
				{
					if (graphicSets[gfxSetNames[j]] != null)
					{
						setsToUse[setsToUse.length] = graphicSets[gfxSetNames[j]];
					}
				}
				canvas.ChangeGraphicSetsUsed(setsToUse);
			}*/
			else if (targetName == "ProcessAnimationList")
			{
				//Used when an animation list is loaded from file to populate the list of set shards in the developer/edit menu.
				var list:AnimationList = value as AnimationList;
				if (list)
				{
					//Check if the animation list is a version compatible with the latest project build. Refuse to process it if it isn't.
					if (list.version != AnimationList.ANIMATION_LIST_VERSION) { return; }
					
					var names:Vector.<String> = list.ShardNameList;
					var types:Vector.<Boolean> = list.ShardTypeList;
					var animationId:int = animationNameIndexes.indexOf(list.TargetAnimationName);
					if (animationId == -1) { return; }
					
					//Arrays hold the following in order: shard name, shard type, shard
					var shardsData:Vector.<Array> = new Vector.<Array>();
					var shard:AnimateShard;
					for (var i:int = 0, l:int = Math.min(names.length, types.length); i < l; i++) 
					{
						//Verify that the shard exists
						shard = shardLib.GetShard(animationId, (types[i] as Boolean/* == "Base"*/)/* ? true : false*/, names[i]);
						if (shard)
						{
							shardsData[shardsData.length] = [names[i], types[i]/*, shard*/];
						}
					}
					menuSignal2.dispatch("SetupShardsList", shardsData);
				}
			}
			else if (targetName == "CharMenu_SwitchCharacterRequest")
			{
				characterManager.SwitchToCharacter(characterManager.GetCharacterIdByName(value as String), true);
				colorizer.ChangeColorsUsingCharacterData(characterManager.GetCurrentCharacterColorData());
				canvas.ChangeActorAssetsUsingCharacterData(characterManager.GetCurrentCharacterGraphicSets());
				menuSignal2.dispatch("CharMenu_CharacterInfoDelivery", characterManager.GetCharacterInfo(value as String));
			}
			else if (targetName == "FileLoaded")
			{
				//Things may happen here but for now they don't.
				
			}
		}
		function roundToNearest(roundTo:Number, value:Number):Number{
			return Math.round(value/roundTo)*roundTo;
		}
	}

}