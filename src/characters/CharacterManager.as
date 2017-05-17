package characters 
{
	import animations.AnimationList;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author 
	 */
	public class CharacterManager 
	{
		
		private var m_charNamesDict:Dictionary = new Dictionary(); //Maps the character's name to an id number(int) (ie. "Peach" has an id of 0)
		private var m_Characters:Vector.<Character> = new Vector.<Character>();
		
		//Holds the id of the character to switch to next time a automatic character switch occurs.
		private var m_nextCharacterId:int = 0;
		//The character that is being managed.
		private var m_currentCharacter:Character = null;
		//The character that is being displayed on the stage.
		//private var m_latestCharacter:AnimatedCharacter = null;
		
		//0 is in order, 1 is random, 2 is one character
		private var m_characterSelectMode:int = 0;
		
		//Controls whether the user wants character switching to be allowed or not.
		//private var m_allowCharSwitches:Boolean = true;
		//Controls whether the user wants a character to be randomly picked when it's switching time.
		//private var m_selectRandomChar:Boolean = false;
		//Indicates if a character is locked, meaning they can't be switched to. The index of the vector correspondes to the character's id.
		private var m_characterLocks:Vector.<Boolean> = new Vector.<Boolean>();
		//Keep a tally of how many characters are not able to be switched to.
		private var m_unswitchableCharactersNum:int = 0;
		
		//"global" character and animation switch lock. Meant to be used for linked animation transitions so that they happen uninterrupted.
		private var transitionLockout:Boolean = false;
		
		public function CharacterManager() 
		{
			
		}
		
		public function CharacterSwitchLogic():void
		{
			if (m_currentCharacter != null && (CheckIfTransitionLockIsActive() == true || !CheckCharactersForSwitchEligibility()))	{ return; }
			
			var numChars:int = m_Characters.length;
			//Sequential character changing
			if(m_characterSelectMode == 0)
			{
				//character list wrap around
				if(m_nextCharacterId + 1 >= numChars)
				{
					m_nextCharacterId = 0;
				}
				else
				{
					//go to next character
					++m_nextCharacterId;
				}
				//Make sure the character can be switched to. If not, cycle through until we find one we can switch to
				while(m_characterLocks[m_nextCharacterId] == true || DoesCharacterHaveAnimations(m_nextCharacterId) == false)
				{
					if(m_nextCharacterId + 1 >= numChars)
					{
						m_nextCharacterId = 0;
					}
					else
					{
						++m_nextCharacterId;
					}
				}
			}
			else if(m_characterSelectMode == 1)
			{
				/*Randomly select a character. If a disallowed switch occur, keep rerolling.*/
				var switchOk:Boolean = false;
				var charactersAllowed:int = 0;
				for(var i:int = 0; i < numChars; ++i)
				{
					if(m_characterLocks[i] == false && DoesCharacterHaveAnimations(i))	{++charactersAllowed;}
				}
				/*if(charactersAllowed <= 1) //Too limited of a pool of characters to pick from. To avoid a potential error and waste of time, just bypass switching characters and stick with the current one.
				{
					switchOk = true;
				}
				else*/
				{
					while(!switchOk)
					{
						var randomCharId:int = int(Math.random() * numChars);
						
						if(m_characterLocks[randomCharId] == false && DoesCharacterHaveAnimations(randomCharId) == true)
						{
							if(charactersAllowed <= 2)
							{
								m_nextCharacterId = randomCharId;
								switchOk = true;
							}
							else
							{
								if(m_nextCharacterId != randomCharId)
								{
									m_nextCharacterId = randomCharId;
									switchOk = true;
								}
							}
						}
					}
				}
			}
		}
		
		//Tests if the character of the given id has animations.
		public function DoesCharacterHaveAnimations(charId:int):Boolean
		{
			if (charId > -1 && charId < GetTotalNumOfCharacters())
			{
				return (m_Characters[charId].GetNumberOfFilledAnimationSlots() > 0) ? true : false;
			}
			//Invalid id, so technically the char id given does not have any animations.
			return false;
		}
		
		//Returns the id of the character that was switched to. Returns -1 if no switch happened
		public function GetIdOfCharacterToSwitchTo():int
		{
			var charSwitchOccured:int = -1;
			if (m_currentCharacter != null && CheckIfTransitionLockIsActive())	{return charSwitchOccured; }
			
			var currentCharacter:Character = m_Characters[m_nextCharacterId];//m_currentCharacter;
			//If the current character selected is not the latest one being displayed, there needs to be some changes to get them on screen.
			if (m_currentCharacter != currentCharacter)
			{				
				//Update user settings
				//userSettings.currentCharacterName = GetCurrentCharacter().GetName();
				//Update latest char id 
				m_currentCharacter = currentCharacter;
				charSwitchOccured = m_nextCharacterId;
			}
			//currentCharacter.OnAccessibleAnimationCheck();
			currentCharacter.RandomizePlayAnim();
			currentCharacter.PlayingLockedAnimCheck();
			//currentCharacter.ChangeAnimationIndexToPlay();
			//currentCharacter.GotoFrameAndPlayForCurrentAnimation(setFrameForAnimation);
			return charSwitchOccured;
		}
		
		public function CheckIfCharacterCanBeAdded(charName:String):Boolean
		{
			//var charName:String = character.GetName();
			//Make sure no character with this name already exists.
			var numChars:int = m_Characters.length;	// SMLSE OPTIMIZE ATTEMPT
			for (var x:int = 0; x < numChars; ++x)
			{
				if (charName == m_Characters[x].GetName())
				{
					//logger.warn("A character with the name \"" + charName + "\" was already added");
					return false;
				}
			}
			return true;
		}
		
		/*Adds a new character to be able to be shown. Returns the character's id if the character was added successfully. Should be called only after CheckIfCharacterCanBeAdded
		has been used to verify that the character can be added.*/
		public function AddNewCharacter(name:String, charData:Object, isPresetCharacter:Boolean = false, presetAnimationLists:Vector.<AnimationList>=null):int
		{
			if (name in m_charNamesDict) { return -1;}
			var character:Character = new Character(name, charData, isPresetCharacter, presetAnimationLists);
			return AddCharacter(character);
			/*var charactersCount:int = m_Characters.length;
			character.SetID(charactersCount);
			//var charAdded:Boolean = false;
			//var charName:String = character.GetName();
			m_charNamesDict[name] = charactersCount;
			m_characterLocks[charactersCount] = false;
			m_Characters[charactersCount] = character;
			return character.GetID();*/

		}
		
		[inline]
		private function AddCharacter(character:Character):int
		{
			var charactersCount:int = m_Characters.length;
			character.SetID(charactersCount);
			//var charAdded:Boolean = false;
			//var charName:String = character.GetName();
			m_charNamesDict[character.GetName()] = charactersCount;
			m_characterLocks[charactersCount] = false;
			m_Characters[charactersCount] = character;
			return character.GetID();
		}
		
		public function DuplicateCharacter(nameOfCharToCopy:String, nameForCopyChar:String):int
		{
			if (GetCharacterIdByName(nameForCopyChar) == -1 && GetCharacterIdByName(nameOfCharToCopy) > -1)
			{
				//var character:Character = new Character("_Temp", null);
				//character.ImportCharacterDataFromStorage(m_Characters[GetCharacterIdByName(nameOfCharToCopy)].GetDefaultSettings());
				var character:Character = m_Characters[GetCharacterIdByName(nameOfCharToCopy)].CloneCharacter(nameForCopyChar);
				return AddCharacter(character);
			}
			return -1;
		}
		
		//Returns an array with 2 values. First value is the name of the character and the second value is a result value, 1 if it actually deleted the character, returns 0 if the character was reset (which happens when the character was created from a template character mod) and -1 if there was no delete or reset.
		public function DeleteOrResetCharacter(charId:int):Array
		{
			var charId:int = charId;
			if (charId >= 0 && charId < m_Characters.length)
			{
				var character:Character = m_Characters[charId];
				var charName:String = character.GetName();
				if (character.IsResettable())
				{
					character.Reset();
					return [charName, 0];
				}
				else
				{
					m_Characters[charId] = null;
					m_characterLocks[charId] = null;
					/*m_Characters = */m_Characters.splice(charId, 1);
					/*m_characterLocks = */m_characterLocks.splice(charId, 1);
					delete m_charNamesDict[charName];
					if (character == m_currentCharacter) { m_currentCharacter = null; }
					
					character = null;
					
					
					for (var i:int = charId, l:int = m_Characters.length; i < l; i++) 
					{
						m_Characters[i].SetID(i);
						m_charNamesDict[m_Characters[i].GetName()] = i;
					}
					return [charName, 1];
				}
				
			}
			return [charName, -1];
		}
		
		public function AddAnimationSlotToCurrentCharacter():Boolean
		{
			if (m_currentCharacter)
			{
				m_currentCharacter.AddAnimationSlot();
				return true;
			}
			return false;
		}
		
		public function RemoveAnimationSlotOfCurrentCharacter(index:int):Boolean
		{
			if (m_currentCharacter)
			{
				return m_currentCharacter.RemoveAnimationSlot(index);
			}
			return false;
		}
		
		public function SaveAnimationForCurrentAnimation(index:int, animateList:AnimationList):Boolean
		{
			if (m_currentCharacter)
			{
				m_currentCharacter.SaveAnimationToSlot(index, animateList);
				return true;
			}
			return false;
		}
		
		public function GetAnimationListForCurrentCharacter(animId:int):AnimationList
		{
			if (m_currentCharacter)
			{
				return m_currentCharacter.GetAnimationList(animId);
			}
			return null;
		}
		
		//Returns a list of booleans indicating if the corresponding animation of a character is empty or has an animationlist.
		public function GetCurrentCharacterAnimationStates():Vector.<Boolean>
		{
			if (m_currentCharacter)
			{
				return m_currentCharacter.GetAnimationStates();
			}
			return null;
		}
		
		public function SwitchToCharacter(charIndex:int=-1, instantSwitch:Boolean=false):int
		{
			//Undefined index, fall back to the first character
			if(charIndex == -1)
			{
				return charIndex;
			}
			else if (charIndex >= m_Characters.length)
			{
				charIndex = m_Characters.length -1;
			}
			if (instantSwitch)
			{
				m_currentCharacter = m_Characters[charIndex];
				m_nextCharacterId = charIndex;
			}
			else if(m_characterLocks[charIndex] == false && m_currentCharacter != m_Characters[charIndex])
			{
				//m_currentCharacter = m_Characters[charIndex];
				
				m_nextCharacterId = charIndex;
				//UpdateAndDisplayCurrentCharacter();
				//userSettings.currentCharacterName = GetCurrentCharacter().GetName();
				
			}
			return m_nextCharacterId;
		}
		
		public function UpdateGraphicSettingForCurrentCharacter(actorName:String, setName:String, layer:int):void
		{
			m_currentCharacter.UpdateGraphicSetting(actorName, setName, layer);
		}
		
		public function GetAnimationListsForCharacterInBinaryFormat(charId:int):ByteArray
		{
			return m_Characters[charId].SerializeAnimationLists();
		}
		
		public function InitializeSettingsForCharacter(charId:int, settings:Object):void
		{
			
			//var animLockObject:Object = settings.animationLocked;
			
			//if (animLockObject["null"] != null) { delete animLockObject["null"]; }
			
			var character:Character = m_Characters[charId];
			character.data.graphicSettings = settings.graphicSettings;
			if ("colors" in settings)
			{
				character.data.Color = settings.colors;
			}
			else
			{
				//There was no colorize data in the settings, so update the settings to have the colorize data in the character if that exists.
				if ("Color" in character.data)
				{
					settings.colors = character.data.Color;
				}
			}
			
			character.DeserializeAnimationLists(settings.animationLists);
			/*var lockedAnimationCount:int = 0;
			
			var accessibleAnimationsCount:int = character.GetNumberOfAccessibleAnimations();
			
			//If character has no animations then lock them.
			if (accessibleAnimationsCount == 0)
			{
				m_characterLocks[charId] = true;
				settings.locked = true;
				return;
			}*/
			
			//var animationSettingsIsEmpty:Boolean = true;
			/*Check to make sure that all loaded animations for the character are not locked. If they are
			* then they all need to be unlocked*/ 
			/*for (var name:String in settings.animationLocked) 
			{
				//animationSettingsIsEmpty = false;
				//If animation by the given name exists and the animation is not locked
				if(character.GetIdOfAnimationName(name) > -1 && settings.animationLocked[name] == true)
				{
					//Flag that all animations are not locked and break out the for loop
					++lockedAnimationCount;
				}
			}
			//var animationName:String;
			if (lockedAnimationCount >= accessibleAnimationsCount)
			{
				logger.warn("All animations for " + character.GetName() + " were locked. Unlocking all their animations.");
				//All animations were locked, so unlock them all to be safe.
				for (var i:int = 0; i < accessibleAnimationsCount; i++) 
				{
					character.SetLockOnAnimation(i, false);
					settings.animationLocked[character.GetNameOfAnimationByIndex(i)] = false;
				}
			}
			else
			{
				for (var animationName:String in animLockObject)
				{
					var animId:int = character.GetIdOfAnimationName(animationName);
					character.SetLockOnAnimationByName(animationName, animLockObject[animationName]);
				}
			}*/
			m_characterLocks[charId] = settings.locked;
			
			if (settings.locked == true)
			{
				++m_unswitchableCharactersNum;
			}
			/*var animSelect:int = character.GetIdOfAnimationName(settings.animationSelect);
			
			if (animSelect < 0 || character.GetAnimationLockedStatus(character.GetAnimationIdTargets().indexOf(animSelect)) == true)
			{
				//No id was found or the animation was locked, so go random instead.
				character.SetRandomizeAnimation(true);
			}
			else
			{
				character.SetRandomizeAnimation(false);
				character.ChangeAnimationIndexToPlay(animSelect);
			}*/
		}
		
		public function SetSelectMode(mode:int):int
		{
			if (mode > 2 || mode < 0) { mode = 0;}
			m_characterSelectMode = mode;
			return m_characterSelectMode;
		}
		
		public function GetSelectMode():int
		{
			return m_characterSelectMode;
		}
		
		public function GetCharacterInfo(name:String):Array
		{
			if (name in m_charNamesDict)
			{
				var charId:int = m_charNamesDict[name];
				var character:Character = m_Characters[charId];
				return [name, character.GetDefaultMusicName(), IsCharacterLocked(charId), character.IsResettable()];
			}
			return null;
			
		}
		
		public function IsCharacterLocked(characterId:int):Boolean
		{
			return m_characterLocks[characterId];
		}
		
		[inline]
		public function GetCharacterIdByName(name:String):int
		{
			var id:int = -1;
			if (name in m_charNamesDict)
			{
				id = m_charNamesDict[name];
			}
			return id;
		}
		
		[inline]
		public function GetCharacterNameById(charId:int):String
		{
			var name:String = null;
			if (charId > -1 && charId < m_Characters.length)
			{
				name = m_Characters[charId].GetName();
			}
			return name;
		}
		
		public function GetCurrentCharacterName():String
		{
			if (m_currentCharacter)
			{
				return m_currentCharacter.GetName();
			}
			return null;
		}
		
		public function GetCharacterColorData(charId:int):Object
		{
			var characterData:Object = m_Characters[charId].data;
			if (characterData && "Color" in characterData)
			{
				return characterData.Color;
			}
			return null;
		}
		
		public function GetCharacterGraphicSettings(charId:int):Object
		{
			var characterData:Object = m_Characters[charId].data;
			if (characterData && "graphicSettings" in characterData)
			{
				for (var name:String in characterData.graphicSettings) 
				{
					return characterData.graphicSettings;
				}
			}
			return null;
		}
		
		public function GetCharacterGraphicSets(charId:int):Object
		{
			var characterData:Object = m_Characters[charId].data;
			if (characterData && "GraphicSets" in characterData)
			{
				return characterData.GraphicSets;
			}
			return null;
		}
		
		public function IsACharacterSelected():Boolean
		{
			return (m_currentCharacter != null);
		}
		
		
		public function CheckIfTransitionLockIsActive():Boolean
		{
			if (m_currentCharacter == null) { return false;}
			return (transitionLockout == true) /*|| m_currentCharacter.IsStillInLinkedAnimation()*/;
		}
		
		public function SetLockOnCurrentCharacter(locked:Boolean):Boolean
		{
			var charIndex:int = m_currentCharacter.GetID();
			//Test if setting this character to be unselectable will result in all characters being unselectable
			if (m_characterLocks[charIndex] == false && m_unswitchableCharactersNum + 1 >= m_Characters.length)
			{
				//logger.debug("Could not lock character {0}", GetCharacterNameById(charIndex));
				return false; //Need to exit the function immediantly, 1 character must always be selectable.
			}
			m_characterLocks[charIndex] = !m_characterLocks[charIndex];
			//userSettings.characterSettings[m_Characters[charIndex].GetName()].canSwitchTo = m_canSwitchToCharacter[charIndex];
			if (m_characterLocks[charIndex] == true)
			{
				++m_unswitchableCharactersNum;
			}
			else
			{
				--m_unswitchableCharactersNum;
			}
			//logger.debug("Character {0} is {1}", GetCharacterNameById(charIndex), m_characterLocks[charIndex] ? "Locked" : "Unlocked");
			return m_characterLocks[charIndex];
		}
		
		[inline]
		public function GetTotalNumOfCharacters():int
		{
			return m_Characters.length;
		}
		
		//Tests if there are any characters that can be switched to. To be eligible, a character must not be locked and must have at least one animation list assigned to a slot. Returns true if there is a character that can be switched to, false if there are no characters that can be switched to.
		public function CheckCharactersForSwitchEligibility():Boolean
		{
			var charactersAvailable:Boolean = false;
			for (var i:int = 0, l:int = m_Characters.length; i < l; i++) 
			{
				if (DoesCharacterHaveAnimations(i) == true && m_characterLocks[i] == false)
				{
					charactersAvailable = true;
					break;
				}
			}
			return charactersAvailable;
		}
		
		//Checks the character's animations to make sure at least 1 animation that is not an end link animation is accessible.
		//If there are none, unlock every animation that is not an end link.
		public function CheckLocksForCurrentCharacter(charId:int):void
		{
			if (charId < 0 || charId >= m_Characters.length) { return; }
			
			var character:Character = m_Characters[charId];
			var accessibleAnimations:Array = character.GetAccessibleAnimationsIndices();
			if (character.GetNumberOfLockedAnimations() >= accessibleAnimations.length)
			{
				//Unlock every single animation.
				for (var i:int = 0, l:int = character.GetNumberOfAnimationSlots(); i < l; ++i)
				{
					character.SetLockOnAnimation(i, false);
				}
			}
		}
		
		public function GetCurrentAnimationIdOfCharacter():int
		{
			return m_currentCharacter.GetCurrentAnimationId();
		}
	}

}