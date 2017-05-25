package characters
{
	import animations.AnimationList;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import flash.net.registerClassAlias;
	
	public class Character 
	{
		//private var m_CharMC:MovieClip = null; //The movie clip that contains all the animations of the character
		//private var m_InDiamondMC:MovieClip = null;
		//private var m_OutDiamondMC:MovieClip = null;
		//private var m_ColorTransform:ColorTransform = null;
		//private var m_BacklightColor:uint = null;
		//private var m_TransitionDiamondMC:MovieClip = null;
		//private var m_defOutDiaMC:Boolean = true;
		//private var m_defInDiaMC:Boolean = true;
		//private var m_defTransDiaMC:Boolean = true;
		
		//Data and properties to reset to for a character
		public var data:Object = new Object;
		//Data and properties used by the program.
		//public var currentData:Object;
		//Flag that determines if the id number of the character can be set.
		//protected var idSet:Boolean = false;
		
		protected var m_Id:int = -1; //The id number of the character. Can change depending on the order that characters
		protected var m_name:String;
		//protected var m_playAnimationFrame:int = 0
		
		/*The id of the characters animation collection that is slated to play or is playing currently. -1 indicates nothing is playing.
		 * Value corresponds to the index of the character animationlist vector*/
		private var m_currentAnimationId:int = -1;
		
		protected var m_randomizePlayAnim:Boolean = true;
		protected var m_lockedAnimation:Vector.<Boolean>; //Keeps track if an animation can be switched to.
		
		protected var m_defaultMusicName:String = "";
		
		//The music to play for this specific character
		protected var selectedMusicId:int = -1;
		//private var m_numOfLockedAnimations:int = 0;
		//Indicates if the various properties for the character can be changed. Characters created from a Character Mod can never have their data changed once created.
		protected var defaultSettings:ByteArray = null;
		
		protected var animationLists:Vector.<AnimationList>;
		
		//Indicates whether the animation in the animationLists vector of the corresponding index is a regular animation or an end-link animation. True indicates a regular animation (that can possibly transition to an end link type).
		protected var animationTypes:Vector.<int> = new Vector.<int>();
		
		public function Character(name:String, charData:Object, isPresetCharacter:Boolean = false, presetAnimationLists:Vector.<AnimationList>=null)
		{
			registerClassAlias("AnimationList", AnimationList);
			registerClassAlias("ColorTransform", ColorTransform);
			m_lockedAnimation = new Vector.<Boolean>();
			m_name = name;
			if (charData)
			{
				data = charData;
			}
			SetAnimationLists(presetAnimationLists);
			//if(animationList
			if (isPresetCharacter)
			{
				defaultSettings = ExportCharacterDataForStorage();
			}
			
			
		}
		
		[inline]
		public function SetAnimationLists(animationPresets:Vector.<AnimationList>):void
		{
			if (animationPresets != null){
				animationLists = animationPresets;
			}
			else {
				animationLists = new Vector.<AnimationList>();
			}
			animationTypes = new Vector.<int>(animationLists.length);
			m_lockedAnimation = new Vector.<Boolean>(animationLists.length);

			for (var i:int = 0, l:int = animationLists.length; i < l; i++) 
			{
				animationTypes[i] = animationLists[i].AnimationType;
			}
			for (var i:int = 0, l:int = animationLists.length; i < l; i++) 
			{
				m_lockedAnimation[i] = false;
			}
		}
		
		public function ChangeDefaultSettings(characterPreset:Character):void
		{
			if (characterPreset == null)
			{
				defaultSettings = null;
			}
			else
			{
				defaultSettings = characterPreset.ExportCharacterDataForStorage();
			}
		}
		
		public function SetName(name:String):void
		{
			m_name = name;
		}
		
		public function SetID(idNumber:int):void
		{
			//if (m_Id == -1)
			//{
				m_Id = idNumber;
				//idSet = true;
			//}
		}
		
		public function AddAnimationSlot():void
		{
			if (animationLists == null)
			{
				animationLists = new Vector.<AnimationList>;
			}
			animationLists[animationLists.length] = new AnimationList();
			m_lockedAnimation[m_lockedAnimation.length] = false;
			animationTypes[animationTypes.length] = 0;
		}
		
		public function RemoveAnimationSlot(index:int):Boolean
		{
			if (animationLists && index >= 0 && index < animationLists.length)
			{
				/*animationLists = */animationLists.splice(index, 1);
				/*m_lockedAnimation = */m_lockedAnimation.splice(index, 1);
				animationTypes.splice(index, 1);
				return true;
			}
			return false;
		}
		
		public function UpdateGraphicSetting(actorName:String, setName:String, layer:int):void
		{
			if (!("graphicSettings" in data))
			{
				data.graphicSettings = new Object();
			}
			if (!(actorName in data.graphicSettings))
			{
				data.graphicSettings[actorName] = ["", "", ""];
			}
			data.graphicSettings[actorName][layer] = setName;
		}
		
		public function SaveAnimationToSlot(index:int, animateList:AnimationList):void
		{
			if (animationLists && index >= 0 && index < animationLists.length)
			{
				animationLists[index] = animateList;
			}
		}
		
		public function GetAnimationStates():Vector.<Boolean>
		{
			if (!animationLists) { return null; }
			
			var animationStates:Vector.<Boolean> = new Vector.<Boolean>;
			for (var i:int = 0, l:int = animationLists.length; i < l; i++) 
			{
				if (animationLists[i] == null)
				{
					animationStates[animationStates.length] = false;
				}
				else
				{
					animationStates[animationStates.length] = !(animationLists[i].IsAnimListEmpty());
				}
			}
			return animationStates;
		}
		
		public function IsResettable():Boolean { return defaultSettings != null;}
		public function GetID():int { return m_Id;}
		public function GetName():String { return m_name; }
		public function GetDefaultMusicName():String { return m_defaultMusicName; }
		public function GetAnimationList(animId:int):AnimationList
		{
			if (animationLists && animId >= 0 && animId < animationLists.length)
			{
				return animationLists[animId];
			}
			return null;
		}
		
		public function Reset():void
		{
			ImportCharacterDataFromStorage(defaultSettings);
		}
		
		public function ExportCharacterDataForStorage():ByteArray
		{
			var characterByteArray:ByteArray = new ByteArray();
			characterByteArray.writeObject(m_name);
			characterByteArray.writeObject(data);
			characterByteArray.writeObject(m_defaultMusicName);
			characterByteArray.writeBoolean(m_randomizePlayAnim);
			characterByteArray.writeObject(m_lockedAnimation);
			characterByteArray.writeObject(animationLists);
			characterByteArray.writeObject(animationTypes);
			return characterByteArray;
		}
		
		public function ImportCharacterDataFromStorage(charStorageData:ByteArray):void
		{
			charStorageData.position = 0;
			m_name = charStorageData.readObject();
			data = charStorageData.readObject();
			m_defaultMusicName = charStorageData.readObject();
			m_randomizePlayAnim = charStorageData.readBoolean();
			m_lockedAnimation = charStorageData.readObject();
			animationLists = charStorageData.readObject();
			animationTypes = charStorageData.readObject();
			if (animationTypes.length < animationLists.length)
			{
				for (var i:int = 0, l:int = animationLists.length; i < l; i++) 
				{
					animationTypes[i] = 0;
				}
			}
			
			if (m_lockedAnimation.length < animationLists.length)
			{
				for (var i:int = 0, l:int = animationLists.length; i < l; i++) 
				{
					m_lockedAnimation[i] = false;
				}
			}
			
		}
		
		public function GetDefaultSettings():ByteArray
		{
			return defaultSettings;
		}
		
		public function CloneCharacter(cloneName:String):Character
		{
			//Do some name swapping so the export and import functions can be used to create the new character.
			var originalName:String = this.m_name;
			m_name = cloneName;
			var clonedCharacter:Character = new Character("_Clone", null);
			clonedCharacter.ImportCharacterDataFromStorage(this.ExportCharacterDataForStorage());
			//Restore this character's name.
			this.m_name = originalName;
			return clonedCharacter; 
		}
		
		public function SerializeAnimationLists():ByteArray
		{
			var animationsByteArray:ByteArray = new ByteArray();
			animationsByteArray.writeObject(animationLists);
			return animationsByteArray;
		}
		
		public function DeserializeAnimationLists(animationListsBinaryData:ByteArray):void
		{
			if (animationListsBinaryData)
			{
				animationListsBinaryData.position = 0;
				animationLists = animationListsBinaryData.readObject() as Vector.<AnimationList>;
				if (animationTypes.length < animationLists.length)
				{
					for (var i:int = 0, l:int = animationLists.length; i < l; i++) 
					{
						animationTypes[i] = 0;
					}
				}
				if (m_lockedAnimation.length < animationLists.length)
				{
					for (var i:int = 0, l:int = animationLists.length; i < l; i++) 
					{
						m_lockedAnimation[i] = false;
					}
				}
			}
		}
		
		public function GetNumberOfAnimationSlots():int
		{
			return animationLists.length;
		}
		
		public function GetNumberOfFilledAnimationSlots():int
		{
			if (animationLists == null) { return 0;}
			var count:int;
			for (var i:int = 0,l:int = animationLists.length; i < l; i++) 
			{
				if (animationLists[i] != null && animationLists[i].IsAnimListEmpty() == false)
				{
					++count;
				}
			}
			return count;
		}
		
		/*"accessible" animations are animations that are not end linked animations (meaning, they must be manually activated by the user
		 * with a special command)*/
		[inline]
		public function GetAccessibleAnimationsIndices():Array
		{
			var accessibleArray:Array = [];
			for (var i:int = 0, l:int = animationLists.length; i < l; i++) 
			{
				if (animationTypes[i] == 0)
				{
					accessibleArray[accessibleArray.length] = i;
				}
			}
			return accessibleArray;
		}
		
		public function SetLockOnAnimation(animId:int, lockValue:Boolean):void
		{
			if (animId < 0 || animId >= animationLists.length) { return;}
			//logger.debug("Trying to set lock on animation {0} (id {1}) to {2}",GetNameOfAnimationByIndex(indexForId),  animId, lockValue);
			/*Conditions that will not have a set locked:
			 * 1) animation type for the id is an end link animation (These are always unlocked but will be skipped in most cases.) 
			 * 2) if lockValue is true: setting the lock on the given animation will lead to all standard type animations being locked.*/
			if (animationTypes[animId] != 0 ||(lockValue == true && GetNumberOfLockedAnimations() + 1 >= GetAccessibleAnimationsIndices().length) )
			{
				//logger.debug("Could not change lock on animation {0} (id {1})", GetNameOfAnimationByIndex(indexForId),  animId);
				return;
			}
			m_lockedAnimation[animId] = lockValue;
		}
		
		[inline]
		public function GetNumberOfLockedAnimations():int
		{
			var lockedAnimNum:int = 0;
			var numLockedAnims:int = m_lockedAnimation.length;
			for (var i:int = 0; i < numLockedAnims; ++i)
			{
				if(m_lockedAnimation[i] == true)
				{
					++lockedAnimNum;
				}
			}
			return lockedAnimNum;
		}
		
		public function GetCurrentAnimationId():int
		{
			return m_currentAnimationId;
		}
		
		public function SetRandomizeAnimation(randomStatus:Boolean):void
		{
			m_randomizePlayAnim = randomStatus;
		}
		
		public function GetRandomAnimStatus() : Boolean
		{
			return m_randomizePlayAnim;
		}
		
		public function RandomizePlayAnim(loadedAnimationNames:Vector.<String>, forceRandomization:Boolean=false):void
		{
			if (!loadedAnimationNames || loadedAnimationNames.length  < 1) { m_currentAnimationId = -1; return; }
			var cantSelectAnimation:Boolean = true;
			//Do a scan on all animation lists for the character to make sure that at least one animation list is for one of the loaded animations.
			for (var i:int = 0, l:int = animationLists.length; i < l; i++) 
			{
				if (loadedAnimationNames.indexOf(animationLists[i].TargetAnimationName) > -1)
				{
					cantSelectAnimation = false;
					break;
				}
			}
			if (cantSelectAnimation) {
				m_currentAnimationId = -1; return;
			}
			
			if(m_randomizePlayAnim || forceRandomization == true)
			{
				//Randomly select a number out of the number of accessible animations
				//var accessibleAnimationCount:int = GetNumberOfAccessibleAnimations();
				var randomAccessibleAnimId:int = RandomlySelectAnimationId();
				var standardAnimationIndices:Array = GetAccessibleAnimationsIndices();
				if((standardAnimationIndices.length - GetNumberOfLockedAnimations()) > 2)
				{
					while( GetAnimationLockedStatus(randomAccessibleAnimId) || loadedAnimationNames.indexOf(animationLists[randomAccessibleAnimId].TargetAnimationName) == -1)
					{
						randomAccessibleAnimId = RandomlySelectAnimationId();
					}
				}
				m_currentAnimationId = randomAccessibleAnimId;
				
				//ChangeAnimationIndexToPlay(randomAnimIndex);
			}
		}
		
		public function PlayingLockedAnimCheck():void
		{
			//Make sure the currently playing animation can be locked.
			//animation id are already the accessible animations.

			//id returned was -1, meaning the animation at the index was not accessible.
			if (m_currentAnimationId == -1) { return;}
			if(m_lockedAnimation[m_currentAnimationId] && (GetAccessibleAnimationsIndices().length - GetNumberOfLockedAnimations() == 1))
			{
				var unlockedAnimNum:int = 0;
				for (var i:int = 0, l:int = m_lockedAnimation.length; i < l; i++) 
				{
					if (m_lockedAnimation[i] == false)
					{
						break;
					}
					++unlockedAnimNum;
				}
				m_currentAnimationId = unlockedAnimNum;
				/*for each(var locked:Boolean in m_lockedAnimation)
				{
					if(!locked)
					{
						break;
					}
					++unlockedAnimNum;
				}
				m_currentAnimationIndex = m_idTargets[unlockedAnimNum];*/
				//ChangeAnimationIndexToPlay(unlockedAnimNum);
			}
		}
		
		[inline]
		private function RandomlySelectAnimationId():int
		{
			var accessibleAnimations:Array = GetAccessibleAnimationsIndices();
			if (accessibleAnimations.length == 0) { return -1; }
			
			return accessibleAnimations[Math.floor(Math.random() * accessibleAnimations.length)];
		}
		
		//Checks if an accessible animation is locked or unlocked.
		public function GetAnimationLockedStatus(animId:int):Boolean
		{
			return m_lockedAnimation[animId];
		}
		
		
		
		//public function GetIf
		/*public function GetDiamondColor1():uint { return m_innerDiamondColor1;}
		public function GetDiamondColor2():uint{ return m_innerDiamondColor2;}
		public function GetDiamondColor3():uint { return m_innerDiamondColor3;}
		public function GetOuterDiamondColor():uint { return m_outerDiamondColor; }
		public function GetBacklightColor():uint { return m_backlightColor;}	
		public function GetSkinColor():uint { return m_defaultSkinColor;}
		public function GetFaceGradients():Array{ return m_defaultSkinGradient_Face;}//2
		public function GetBreastGradients():Array{ return m_defaultSkinGradient_Breasts;}//3
		public function GetVulvaGradients():Array{ return m_defaultSkinGradient_Vulva;}//2
		public function GetAnusGradients():Array{ return m_defaultSkinGradient_Anus;}//2
		public function GetIrisLColor():uint { return m_defaultIrisLColor;}
		public function GetIrisRColor():uint { return m_defaultIrisRColor;}
		public function GetScleraColor():uint { return m_defaultScleraColor;}
		public function GetNippleColor():uint { return m_defaultNippleColor;}
		public function GetLipColor():uint { return m_defaultLipColor; }
		public function GetVoiceSet():Vector.<Sound> { return m_voiceSet; }
		public function GetVoiceCooldown():int { return m_voiceCooldown; }	
		public function GetVoicePlayChance():int { return m_voicePlayChance;}
		public function GetVoicePlayRate(): int { return m_voicePlayRate;}*/
	}
}
