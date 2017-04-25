package characters 
{
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
		
		//Controls whether the user wants character switching to be allowed or not.
		private var m_allowCharSwitches:Boolean = true;
		//Controls whether the user wants a character to be randomly picked when it's switching time.
		private var m_selectRandomChar:Boolean = false;
		//Indicates if a character is locked, meaning they can't be switched to. The index of the vector correspondes to the character's id.
		private var m_characterLocks:Vector.<Boolean> = new Vector.<Boolean>();
		//Keep a tally of how many characters are not able to be switched to.
		private var m_unswitchableCharactersNum:int = 0;
		
		//"global" character and animation switch lock. Meant to be used for linked animation transitions so that they happen uninterrupted.
		private var transitionLockout:Boolean = false;
		
		public function CharacterManager() 
		{
			
		}
		
		public function CheckIfCharacterCanBeAdded(character:Character):Boolean
		{
			var charName:String = character.GetName();
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
		public function AddCharacter(character:Character):int
		{
			//var charAdded:Boolean = false;
			var charName:String = character.GetName();
			m_charNamesDict[charName] = m_Characters.length;
			m_characterLocks[m_Characters.length] = false;
			m_Characters[m_Characters.length] = character;
			return m_Characters.length - 1;

		}
		
		public function SwitchToCharacter(charIndex:int=-1, instantSwitch:Boolean=false):int
		{
			//Undefined index, fall back to the first character
			if(charIndex == -1)
			{
				charIndex = 0;
			}
			if(m_characterLocks[charIndex] == false && m_currentCharacter != m_Characters[charIndex])
			{
				if (instantSwitch)
				{
					m_currentCharacter = m_Characters[charIndex];
				}
				
				m_nextCharacterId = charIndex;
				//UpdateAndDisplayCurrentCharacter();
				//userSettings.currentCharacterName = GetCurrentCharacter().GetName();
				
			}
			return m_nextCharacterId;
		}
		
		public function GetCharacterInfo(name:String):Array
		{
			if (name in m_charNamesDict)
			{
				var character:Character = m_Characters[m_charNamesDict[name]];
				return [name, character.GetDefaultMusicName(), IsCharacterLocked(m_charNamesDict[name])];
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
		
		public function GetCurrentCharacterColorData():Object
		{
			var characterData:Object = m_currentCharacter.data;
			if (characterData && "Color" in characterData)
			{
				return characterData.Color;
			}
			return null;
		}
		
		public function GetCurrentCharacterGraphicSets():Object
		{
			var characterData:Object = m_currentCharacter.data;
			if (characterData && "GraphicSets" in characterData)
			{
				return characterData.GraphicSets;
			}
			return null;
		}
	}

}