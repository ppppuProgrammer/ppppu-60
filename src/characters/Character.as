package characters
{
	import animations.AnimationList;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import flash.net.registerClassAlias;
	import flash.utils.Dictionary;
	
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
		
		protected static var linkedColorGroupDefaults:Dictionary = new Dictionary;
		//linked color group 1 (Skin)
		linkedColorGroupDefaults["FaceColor"] = [1, 2, -1, -1];
		linkedColorGroupDefaults["SkinColor"] = [1, -1, -1, -1];
		linkedColorGroupDefaults["AnusColor"] = [-1, 1, -1, -1];		
		linkedColorGroupDefaults["BreastColor"] = [1, 1, 2, -1];
		//linked color group 2 (Skin 2)
		linkedColorGroupDefaults["VulvaColor"] = [2, 1, -1, -1];//2
		linkedColorGroupDefaults["EarColor"] = [2, 1, -1, -1];
		//linked group 3 (nipple and areola)
		linkedColorGroupDefaults["NippleColor"] = [3,-1,-1,-1];
		linkedColorGroupDefaults["AreolaColor"] = [3, 3, -1, -1];
		//Linked group 4 (Iris)
		linkedColorGroupDefaults["LeftIrisColor"] = [4,-1,-1,-1];
		linkedColorGroupDefaults["RightIrisColor"] = [4,-1,-1,-1];
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
			ValidateAndCorrectCharacterData();
			
			
			SetAnimationLists(presetAnimationLists);
			//if(animationList
			if (isPresetCharacter)
			{
				defaultSettings = ExportCharacterDataForStorage();
			}
			
			
		}
		
		//Goes through the data for the character to ensure that all necessary properties are set.
		public function ValidateAndCorrectCharacterData():void
		{
			//Make sure that the graphic settings field exists.
			if (!("graphicSettings" in data) || data.graphicSettings == null) { data.graphicSettings = { }; }
			
			//Make sure the color field exists
			if (!("Color" in data) || data.Color == null) { data.Color = { }; }
			
			//Make sure that each color group holds an array of 4 uints for color values.
			for (var colorGroup:String in data.Color) 
			{
				//Need to put the uint into a 4 index array as the color group may be used for gradients at a later time.
				if (data.Color[colorGroup] is uint)
				{
					data.Color[colorGroup] = [data.Color[colorGroup], 0x00000000, 0x00000000, 0x00000000];
				}
				else if (data.Color[colorGroup] is Array)
				{
					if ((data.Color[colorGroup] as Array).length < 4)
					{
						for (var i:int = (data.Color[colorGroup] as Array).length; i < 4; i++) 
						{
							data.Color[colorGroup][i] = 0x00000000;
						}
					}
				}
				
				//Color group aliasing
				if (colorGroup == "IrisColor") {
					//Make a clone array for the left iris
					data.Color["LeftIrisColor"] = UtilityFunctions.CloneObject(data.Color.IrisColor) as Array;
					//Use the original array for the right iris
					data.Color["RightIrisColor"] = data.Color.IrisColor;
					//Delete IrisColor as it should not be used from this point
					data.Color.IrisColor = null;
					delete data.Color.IrisColor;
				}
			}
			
			//Make sure the LinkedColorGroup field exists.
			if (!("LinkedColorGroup" in data) || data.LinkedColorGroup == null) { data.LinkedColorGroup = { }; }

			//Make sure each color group in the linked groups have an array of 4 values, defaulting to -1 (not linked) if an index is empty.
			for (var colorGroup:String in data.LinkedColorGroup) 
			{
				if (data.Color[colorGroup] is Array)
				{
					if ((data.Color[colorGroup] as Array).length < 4)
					{
						for (var i:int = (data.Color[colorGroup] as Array).length; i < 4; i++) 
						{
							data.Color[colorGroup][i] = -1;
						}
					}
				}
			}
			
			//Set up default linked groups for a character.
			for (var colorGroup:String in linkedColorGroupDefaults)	{
				//If the color group isn't in the linkedColorGroup then create the key for it and set an array of four -1s to it
				if (!(colorGroup in data.LinkedColorGroup)) {
					data.LinkedColorGroup[colorGroup] = [ -1, -1, -1, -1];
				}
				for (var i:int = 0; i < 4; i++) {
					//Only overwrite the value of the character's linked group if it is not linked and the default value has a non -1 value.
					if (data.LinkedColorGroup[colorGroup][i] == -1 && linkedColorGroupDefaults[colorGroup][i] != -1) {
						data.LinkedColorGroup[colorGroup][i] = linkedColorGroupDefaults[colorGroup][i];
					}
				}
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
			if (!(actorName in data.graphicSettings))
			{
				data.graphicSettings[actorName] = ["", "", ""];
			}
			data.graphicSettings[actorName][layer] = setName;
		}
		
		public function ChangeLinkedColorGroupNumber(colorGroupName:String, colorPoint:int, linkedGroupNumber:int):void {
			if (!(colorGroupName in data.LinkedColorGroup)) {
				//Check if the color group even has color values. If it doesn't, give it 4 values of 0
				if (!(colorGroupName in data.Color)) {
					data.Color[colorGroupName] = [0, 0, 0, 0]; 
				}
				//Assign unlinked (-1) values to the 4 color points of this color group.
				data.LinkedColorGroup[colorGroupName] = [ -1, -1, -1, -1];
			}
			data.LinkedColorGroup[colorGroupName][colorPoint] = linkedGroupNumber;
		}
		
		public function ModifyColorData(colorGroupName:String, colorValues:Vector.<uint>, colorPointChanged:int):void
		{
			var colorGroupsToChange:Array = data.LinkedColorGroup[colorGroupName];
			var linkedGroupFound:Boolean = false;
			if (colorGroupsToChange != null) {
				for (var i:int = 0,l:int = colorGroupsToChange.length; i < l; i++) {
					if (colorGroupsToChange[i] > 0) {
						linkedGroupFound = true;
						break;
					}
				}
			}
			var colorSettings:Object = data.Color;
			
			if (!linkedGroupFound) {
				colorSettings[colorGroupName][colorPointChanged] = colorValues[colorPointChanged];
			} else {
				var linkedColorGroupData:Object = data.LinkedColorGroup;
				//Iterate through the linked color groups for all the color groups.
				for (var currentGroup:String in linkedColorGroupData) 
				{
					var linkValues:Array = linkedColorGroupData[currentGroup];
					//Iterate through the 4 linked group numbers for the current color group
					for (var i:int = 0, l:int = linkValues.length; i < l; i++) 
					{
						
						var linkedGroupNumber:int = linkValues[i];
						//Check if one of the color values given to the function are to change 
						/*var modifiedGroupNumberIndex:int = (linkedGroupNumber == -1)? -1 : colorGroupsToChange.indexOf(linkValues[i]);*/
						
						//Since this is the color value being directly edited by the user allow the alpha value to change
						if (currentGroup == colorGroupName && currentGroup in colorSettings && i == colorPointChanged)
						{
							colorSettings[currentGroup][i] = colorValues[i];	
						}
						else if (linkedGroupNumber > 0 && linkedGroupNumber == colorGroupsToChange[colorPointChanged] && currentGroup in colorSettings) {
							var originalColor:uint = colorSettings[currentGroup][i];
							//Preserve the alpha value
							var alpha:uint = originalColor & 0xFF;
							//Get just the RGB value of the new color value
							var rawNewColor:uint = colorValues[colorPointChanged];
							var newRGBColor:uint =  (rawNewColor >>> 8);
							var finalColor:uint = (newRGBColor << 8) | alpha;
							colorSettings[currentGroup][i] = finalColor;							
						}
					}
				}
			}		
		}
		
		public function GetLinkedColorGroupNumber(colorGroup:String, colorPoint:int):int
		{
			if (colorGroup in data.LinkedColorGroup)
			{
				return data.LinkedColorGroup[colorGroup][colorPoint];
			}
			return -1;
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
