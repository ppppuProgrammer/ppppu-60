package  
{
	import animations.*;
	import animations.background.*;
	import menu.*;
	import audio.MusicPlayer;
	import com.lorentz.SVG.display.SVGDocument;
	import com.lorentz.processing.ProcessExecutor;
	import flash.display.*;
	import com.jacksondunstan.signals.*;
	import flash.events.*;
	import modifications.*;
	import characters.*;
	import flash.geom.Point;
	import org.libspark.betweenas3.core.easing.EaseNone;
	import org.libspark.betweenas3.core.easing.ElasticEaseOut;
	import org.libspark.betweenas3.core.tweens.groups.ParallelTween;
	import org.libspark.betweenas3.core.tweens.groups.SerialTween;
	import flash.net.registerClassAlias;
	import flash.system.System;
	import flash.utils.*;
	import flash.ui.Keyboard;
	import mx.utils.StringUtil;
	import org.libspark.betweenas3.BetweenAS3;
	import flash.net.SharedObject;
	import org.libspark.betweenas3.easing.Back;
	import org.libspark.betweenas3.easing.Circ;
	import org.libspark.betweenas3.easing.Elastic;
	import org.libspark.betweenas3.easing.Linear;
	
	/**
	 * Responsible for all the various aspects of ppppuNX. 
	 * @author ppppuProgrammer
	 */
	public class AppCore extends Sprite implements Slot1, Slot2
	{		
		private var shardLib:AnimateShardLibrary = new AnimateShardLibrary();
		
		//A movie clip that holds all the body elements used to create an animation. This is to be a reference to a canvas instance created in the main stage (this is done for performance reasons, performance tanks if the canvas was created in as3.)
		private var canvas:Canvas;// = new MasterTemplate();

		//Main Stage is the movie clip where a major of the graphics are displayed
		public var mainStage:MainStage;
		//Keeps track of what keys were pressed and/or held down
		private var keyDownStatus:Array = [];
		//Contains the names of the various animations that the master template can switch between. The names are indexed by their position in the vector.
		private var animationNameIndexes:Vector.<String> = new Vector.< String > ();// ["Cowgirl", "LeanBack", "LeanForward", "Grind", "ReverseCowgirl", "Paizuri", "Blowjob", "SideRide", "Swivel", "Anal"];
		//private var basisBodyTypes:Vector.<String> = new Vector.<String>();
		private var characterManager:CharacterManager;
		
		private var musicPlayer:MusicPlayer;
		

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
		
		CONFIG::NX
		{
		//Settings related
		public var settingsSaveFile:SharedObject = SharedObject.getLocal("ppppuNX_Settings", "/");
		
		private var mainMenu:MainMenu;
		//The tween used for moving the main menu out of view.
		private var menuCloseTween:ParallelTween;
		//The tween used for moving the main menu back into view.
		private var menuOpenTween:ParallelTween;
		}
		//Indicates whether the program is in edit mode or play mode. Edit mode has the menus on screen. 
		private var menuModeActive:Boolean = false;
		
		
		public var userSettings:UserSettings = new UserSettings();
		
		private var menuSignal1:Signal1 = new Signal1();
		private var menuSignal2:Signal2 = new Signal2();

		
		private var modsLoadedAtStartUp:Array;
		
		//private var graphicSets:Dictionary = new Dictionary();
		
		
		
		//Constructor
		public function AppCore() 
		{
			//Create the "main stage" that holds the character template and various other movieclips such as the transition and backlight 
			mainStage = new MainStage();
			mainStage.BGLayer1.visible = mainStage.BGLayer2.visible = mainStage.BGLayer3.visible = 
			mainStage.BGLayer4.visible = mainStage.DisplayArea.visible = mainStage.Compositor.visible = false;
			
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
			
			musicPlayer = new MusicPlayer();
			
			
			
			
			//Disable mouse interaction for various objects
			////mainStage.MenuLayer.mouseEnabled = true;
			//Disable mouse interaction for various objects
			mainStage.mouseEnabled = false;
			mainStage.DisplayArea.mouseEnabled = false;
			mainStage.DisplayArea.mouseChildren = false;
			mainStage.BGLayer1.mouseEnabled = false;
			mainStage.BGLayer1.mouseChildren = false;
			mainStage.BGLayer2.mouseEnabled = false;
			mainStage.BGLayer2.mouseChildren = false;
			mainStage.BGLayer3.mouseChildren = false;
			mainStage.BGLayer3.mouseEnabled = false;
			mainStage.BGLayer4.mouseChildren = false;
			mainStage.BGLayer4.mouseEnabled = false;
			
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
			
			var planetBGMod:BackgroundAssetMod = new BackgroundAssetMod(new PlanetBackground, "Standard", "BGLayer0", null);
		var outerBGMod:BackgroundAssetMod = new BackgroundAssetMod(new OuterDiamondBG, "Standard", "BGLayer4", {Colorable:{Group: "ODiamondColor1", Target:"this"}});
			
			var innerBGMod:BackgroundAssetMod = new BackgroundAssetMod(new InnerDiamondBG, "Standard", "BGLayer1", {Colorable: { Group: ["IDiamondColor1", "IDiamondColor2", "IDiamondColor3", "IDiamondColor4"], Target: ["Color1", "Color2", "Color3", "Color4"] }});
		var transitionBGMod:BackgroundAssetMod = new BackgroundAssetMod(new TransitionDiamondBG, "Standard", "BGLayer2", {Colorable:{ Group: ["TDiamondColor1", "TDiamondColor2", "TDiamondColor3", "TDiamondColor4", "TDiamondColor5"], Target: ["Color1", "Color2", "Color3", "Color4", "Color5"] }});
	var lightBGMod:BackgroundAssetMod = new BackgroundAssetMod(new Light, "Standard", "BGLayer3", {Colorable:{ Group: "BackLight", Target: "this" }});
	
			ProcessMod(planetBGMod);
			ProcessMod(outerBGMod);
			ProcessMod(innerBGMod);
			ProcessMod(transitionBGMod);
			ProcessMod(lightBGMod);
			
			//var assetsMod:Mod = (new assetsSWF) as Mod;
			
			mainStage.BGLayer1.SelectBackgroundAsset(0);
			mainStage.BGLayer4.SelectBackgroundAsset(0);
			mainStage.BGLayer2.SelectBackgroundAsset(0);
			mainStage.BGLayer0.SelectBackgroundAsset(0);
			mainStage.BGLayer3.SelectBackgroundAsset(0);
			
			registerClassAlias("AnimationList", animations.AnimationList);
			
			modsLoadedAtStartUp = startupMods;
			
			LoadUserSettings();
			CONFIG::NX
			{
				//Allows svg data to be used in flash
				ProcessExecutor.instance.initialize(stage); 
				//Create the main menu. 
				mainMenu = new MainMenu();
				//Create the tweens that are used to move the main menu and main stage around.
				menuOpenTween = BetweenAS3.parallel(BetweenAS3.to(mainStage, { x:0 }, .25, Linear.linear), BetweenAS3.serial(BetweenAS3.addChild(mainMenu, this), BetweenAS3.to(mainMenu, { x:480 }, .25, Circ.easeIn))) as ParallelTween;
				menuCloseTween = BetweenAS3.parallel(BetweenAS3.to(mainStage, { x:(stage.stageWidth - mainStage.DisplayArea.width) / 2 }, .25, Linear.linear), BetweenAS3.serial( BetweenAS3.to(mainMenu, { x:960 }, .25, Back.easeOut), BetweenAS3.removeFromParent(mainMenu))) as ParallelTween;
				mainMenu.InitializeMainMenu(this, director);
				mainMenu.x = 480;
				
			}
			CONFIG::FPS60
			{
				FinalPreparations();
				//ChangeCharacter("Peach");
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

				canvas.visible = true;
				firstTimeInLoop = false;
				lastUpdateTime = getTimer();
			}
			
			
			var animationPosition:Number = canvas.Update();	
			CONFIG::NX
			{
				if (animationPosition >= 0.0){
					menuSignal2.dispatch("timeText", animationPosition);
				}
			}

			var currentUpdateTime:Number = getTimer();
			var difference:Number = (currentUpdateTime - lastUpdateTime);
			
			//if (int((totalRunTime + difference)/ 4000) > int(totalRunTime/4000))
			if(canvas.IsAnimationFinished())
			{
				if (!menuModeActive)
				{
					characterManager.CharacterSwitchLogic();
					
					var switchedCharsId:int = characterManager.GetIdOfCharacterToSwitchTo(animationNameIndexes);
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
					backgroundMasterTimeline.gotoAndPlay(0);
					CONFIG::FPS60
					{
						if (musicPlayer.IsBGMStopped())
						{
							musicPlayer.PlayMusic(musicPlayer.GetMusicIdByName(userSettings.globalSongTitle), canvas.GetTimeInCurrentAnimation() * 1000);
						}
					}
					
				}
			}
			totalRunTime += difference;
			lastUpdateTime = currentUpdateTime;
			
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
			//Check if there isn't an interactive object that has keyboard focus.
			if (stage.focus != null) { return; }
			
			
			var keyPressed:int = keyEvent.keyCode;

			if(keyDownStatus[keyPressed] == undefined || keyDownStatus[keyPressed] == false || (keyPressed == 48 || keyPressed == 96))
			{
				if((keyPressed == 48 || keyPressed == 96))
				{
					var randomAnimIndex:int = characterManager.RandomizeCurrentCharacterAnimation(animationNameIndexes);
					//SwitchTemplateAnimation(randomAnimIndex);
					var animationCurrentPosition:Number = canvas.GetTimeInCurrentAnimation();
					CompileAndSwitchAnimation(characterManager.GetAnimationListForCurrentCharacter(randomAnimIndex));
					canvas.PlayAnimation(animationCurrentPosition);
					//backgroundMasterTimeline.gotoAndPlay(animationCurrentPosition);
					
					
				}
				/*else if((!(Keyboard.NUMBER_0 > keyPressed) && !(keyPressed > Keyboard.NUMBER_9 )) ||  (!(97 > keyPressed) && !(keyPressed > 105)))
				{
					//keypress of 1 has a keycode of 49
					if(keyPressed > 96)
					{
						keyPressed = keyPressed - 48;
					}
					canvas.PlayAnimation(-1);
				}*/
				
				CONFIG::NX
				{
					if (keyPressed == Keyboard.SPACE)
					{
						ToggleMenuMode();
						
					}
					
					CONFIG::debug
					{
					if (keyPressed == Keyboard.R)
					{
						mainMenu.ReloadSubMenus(this);
					}
					}
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
		
		CONFIG::NX
		{
		private function ToggleMenuMode():void
		{
			//Can not change menu mode if there one of the menu related tweens are running.
			if (menuCloseTween.isPlaying || menuOpenTween.isPlaying) { return; }
			
			menuModeActive = !menuModeActive;
			
			if (!musicPlayer.IsBGMStopped())
			{
				//musicPlayer.PauseMusic();
				musicPlayer.StopMusic();
			}
			
			if (menuModeActive)
			{

				/*if (!musicPlayer.IsBGMStopped())
				{
					//musicPlayer.PauseMusic();
					musicPlayer.StopMusic();
				}*/
				canvas.StopAnimation();
				backgroundMasterTimeline.stop();
				
				menuOpenTween.play();
				
				//stage.focus = mainMenu;
			}
			else
			{

				if (!canvas.IsAnimationFinished())
				{
					canvas.ResumePlayingAnimation();
					backgroundMasterTimeline.play();
				}
				//musicPlayer.ResumeMusic(canvas.GetTimeInCurrentAnimation() * 1000);
				musicPlayer.PlayMusic(musicPlayer.GetMusicIdByName(userSettings.globalSongTitle), canvas.GetTimeInCurrentAnimation() * 1000);
				menuCloseTween.play();
				stage.focus = null;
			}
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
						if (dataArray.length >= 4)
						{
							var animationFor:String = dataArray[0] as String;
							var shardTypes:Vector.<Boolean> = new Vector.<Boolean>;
							var shardNames:Vector.<String> = new Vector.<String>;
							for (var m:int = 2, n:int = dataArray.length; m < n; m+=2) 
							{
								shardTypes[shardTypes.length] = dataArray[m] as Boolean;
								shardNames[shardNames.length] = dataArray[m + 1] as String;
							}
							var animList:AnimationList = new AnimationList();
							animList.TargetAnimationName = animationFor;
							animList.ShardNameList = shardNames;
							animList.ShardTypeList = shardTypes;
							animList.AnimationType = dataArray[1] as int;
							charPresetAnimations[charPresetAnimations.length] = animList;
						}
					}
					//character.SetAnimationLists(charPresetAnimations);
					
					//var character:Character = new Character(charName, tcharacter.GetCharacterData(), true, charPresetAnimations);
					var newCharacterId:int = characterManager.AddNewCharacter(charName, tcharacter.GetCharacterData(), true, charPresetAnimations);
					
					//CONFIG::FPS60
					//{
						//character
					//}
					
					CONFIG::NX
					{
					if (newCharacterId > -1)
					{
						if (totalRunTime > 0) { TryToLoadCharacterSettings(charName); } 
						
						menuSignal2.dispatch("AddNewCharacter", characterManager.GetCharacterNameById(newCharacterId));
						//
						
						/*if (userSettings.CheckIfCharacterHasSettings(charName))
						{
							
						}*/
					}					
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
						
						CONFIG::NX
						{
						menuSignal2.dispatch("AddNewAnimation", animationName);
						}
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
					addedMod = musicPlayer.AddMusic(music.GetMusicData(), music.GetName(), music.GetDisplayInformation(), music.GetStartLoopTime(), music.GetEndLoopTime(), music.GetStartTime());
					if (addedMod)
					{
						menuSignal2.dispatch("MusicMenu_AddMusicToSelectionList", music.GetName());
					}
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
						bgAsset.asset.name = bgAsset.assetName;
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

		CONFIG::NX
		{
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
				
				ChangeCharacterByName(userSettings.currentCharacterName);
				
				//Change menus to reflect the loaded settings
				CONFIG::NX
				{
				removeChild(mainMenu);
				
				musicPlayer.PlayMusic(musicPlayer.GetMusicIdByName(userSettings.globalSongTitle), 0);
				ToggleMenuMode();
				
				
				
				var outgoingMessage:MessageData = new MessageData;
				outgoingMessage.intData[0] = musicPlayer.GetMusicIdByName(userSettings.globalSongTitle);
				outgoingMessage.floatData[0] = userSettings.musicVolume / 100.0;
				musicPlayer.ControlBGMVolume(outgoingMessage.floatData[0]);
				menuSignal2.dispatch("MusicMenu_UpdateMusicVolumeSlider", outgoingMessage);
				menuSignal2.dispatch("MusicMenu_ChangeSelectedMusicResult", outgoingMessage);
				outgoingMessage.intData[0] = characterManager.GetSelectMode();
				menuSignal2.dispatch("CharMenu_UpdateSwitchMode", outgoingMessage);
				outgoingMessage.intData[0] = characterManager.GetCharacterIdByName(userSettings.currentCharacterName);
				menuSignal2.dispatch("CharMenu_CharacterHasChanged", outgoingMessage);
				}
			}			
			else if (target == "MainMenu_MenuReloadFinished")
			{
				//Repopulate the Character Sub Menu 
				var messsageData:MessageData = new MessageData();
				var i:int = 0; var l:int = characterManager.GetTotalNumOfCharacters();
				for (i; i < l; i++) 
				{
					messsageData.stringData[messsageData.stringData.length] = characterManager.GetCharacterNameById(i);
				}
				menuSignal2.dispatch("CharMenu_ListOfCharactersToAdd", messsageData);
				
				//Add Music Names to music menu
				//var musicList:MessageData = new MessageData();
				messsageData.stringData = musicPlayer.GetListOfMusicNames();
				menuSignal2.dispatch("MusicMenu_ListOfMusicToAdd", messsageData);
				
				//Add Animation names to animation menu
				messsageData.stringData = GetListOfAnimationNames();
				menuSignal2.dispatch("AnimMenu_AddAnimationNamesToDropList", messsageData);
				
				//Add actor names to custom menu
				messsageData.stringData = canvas.GetListOfActors();
				menuSignal2.dispatch("CustomMenu_AddActorNames", messsageData);
				
				messsageData.stringData = canvas.GetListOfGraphicSetNames();
				menuSignal2.dispatch("CustomMenu_AddGraphicSetNames", messsageData);
				
				messsageData.intData[0] = musicPlayer.GetMusicIdByName(userSettings.globalSongTitle)
				menuSignal2.dispatch("MusicMenu_ChangeSelectedMusicResult", messsageData);
				messsageData.intData[0] = characterManager.GetSelectMode();
				menuSignal2.dispatch("CharMenu_UpdateSwitchMode", messsageData);
				messsageData.intData[0] = characterManager.GetCharacterIdByName(userSettings.currentCharacterName);
				menuSignal2.dispatch("CharMenu_CharacterHasChanged", messsageData);
				
			}
			CONFIG::debug
			{
				if (target == "DevMenu_ReloadSubMenus")
				{
					mainMenu.ReloadSubMenus(this);
				}
			}
		}
		
		public function onSignal2(targetName:*, value:*):void
		{
			var messageData:MessageData = value as MessageData;
			if (targetName == "setFrameButton")
			{
				var position:Number = (value as int) * (1.0 / stage.frameRate);
				canvas.JumpToPosition(position);
				backgroundMasterTimeline.gotoAndStop(position);
				//masterTemplate.ResumePlayingAnimation();
			}
			else if (targetName == "CustomMenu_ColorDataRequest")
			{
				var currentCharColorData:Object = characterManager.GetCharacterColorData(characterManager.GetCharacterIdByName(characterManager.GetCurrentCharacterName()));
				if (currentCharColorData && messageData.stringData[0] in currentCharColorData)
				{
					var colorGroupData:Array = currentCharColorData[messageData.stringData[0]];
					for (var j:int = 0; j < 4; j++) 
					{
						if (j < colorGroupData.length)
							messageData.uintData[j] = colorGroupData[j];
						else
							messageData.uintData[j] = 0x00000000;
					}
					menuSignal2.dispatch("CustomMenu_ColorDataResponse", messageData);
				}
			}
			else if (targetName == "setAnimationTime")
			{
				canvas.JumpToPosition(value as Number);
				backgroundMasterTimeline.gotoAndStop(value as Number);
			}
			else if (targetName == "characterSelector")
			{
				//SwitchCharacter(value as int);
				ChangeCharacterByName(characterManager.GetCharacterNameById(value as int));
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
			else if (targetName == "AnimMenu_CompileAnimationFromAnimationList")
			{
				//Compiles an animation by using an animation list. Goes through the list and builds a vector of shards then passes the vector to the canvas.
				//Value is an animation list.
				var animList:AnimationList = value as AnimationList;
				//Make sure animation list exists and is the supported version of the list for the program.
				if (animList)
				{
					CompileAndSwitchAnimation(animList);
					canvas.JumpToPosition(0.0);
					backgroundMasterTimeline.gotoAndStop(0.0);
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
				ChangeCharacterByName(value as String);
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
					var characterId:int = characterManager.GetCharacterIdByName(charName);
					userSettings.UpdateSettingForCharacter_AnimationLists(charName, characterManager.GetAnimationListsForCharacterInBinaryFormat(characterId));
					var colorSettings:Object = characterManager.GetCharacterColorData(characterId);
					userSettings.UpdateColorSettingsForCharacter(charName, colorSettings);	
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
			else if (targetName == "LoadMenu_ProcessMod")
			{
				ProcessMod(value as Mod);				
			}
			else if (targetName == "Actor_ReportingAssetChanged")
			{
				var nameOfActor:String = value[0] as String;
				var nameOfSet:String = value[1] as String;
				var layer:int = value[2] as int;
				if (characterManager.IsACharacterSelected())
				{
					characterManager.UpdateGraphicSettingForCurrentCharacter(nameOfActor, nameOfSet, layer);
					userSettings.UpdateGraphicSettingForCharacter(characterManager.GetCurrentCharacterName(), nameOfActor, nameOfSet, layer);
					
				}
			}
			else if (targetName == "MusicMenu_ChangeMusicVolumeRequest")
			{
				//messageData.floatData[0];
				//musicPlayer.ControlBGMVolume(messageData.floatData[0]);
				userSettings.UpdateMusicVolume(musicPlayer.ControlBGMVolume(messageData.floatData[0])*100);
			}
			else if (targetName == "MusicMenu_PreviewMusic")
			{
				musicPlayer.PreviewMusic(value as int);
			}
			else if (targetName == "MusicMenu_TestMusicLoopPoint")
			{
				musicPlayer.TestMusicLoop(value as int);
			}
			else if (targetName == "MusicMenu_ChangeSelectedMusicRequest")
			{
				var idOfSelectedMusic:int = musicPlayer.GetMusicIdByName(value as String);
				musicPlayer.ChangeMusicToPlay(idOfSelectedMusic);
				//Don't assume that the title of the music is what was received from the message.  
				userSettings.globalSongTitle = musicPlayer.GetNameOfCurrentMusic();
				
				/*var musicChangeMessage:MessageData = new MessageData;
				musicChangeMessage.intData[0] = idOfSelectedMusic;
				menuSignal2.dispatch("MusicMenu_ChangeSelectedMusicResult", musicChangeMessage);*/
			}
			else if (targetName == "LoadMenu_LoadedSVGAsset")
			{
				var svgSet:String = messageData.stringData[0];
				var assetLayer:int = messageData.intData[0];
				for (var i:int = 1, l:int = messageData.stringData.length; i < l; i++) 
				{
					canvas.AddAssetToActor(messageData.stringData[i], new AssetData(svgSet, messageData.spriteData[i-1], assetLayer, null));
				}
			}
			else if (targetName == "LoadMenu_LoadedSVGBackgroundAsset")
			{
				for (var i:int = 0, l:int = messageData.stringData.length; i < l; i++) 
				{
					var backgroundLayer:ExchangeableBackground = mainStage.getChildByName("BGLayer" + messageData.stringData[i]) as ExchangeableBackground;
					if (backgroundLayer)
					{
						backgroundLayer.AddNewBackgroundAsset(messageData.spriteData[i]);
					}
					
				}
			}
			else if (targetName == "LoadMenu_LoadedRasterBackgroundAsset")
			{
				for (var i:int = 0, l:int = messageData.stringData.length; i < l; i++) 
				{
					var backgroundLayer:ExchangeableBackground = mainStage.getChildByName("BGLayer" + messageData.stringData[i]) as ExchangeableBackground;
					//Raster backgrounds are moved to be centered on the display area of the main stage.
					var bgAsset:Sprite = messageData.spriteData[i];
					bgAsset.x =  mainStage.DisplayArea.x + (mainStage.DisplayArea.width - bgAsset.width) / 2;
					//Also it's scaled vertically if it's less than 720 pixels tall.
					if (bgAsset.height < mainStage.DisplayArea.height) {bgAsset.height = mainStage.DisplayArea.height;}
					if (backgroundLayer) {
						backgroundLayer.AddNewBackgroundAsset(bgAsset);
						menuSignal2.dispatch("CustomMenu_AddedBackgroundLayers", null);
					}
					
				}
			}
			else if (targetName == "AddedAssetToActorResult")
			{
				var currentCharGraphicSettings:Object = userSettings.GetSettingsForCharacter(characterManager.GetCurrentCharacterName());
				if (currentCharGraphicSettings)
				{
					var assetSetName:String = value[1] as String;
					var actorName:String = value[0] as String;
					
					if (actorName in currentCharGraphicSettings.graphicSettings)
					{
						if (currentCharGraphicSettings.graphicSettings[actorName][value[2] as int] == assetSetName)
						{
							canvas.ChangeAssetForActor(actorName, assetSetName, value[2] as int);
						}
					}
				}
			}
			else if (targetName == "CustomMenu_GetBackgroundLayerAssetsRequest")
			{
				//Used for generating previews for the background assets
				
				var bgLayer:ExchangeableBackground = mainStage["BGLayer" + String(messageData.intData[0])] as ExchangeableBackground;
				
				if (bgLayer)
				{
					//var bgResponseData:MessageData = new MessageData;
					//Recycling's pretty cool, so reuse the message data that came with the request
					messageData.spriteData = bgLayer.GetSpriteList();
					messageData.intData[0] = bgLayer.GetIdOfCurrentAsset();
					menuSignal2.dispatch("CustomMenu_GetBackgroundLayerAssetsResponse", messageData);
				}
			}
			else if (targetName == "CustomMenu_ChangeBackgroundAsset")
			{
				//Used to change the background asset used for a background layer
				
				var bgLayer:ExchangeableBackground = mainStage["BGLayer" + String(messageData.intData[0])] as ExchangeableBackground;
				
				if (bgLayer)
				{
					bgLayer.SelectBackgroundAsset(messageData.intData[1]);
				}
			}
			else if (targetName == "CustomMenu_ChangeInCharacterColor")
			{
				var currentCharacterId:int = characterManager.GetCurrentCharacterId();
				//var colorSettings:Object = characterManager.GetCharacterColorData(characterManager.GetCharacterIdByName(currentCharacter));
				var colorPointChanging:int = messageData.intData[0];
				characterManager.ModifyColorDataForCharacter(currentCharacterId, messageData.stringData[0], messageData.uintData, colorPointChanging);
				var colorSettings:Object = characterManager.GetCharacterColorData(currentCharacterId);
				//var colorSettings:Object = userSettings.GetColorSettingsForCharacter(currentCharacter);
				//colorSettings[messageData.stringData[0]] = [messageData.uintData[0], messageData.uintData[1], messageData.uintData[2], messageData.uintData[3]];
				userSettings.UpdateColorSettingsForCharacter(characterManager.GetCurrentCharacterName(), colorSettings);
				colorizer.ChangeColorsUsingCharacterData(colorSettings);
				for (var j:int = 0; j < 4; j++) 
				{
					messageData.uintData[j] = colorSettings[messageData.stringData[0]][j];
				}
				menuSignal2.dispatch("CustomMenu_ColorDataResponse-NoMenuRedraw", messageData);
			}
			else if (targetName == "CustomMenu_GetLinkedColorGroupNumberRequest")
			{
				var groupNumber:int = characterManager.GetLinkedColorGroupNumberForCharacter(characterManager.GetCurrentCharacterId(), messageData.stringData[0], messageData.intData[0]);
				//Reuse the message for the reply
				messageData.intData[0] = groupNumber;
				menuSignal2.dispatch("CustomMenu_GetLinkedColorGroupNumberResponse", messageData);
			}
			else if (targetName == "CustomMenu_ChangeLinkedColorGroupNumber") {
				var charId:int = characterManager.GetCurrentCharacterId();
				characterManager.ChangeLinkedColorGroupNumberForCharacter(charId, messageData.stringData[0], messageData.intData[0], messageData.intData[1]);
				userSettings.UpdateLinkedColorGroupSettingsForCharacter(characterManager.GetCurrentCharacterName(), characterManager.GetCharacterLinkedColorGroupData(charId));
			}
		}
		}
		CONFIG::FPS60
		{
			public function onSignal1(targetName:*):void{}			
			public function onSignal2(targetName:*, value:*):void{}
		}
		
		[inline]
		private function FinalPreparations():void
		{
			ProcessStartupMods();	
			System.gc();
			System.gc();
			//With all startup mods loaded 
			//musicPlayer.ControlVolume(1.0);
			mainStage.addEventListener(Event.ENTER_FRAME, RunLoop);
			//Add the key listeners
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyPressCheck);
			stage.addEventListener(KeyboardEvent.KEY_UP, KeyReleaseCheck);
			
		}
		
		private function ChangeCharacterByName(characterName:String):void
		{
			var charId:int = characterManager.GetCharacterIdByName(characterName);
			if (charId > -1)
			{
				ChangeCharacter(charId, characterName);
				CONFIG::NX
				{
				menuSignal2.dispatch("CharMenu_CharacterInfoDelivery", characterManager.GetCharacterInfo(characterName));
				menuSignal2.dispatch("AnimMenu_UpdateAnimationListing", characterManager.GetCurrentCharacterAnimationStates());
				menuSignal2.dispatch("CustomMenu_CharacterHasChanged", null);
				}
			}
		}
		
		private function ChangeCharacterById(charId:int):void
		{
			if (charId > -1)
			{
				var characterName:String = characterManager.GetCharacterNameById(charId);
				ChangeCharacter(charId, characterName);
				
				CONFIG::NX
				{
				menuSignal2.dispatch("CharMenu_CharacterInfoDelivery", characterManager.GetCharacterInfo(characterName));
				menuSignal2.dispatch("AnimMenu_UpdateAnimationListing", characterManager.GetCurrentCharacterAnimationStates());
				}
				
			}
		}

		[inline]
		private function ChangeCharacter(charId:int, characterName:String):void
		{
			characterManager.SwitchToCharacter(charId, true);
			
			CONFIG::NX
			{
			var charGraphicSettings:Object = characterManager.GetCharacterGraphicSettings(charId);
			if (charGraphicSettings )
			{
				canvas.ClearAllActors();
				canvas.ChangeActorAssetsUsingCharacterData(charGraphicSettings);
			}
			else
			{
				canvas.ClearAllActors();
				canvas.ChangeActorAssetsUsingSetNames(characterManager.GetCharacterGraphicSets(charId));
				//Update user settings to have the new graphic settings for the character
				userSettings.UpdateAllGraphicSettingsForCharacter(characterName, characterManager.GetCharacterGraphicSettings(charId));
			}
			userSettings.UpdateCurrentCharacterName(characterName);
			}
			
			CONFIG::FPS60
			{
			canvas.ClearAllActors();
			canvas.ChangeActorAssetsUsingSetNames(characterManager.GetCharacterGraphicSets(charId));
			}
			colorizer.ChangeColorsUsingCharacterData(characterManager.GetCharacterColorData(charId));
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
			CONFIG::NX
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
			
			CONFIG::FPS60
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
				CONFIG::NX
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
		
		CONFIG::NX
		{
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
					shard = shardLib.GetShard(animationId, (types[i] as Boolean), names[i]);
					if (shard)
					{
						shardsData[shardsData.length] = [names[i], types[i]];
					}
				}
				menuSignal2.dispatch("AnimMenu_ChangeAnimationSelected", list.TargetAnimationName);
				menuSignal2.dispatch("SetupShardsList", shardsData);
			}
		}
		}
		
		private function CompileAndSwitchAnimation(animList:AnimationList):void
		{
			if (animList)
			{
				var animationId:int = animationNameIndexes.indexOf(animList.TargetAnimationName);
				if (animationId > -1)
				{
					var shardsForAnimation:Vector.<AnimateShard> = shardLib.GetListOfShards(animationId, animList.ShardNameList, animList.ShardTypeList);
					canvas.CompileAnimation(shardsForAnimation, animList.TargetAnimationName);
					//backgroundMasterTimeline.gotoAndStop(canvas.GetTimeInCurrentAnimation());
					CONFIG::NX
					{
						var animationDuration:Number = canvas.GetDurationOfCurrentAnimation();
						menuSignal2.dispatch("animationDuration", animationDuration);
					}
				}
			}
		}
		
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
				CONFIG::NX
				{
					if (charId > -1)
					{
						menuSignal2.dispatch("AddNewCharacter", characterManager.GetCharacterNameById(charId));
					}
				}
			}
			if (charId > -1)
			{
				//Set up character to use those settings.
				characterManager.InitializeSettingsForCharacter(charId, charSettings);
				//Update user settings as the character's data may have changed.
				userSettings.UpdateAllGraphicSettingsForCharacter(characterName, characterManager.GetCharacterGraphicSettings(charId));
				userSettings.UpdateColorSettingsForCharacter(characterName, characterManager.GetCharacterColorData(charId));
				userSettings.UpdateLinkedColorGroupSettingsForCharacter(characterName, characterManager.GetCharacterLinkedColorGroupData(charId));
				userSettings.UpdateSettingForCharacter_AnimationLists(characterName, characterManager.GetAnimationListsForCharacterInBinaryFormat(charId));
				
				//Insert something here for menu to update
				//mainMenu.SetupMenusForCharacter(charId, charSettings);
			}
		}
		
	}

}