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
		//protected var m_playAnimationFrame:int = 0;
		protected var m_randomizePlayAnim:Boolean = true;
		protected var m_lockedAnimation:Vector.<Boolean>; //Keeps track if an animation can be switched to.
		
		protected var m_defaultMusicName:String = "";
		
		//The music to play for this specific character
		protected var selectedMusicId:int = -1;
		//private var m_numOfLockedAnimations:int = 0;
		//Indicates if the various properties for the character can be changed. Characters created from a Character Mod can never have their data changed once created.
		protected var defaultSettings:ByteArray = null;
		
		protected var animationLists:Vector.<AnimationList>;
		
		public function Character(name:String, charData:Object, isPresetCharacter:Boolean = false, presetAnimationLists:Vector.<AnimationList>=null)
		{
			registerClassAlias("AnimationList", AnimationList);
			m_lockedAnimation = new Vector.<Boolean>();
			m_name = name;
			if (charData)
			{
				data = charData;
			}
			animationLists = presetAnimationLists;
			if (isPresetCharacter)
			{
				defaultSettings = ExportCharacterDataForStorage();
			}
			
			
		}
		
		public function SetAnimationLists(animationPresets:Vector.<AnimationList>):void
		{
			animationLists = animationPresets;
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
		}
		
		public function RemoveAnimationSlot(index:int):Boolean
		{
			if (animationLists && index >= 0 && index < animationLists.length)
			{
				/*animationLists = */animationLists.splice(index, 1);
				/*m_lockedAnimation = */m_lockedAnimation.splice(index, 1);
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
			}
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
