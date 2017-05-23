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
	import animations.*;
	import animations.background.*;
	import menu.*;
	import flash.display.*;
	import com.jacksondunstan.signals.*;
	import flash.events.*;
	import modifications.*;
	import characters.*;
	import org.libspark.betweenas3.core.tweens.groups.ParallelTween;
	import org.libspark.betweenas3.core.tweens.groups.SerialTween;
	import flash.net.registerClassAlias;
	import flash.system.System;
	import flash.utils.*;
	import flash.ui.Keyboard;
	import mx.utils.StringUtil;
	import org.libspark.betweenas3.BetweenAS3;
	import flash.net.SharedObject;
	
	/**
	 * Responsible for all the various aspects of ppppuNX. 
	 * @author ppppuProgrammer
	 */
	public class AppCore extends Sprite implements Slot1, Slot2
	{		
		private var shardLib:AnimateShardLibrary = new AnimateShardLibrary();
		
		//A movie clip that holds all the body elements used to create an animation. This is to be a reference to a canvas instance created in the main stage (this is done for performance reasons, performance tanks if the canvas was created in as3.)
		private var canvas:Canvas;// = new MasterTemplate();
		
		
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
		
		//Counter to see just how long the flash has been running in milliseconds. Used for timing purposes such as controlling when to change characters.
		//public var ppppuRunTimeCounter:Number = 0;
		//private var previousUpdateTime:Number;
		//private var runTimer:Timer;
		private var firstTimeInLoop:Boolean = true;
		/*Timing*/
		private var totalRunTime:Number = 0;
		//Holds the value of how long the AVM was running from the latest completed run Loop execution 
		private var lastUpdateTime:Number = 0;
		//public var counter:int = 0;
		
		//Holds the duration of the master timeline contained in the master template. Used to avoid needing to call masterTemplate.GetDurationOfCurrentAnimation in the run loop.
		private var animationDuration:Number = 0;
		
		public var backgroundMasterTimeline:ParallelTween;
		public var bgMasterTimelineChildren:Array = new Array();
		
		//public var DEBUG_playSpeed:Number = 1.0;
		
		private var colorizer:Colorizer = new Colorizer();
		
		
		//Settings related
		public var settingsSaveFile:SharedObject = SharedObject.getLocal("ppppuNX_Settings", "/");
		
		private var mainMenu:MainMenu;
		
		//Indicates whether the program is in edit mode or play mode. Edit mode has the menus on screen. 
		private var menuModeActive:Boolean = false;
		
		
		public var userSettings:UserSettings = new UserSettings();
		
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
			
			//Hide the master template until everything is initialized
			addChild(mainStage);
			mainStage.stopAllMovieClips();
			canvas = mainStage.Compositor;

			
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
			//stage.scaleMode = StageScaleMode.NO_BORDER; 
			characterManager = new CharacterManager();
			var director:Director = new Director(this, colorizer);
			canvas.Initialize(shardLib, director);
			//Add the key listeners
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyPressCheck);
			stage.addEventListener(KeyboardEvent.KEY_UP, KeyReleaseCheck);

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
			
			mainStage.x = (stage.stageWidth - mainStage.DisplayArea.width) / 2;	
			
			//charVoiceSystem = new SoundEffectSystem();
			
			//Set timelines up for background elements.
			var bg:Array = [];
			bg.push(canvas.CreateTimelineForSprite(new BacklightTimelineData().GetTimelineData(), mainStage));
			bg.push(canvas.CreateTimelineForSprite(new InnerDiamondTimelineData().GetTimelineData(), mainStage));
			bg.push(canvas.CreateTimelineForSprite(new OuterDiamondTimelineData().GetTimelineData(), mainStage));
			bg.push(canvas.CreateTimelineForSprite(new TransitionDiamondTimelineData().GetTimelineData(), mainStage));
			backgroundMasterTimeline = BetweenAS3.parallelTweens(bg) as ParallelTween;
			//backgroundMasterTimeline.stopOnComplete = false;
			
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
			mainStage.Background.SelectBackgroundAsset(0);
			mainStage.Backlight.SelectBackgroundAsset(0);
			
			registerClassAlias("AnimationList", animations.AnimationList);
			
			modsLoadedAtStartUp = startupMods;
			
			LoadUserSettings();
			if(CONFIG::BuildMenu == true)
			{
				
				//Create the main menu. 
				mainMenu = new MainMenu();
				mainMenu.InitializeMainMenu(this, director);
				mainMenu.x = 480;
			}
			else
			{
				FinalPreparations();
				ChangeCharacter("Peach");
			}
			
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
			
		}
		
		//The "heart beat" of the flash. Ran every frame to monitor and react to certain, often frame sensitive, events
		private function RunLoop(e:Event):void
		{

			if (totalRunTime == 0)
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
				lastUpdateTime = getTimer();
				//previousUpdateTime = backgroundMasterTimeline.position;// .totalTime();//(getTimer() / 1000.0);
				//ppppuRunTimeCounter = 0;
				
				//musicPlayer.PlayMusic(musicPlayer.GetIdOfMusicByName(currentCharacter.GetDefaultMusicName()));

				//trace("bg:" + backgroundMasterTimeline.time() + " char:" +masterTemplate.GetTimeInCurrentAnimation() + " run: " + ppppuRunTimeCounter);
			}
			
			
			var animationPosition:Number = canvas.Update();				
			menuSignal2.dispatch("timeText", animationPosition);

			var currentUpdateTime:Number = getTimer();
			var difference:Number = (currentUpdateTime - lastUpdateTime);
			
			//if (int((totalRunTime + difference)/ 4000) > int(totalRunTime/4000))
			if(canvas.IsAnimationFinished())
			{
				if (!menuModeActive)
				{
					characterManager.CharacterSwitchLogic();
					
					var switchedCharsId:int = characterManager.GetIdOfCharacterToSwitchTo();
					if (switchedCharsId > -1)
					{
						userSettings.UpdateCurrentCharacterName(characterManager.GetCurrentCharacterName());
						ChangeCharacterById(switchedCharsId);
						//Make sure that there is no way for all accessible animations to be locked.
						characterManager.CheckLocksForCurrentCharacter(switchedCharsId);
						//mainMenu.SetCharacterSelectorAndUpdate(characterManager.GetIdOfCurrentCharacter());
						
					}
					
					/*Updates the menu to match the automatically selected animation. Do not call 
					MainMenu::SelectAnimation() as that is for user input and takes relative index of the list item,
					unlike the below code which uses the absolute index.*/
					//canvas.StopAnimation();
					var animId:int = characterManager.GetCurrentAnimationIdOfCharacter();
					CompileAndSwitchAnimation(characterManager.GetAnimationListForCurrentCharacter(animId));
					canvas.PlayAnimation(0);
				}
			}
			totalRunTime += difference;
			lastUpdateTime = currentUpdateTime;
			
			
			//
			//canvas.CompileAnimation(characterManager.GetAnimationListForCurrentCharacter(animId), animationNameIndexes[animId]);
			//Need to get the index that targets the given animation id. 
			//var currentCharacterIdTargets:Vector.<int> = characterManager.GetIdTargetsOfCurrentCharacter();
			//var target:int = currentCharacterIdTargets.indexOf(animId);
			//mainMenu.UpdateAnimationIndexSelected(target, charsWereSwitched);
			
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
					canvas.PlayAnimation(0);
				}
				
				if (keyPressed == Keyboard.SPACE)
				{
					ToggleMenuMode();
					
				}
				
				
				
				//Debugger
				/*if (keyPressed == Keyboard.S)
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
				}*/
				keyDownStatus[keyEvent.keyCode] = true;
			}
		}
		
		/*[Inline]
		final public function SwitchCharacter(charId:int):void
		{
			if (charId >= 0 && charId < characterList.length)
			{
				currentCharacter = characterList[charId];
				userSettings.currentCharacterName = currentCharacter.GetName();
				var charData:Object = currentCharacter.data;
				if ("Color" in charData)
				{
					colorizer.ChangeColorsUsingCharacterData(charData.Color);
				}
				if ("GraphicSets" in charData)
				{
					canvas.ChangeGraphicSets(charData.GraphicSets);
				}
			}
		}*/
		
		private function ToggleMenuMode():void
		{
			menuModeActive = !menuModeActive;
			if (menuModeActive)
			{
				mainStage.x = 0;	
				addChild(mainMenu);
				//stage.focus = mainMenu;
			}
			else
			{
				mainStage.x = (stage.stageWidth - mainStage.DisplayArea.width) / 2;	
				removeChild(mainMenu);
				stage.focus = null;
			}
		}
		
		/*public function GetListOfCharacterNames():Vector.<String>
		{
			var charNameVector:Vector.<String> = new Vector.<String>();
			for (var i:int = 0, l:int = characterList.length; i < l; ++i)
			{
				charNameVector[i] = characterList[i].GetName();
			}
			return charNameVector;
		}*/
		
		public function GetListOfAnimationNames():Vector.<String>
		{
			return animationNameIndexes;
		}

		
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
					
					var presetAnimationData:Vector.<Array> = tcharacter.GetPresetAnimations();
					var charPresetAnimations:Vector.<AnimationList> = new Vector.<AnimationList>();
					for (var j:int = 0, k:int = presetAnimationData.length; j < k; j++) 
					{
						var dataArray:Array = presetAnimationData[j];
						if (dataArray.length >= 3)
						{
							var animationFor:String = dataArray[0] as String;
							var shardTypes:Vector.<Boolean> = new Vector.<Boolean>;
							var shardNames:Vector.<String> = new Vector.<String>;
							for (var m:int = 1, n:int = dataArray.length; m < n; m+=2) 
							{
								shardTypes[shardTypes.length] = dataArray[m] as Boolean;
								shardNames[shardNames.length] = dataArray[m + 1] as String;
							}
							var animList:AnimationList = new AnimationList();
							animList.TargetAnimationName = animationFor;
							animList.ShardNameList = shardNames;
							animList.ShardTypeList = shardTypes;
							charPresetAnimations[charPresetAnimations.length] = animList;
						}
					}
					//character.SetAnimationLists(charPresetAnimations);
					
					//var character:Character = new Character(charName, tcharacter.GetCharacterData(), true, charPresetAnimations);
					var newCharacterId:int = characterManager.AddNewCharacter(charName, tcharacter.GetCharacterData(), true, charPresetAnimations);
					if (newCharacterId > -1)
					{
						menuSignal2.dispatch("AddNewCharacter", characterManager.GetCharacterNameById(newCharacterId));
					}
					
					/*if (characterManager.CheckIfCharacterCanBeAdded(character))
					{
						characterManager.AddCharacter(character);
						
						menuSignal2.dispatch("AddNewCharacter", character.GetName());
					}*/
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
							/*CONFIG::debug
							{
							menuSignal1.dispatch("Animation " + animationName + ": Could not create timeline for element " + data[i].targetName);
							}*/
						}
					}
					var shard:AnimateShard = new AnimateShard(timelines, shardMod.GetDisplayObjectOrders());
					var shardAddResult:Boolean = shardLib.AddShardToLibrary(animationIndex, shard, shardMod.GetShardName(), shardMod.GetIfBaseShard());
					
					if (!shardAddResult)
					{
						//trace("Can not add shard \"" + shardMod.GetShardName() + "\" for animation " + animationNameIndexes[animationIndex] + " (id " + animationIndex +")");
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
			else if (target.search(RegExp(/[+-]\d*.FrameChange/)) > -1)
			{
				var sign:int = target.charAt(0) == "-"? -1:1;
				target = target.substring(1, target.indexOf("F"));
				var frameAmount:int = int(target);
				var position:Number = canvas.GetTimeInCurrentAnimation();
				position = UtilityFunctions.roundToNearest(1.0 / stage.frameRate, position);
				position +=  (sign * frameAmount)*(1.0 / stage.frameRate);
				canvas.JumpToPosition(position);
				backgroundMasterTimeline.gotoAndStop(position);
				menuSignal2.dispatch("timeText",canvas.GetTimeInCurrentAnimation());
			}
			else if (target == "AnimMenu_AddAnimationSlotRequest")
			{
				menuSignal2.dispatch("AnimMenu_AddAnimationSlotResult", characterManager.AddAnimationSlotToCurrentCharacter());
			}
			else if (target == "MenuFinishedInitializing")
			{
				FinalPreparations();
				/*this.ProcessStartupMods();
				InitializeSettingsForCharactersLoadedAtStartup();
				ChangeCharacter(userSettings.currentCharacterName);
				removeChild(mainMenu);
				ToggleMenuMode();*/
				InitializeSettingsForCharactersLoadedAtStartup();
				//Change menu to reflect the loaded settings
				removeChild(mainMenu);
				ToggleMenuMode();
				ChangeCharacter(userSettings.currentCharacterName);
				menuSignal2.dispatch("CharMenu_UpdateSwitchMode", characterManager.GetSelectMode());
				menuSignal2.dispatch("CharMenu_CharacterHasChanged", characterManager.GetCharacterIdByName(userSettings.currentCharacterName));
				//menuSignal2.dispatch("CharMenu_CharacterHasChanged", characterManager.SwitchToCharacter(characterManager.GetCharacterIdByName(userSettings.currentCharacterName), true));
				//menuSignal2.dispatch("CharMenu_CharacterInfoDelivery", characterManager.GetCharacterInfo(userSettings.currentCharacterName));
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
				//SwitchCharacter(value as int);
				ChangeCharacter(characterManager.GetCharacterNameById(value as int));
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
					CompileAndSwitchAnimation(animList);
					/*var animationId:int = animationNameIndexes.indexOf(animList.TargetAnimationName);
					var shardsForAnimation:Vector.<AnimateShard> = shardLib.GetListOfShards(animationId, animList.ShardNameList, animList.ShardTypeList);
					canvas.CompileAnimation(shardsForAnimation, animList.TargetAnimationName);
					backgroundMasterTimeline.gotoAndStop(canvas.GetTimeInCurrentAnimation());
					var animationDuration:Number = canvas.GetDurationOfCurrentAnimation();
					//CONFIG::debug
					//{
						menuSignal2.dispatch("animationDuration", animationDuration);
					//}*/
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
				UpdateAnimationMenuShardsList(list);
			}
			else if (targetName == "CharMenu_SwitchCharacterRequest")
			{
				ChangeCharacter(value as String);
				/*characterManager.SwitchToCharacter(characterManager.GetCharacterIdByName(value as String), true);
				colorizer.ChangeColorsUsingCharacterData(characterManager.GetCurrentCharacterColorData());
				canvas.ChangeActorAssetsUsingCharacterData(characterManager.GetCurrentCharacterGraphicSets());
				menuSignal2.dispatch("CharMenu_CharacterInfoDelivery", characterManager.GetCharacterInfo(value as String));
				userSettings.UpdateCurrentCharacterName(value as String);*/
			}
			else if (targetName == "CharMenu_ChangeSwitchModeRequest")
			{
				var result:int = characterManager.SetSelectMode(value as int);
				menuSignal2.dispatch("CharMenu_UpdateSwitchMode", result);
				userSettings.UpdateCharacterSwitchMode(result);
			}
			else if (targetName == "CharMenu_ChangeCharacterLockRequest")
			{
				var charLock:Boolean = characterManager.SetLockOnCurrentCharacter(value as Boolean);
				menuSignal2.dispatch("CharMenu_CharacterLockResult", charLock);
				userSettings.UpdateSettingForCharacter_Lock(characterManager.GetCurrentCharacterName(), charLock);
				//characterManager.SetLockOnCharacter(value[0] as int, value[1] as Boolean);
			}
			else if (targetName == "CharMenu_CreateNewCharacterRequest")
			{
				//var newCharacter:Character = new Character(value as String, null);
				var addedCharId:int = characterManager.AddNewCharacter(value as String, null);
				if (addedCharId > -1)
				{
					var characterName:String = characterManager.GetCharacterNameById(addedCharId);
					userSettings.CreateSettingsForNewCharacter(characterName);
					userSettings.UpdateSettingForCharacter_AnimationLists(characterName, characterManager.GetAnimationListsForCharacterInBinaryFormat(addedCharId));
					menuSignal2.dispatch("AddNewCharacter", characterManager.GetCharacterNameById(addedCharId));
				}
			}
			else if (targetName == "CharMenu_CopyCharacterRequest")
			{
				var addedCharId:int = characterManager.DuplicateCharacter(value[0] as String, value[1] as String);
				//var addedCharId:int = ;
				if (addedCharId > -1)
				{
					var characterName:String = characterManager.GetCharacterNameById(addedCharId);
					userSettings.CreateSettingsForNewCharacter(characterName);
					userSettings.UpdateSettingForCharacter_AnimationLists(characterName, characterManager.GetAnimationListsForCharacterInBinaryFormat(addedCharId));
					menuSignal2.dispatch("AddNewCharacter", characterManager.GetCharacterNameById(addedCharId));
				}
			}
			else if (targetName == "CharMenu_DeleteCharacterRequest")
			{				
				var delResetResult:Array = characterManager.DeleteOrResetCharacter(value as int);
				var result:int = delResetResult[1] as int;
				var charName:String = delResetResult[0] as String;
				if (result == 1)
				{
					userSettings.DeleteSettingsForCharacter(delResetResult[0] as String);
				}
				else if (result == 0)
				{
					userSettings.UpdateSettingForCharacter_AnimationLists(charName, characterManager.GetAnimationListsForCharacterInBinaryFormat(characterManager.GetCharacterIdByName(charName)));
				}
				menuSignal2.dispatch("CharMenu_DeleteCharacterResult", delResetResult);
			}
			else if (targetName == "AnimMenu_RemoveAnimationSlotRequest")
			{
				
				menuSignal2.dispatch("AnimMenu_RemoveAnimationSlotResult", characterManager.RemoveAnimationSlotOfCurrentCharacter(value as int));
				var charName:String = characterManager.GetCurrentCharacterName();
				userSettings.UpdateSettingForCharacter_AnimationLists(charName, characterManager.GetAnimationListsForCharacterInBinaryFormat(characterManager.GetCharacterIdByName(charName)));
			}
			else if (targetName == "AnimMenu_SaveAnimationForCharacterRequest")
			{
				//characterManager.SaveAnimationForCurrentAnimation(value[0] as int, value[1] as AnimationList);
				menuSignal2.dispatch("AnimMenu_SaveAnimationResult", characterManager.SaveAnimationForCurrentAnimation(value[0] as int, value[1] as AnimationList));
				var charName:String = characterManager.GetCurrentCharacterName();
				userSettings.UpdateSettingForCharacter_AnimationLists(charName, characterManager.GetAnimationListsForCharacterInBinaryFormat(characterManager.GetCharacterIdByName(charName)));
				
			}
			else if (targetName == "AnimMenu_ChangeSelectedAnimationOfCurrentCharacter")
			{
				var charAnimationList:AnimationList = characterManager.GetAnimationListForCurrentCharacter(value as int);
				if (charAnimationList)
				{
					UpdateAnimationMenuShardsList(charAnimationList);
				}
			}
			else if (targetName == "FileLoaded")
			{
				//Things may happen here but for now they don't.
				
			}
			else if (targetName == "Actor_ReportingAssetChanged")
			{
				var nameOfActor:String = value[0] as String;
				var nameOfSet:String = value[1] as String;
				var layer:int = value[2] as int;
				if (characterManager.IsACharacterSelected())
				{
					characterManager.UpdateGraphicSettingForCurrentCharacter(nameOfActor, nameOfSet, layer);
					userSettings.UpdateGraphicSettingsForCharacter(characterManager.GetCurrentCharacterName(), nameOfActor, nameOfSet, layer);
					
				}
			}
		}
		
		
		[inline]
		private function FinalPreparations():void
		{
			ProcessStartupMods();	
			System.gc();
			System.gc();
			mainStage.addEventListener(Event.ENTER_FRAME, RunLoop);
			
		}
		
		private function ChangeCharacter(characterName:String):void
		{
			var charId:int = characterManager.GetCharacterIdByName(characterName);
			if (charId > -1)
			{
				characterManager.SwitchToCharacter(charId, true);
				colorizer.ChangeColorsUsingCharacterData(characterManager.GetCharacterColorData(charId));
				var charGraphicSettings:Object = characterManager.GetCharacterGraphicSettings(charId);
				if (charGraphicSettings )
				{
					//canvas.ClearAllActors();
					canvas.ChangeActorAssetsUsingCharacterData(charGraphicSettings);
				}
				else
				{
					canvas.ClearAllActors();
					canvas.ChangeActorAssetsUsingSetNames(characterManager.GetCharacterGraphicSets(charId));
				}
				menuSignal2.dispatch("CharMenu_CharacterInfoDelivery", characterManager.GetCharacterInfo(characterName));
				menuSignal2.dispatch("AnimMenu_UpdateAnimationListing", characterManager.GetCurrentCharacterAnimationStates());
				userSettings.UpdateCurrentCharacterName(characterName);
			}
		}
		
		private function ChangeCharacterById(charId:int):void
		{
			if (charId > -1)
			{
				characterManager.SwitchToCharacter(charId, true);
				colorizer.ChangeColorsUsingCharacterData(characterManager.GetCharacterColorData(charId));
				var charGraphicSettings:Object = characterManager.GetCharacterGraphicSettings(charId);
				if (charGraphicSettings )
				{
					//canvas.ClearAllActors();
					canvas.ChangeActorAssetsUsingCharacterData(charGraphicSettings);
				}
				else
				{
					canvas.ClearAllActors();
					canvas.ChangeActorAssetsUsingSetNames(characterManager.GetCharacterGraphicSets(charId));
				}
				var characterName:String = characterManager.GetCharacterNameById(charId);
				menuSignal2.dispatch("CharMenu_CharacterInfoDelivery", characterManager.GetCharacterInfo(characterName));
				menuSignal2.dispatch("AnimMenu_UpdateAnimationListing", characterManager.GetCurrentCharacterAnimationStates());
				userSettings.UpdateCurrentCharacterName(characterName);
			}
		}
		
		
		/*SETTINGS RELATED FUNCTIONS*/
		//public function SaveSettingsToDisk():void
		//{
			/*if (helpScreenMC.visible)
			{
				UpdateKeyBindsForHelpScreen();
			}*/
			//settingsSaveFile.flush();
			//NYI
			//Need to update the key function lookup table for the new keycodes
			//SetupKeyFunctionLookupTable();
		//}
		
		private function LoadUserSettings():void
		{
			if(CONFIG::BuildMenu == true)
			{
				//logger.info("Loading user settings");
				if (settingsSaveFile.data.ppppuSettings != null)
				{
					if (userSettings.SAVE_VERSION == settingsSaveFile.data.ppppuSettings.version)
					{
						userSettings.ConvertFromObject(settingsSaveFile.data.ppppuSettings);
						//Something went terribly wrong, recreate the user settings
						
						if (userSettings == null) 
						{ 
							//logger.warn("Settings were not loaded correctly. Recreating user settings.");
							userSettings = new UserSettings(); 
						}
						else
						{
							//logger.info("User Settings were loaded successfully.");
						}
					}
					else
					{
						//logger.warn("Out of date settings version found, settings have been reset to their default values.");
						settingsSaveFile.clear();
					}
					settingsSaveFile.data.ppppuSettings = userSettings;
				}
			}
			else
			{
				userSettings = new UserSettings(); 
			}
			
			
			if (userSettings.firstTimeRun == true)
			{
				//logger.info("A new save file for settings is being used.");
				//UpdateKeyBindsForHelpScreen();
				//ToggleHelpScreen(); //Show the help screen
				//ShowMenu(true);
				userSettings.firstTimeRun = false;
				if (CONFIG::BuildMenu == true)
				{
					settingsSaveFile.data.ppppuSettings = userSettings;
					settingsSaveFile.flush();
				}
			}
			
			characterManager.SetSelectMode(userSettings.characterSwitchMode);
			//NYI
			//musicPlayer.SetIfMusicIsEnabled(userSettings.playMusic);
			//var chosenMusicId:int = musicPlayer.GetMusicIdByName(userSettings.globalSongTitle);
			//if (chosenMusicId > -1) { musicPlayer.SetInitialMusicToPlay(chosenMusicId);}			
		}
		
		private function UpdateAnimationMenuShardsList(list:AnimationList):void
		{
			if (list)
			{
				//Check if the animation list is a version compatible with the latest project build. Refuse to process it if it isn't.
				if (list.version != AnimationList.ANIMATION_LIST_VERSION) { menuSignal2.dispatch("SetupShardsList", null); return; }
				
				var names:Vector.<String> = list.ShardNameList;
				var types:Vector.<Boolean> = list.ShardTypeList;
				var animationId:int = animationNameIndexes.indexOf(list.TargetAnimationName);
				if (animationId == -1) 	{ menuSignal2.dispatch("SetupShardsList", null); menuSignal2.dispatch("AnimMenu_InvalidAnimationSelected", list.TargetAnimationName); return; }
				
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
				menuSignal2.dispatch("AnimMenu_ChangeAnimationSelected", list.TargetAnimationName);
				menuSignal2.dispatch("SetupShardsList", shardsData);
			}
		}
		
		private function CompileAndSwitchAnimation(animList:AnimationList):void
		{
			var animationId:int = animationNameIndexes.indexOf(animList.TargetAnimationName);
			if (animationId > -1)
			{
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
		
		//[inline]
		/*private function AddNewCharacter(name:String, charData:Object, isPresetCharacter:Boolean = false, presetAnimationLists:Vector.<AnimationList>=null):int
		{
			if (characterManager.CheckIfCharacterCanBeAdded(character))
			{
				var newCharId:int = characterManager.AddNewCharacter(name, charData, isPresetCharacter, presetAnimationLists);
				
				menuSignal2.dispatch("AddNewCharacter", characterManager.GetCharacterNameById(newCharId));
				return newCharId;
			}
			return -1;
		}*/
		
		private function InitializeSettingsForCharactersLoadedAtStartup():void
		{
			//var charSettings:Object;
			//For any characters added due to mods
			var numChars:int = characterManager.GetTotalNumOfCharacters();	// SMLSE OPTIMIZE ATTEMPT
			for (var i:int = 0; i < numChars; i++) 
			{
				TryToLoadCharacterSettings(characterManager.GetCharacterNameById(i));
			}
			//For characters created by other means and settings overrides for the mod created characters
			var characterName:String;
			for (characterName in userSettings.characterSettings) 
			{
				TryToLoadCharacterSettings(characterName);
			}
			
		}
		
		private function TryToLoadCharacterSettings(characterName:String):void
		{
			//if (characterId < 0 || characterId >= characterManager.GetTotalNumOfCharacters()) { return; }
			
			//var characterName:String = characterManager.GetCharacterNameById(characterId);
			

			var charId:int = characterManager.GetCharacterIdByName(characterName);
			if (userSettings.CheckIfCharacterHasSettings(characterName) == false)
			{
				userSettings.CreateSettingsForNewCharacter(characterName);
				userSettings.UpdateColorSettingsForCharacter(characterName, characterManager.GetCharacterColorData(charId));
						//userSettings.Update(charName, characterManager.GetCharacterGraphicSettings(newCharacterId));
			}
			//processing of character settings
			var charSettings:Object = userSettings.GetSettingsForCharacter(characterName);
			
			//Character wasn't added by a template character mod but was saved from a prior session. Create a new character and try to add them.
			if (charId == -1)
			{
				//var newCharacter:Character = new Character(characterName, null);
				charId = characterManager.AddNewCharacter(characterName, null);
				if (charId > -1)
				{
					menuSignal2.dispatch("AddNewCharacter", characterManager.GetCharacterNameById(charId));
				}
			}
			if (charId > -1)
			{
				//Set up character to use those settings.
				characterManager.InitializeSettingsForCharacter(charId, charSettings);
				//Insert something here for menu to update
				//mainMenu.SetupMenusForCharacter(charId, charSettings);
			}
		}
		
	}

}