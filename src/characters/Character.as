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
		public var data:Object;
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
		
		public function Character(name:String, charData:Object, isPresetCharacter:Boolean = false)
		{
			registerClassAlias("AnimationList", AnimationList);
			m_name = name;
			data = charData;
			animationLists = new Vector.<AnimationList>();
			animationLists[animationLists.length] = new AnimationList();
			animationLists[animationLists.length] = new AnimationList();
			if (isPresetCharacter)
			{
				var charByteArray:ByteArray = new ByteArray();
				charByteArray.writeObject(this);
				defaultSettings = ExportCharacterDataForStorage();
				var character:Character = new Character("temp", null);
				character.ImportCharacterDataFromStorage(defaultSettings);
				var bp:int = 5;
			}
			
			
		}
		
		public function SetID(idNumber:int):void
		{
			if (m_Id == -1)
			{
				m_Id = idNumber;
				//idSet = true;
			}
		}
		
		public function AddAnimationSlot():void
		{
			animationLists[animationLists.length] = new AnimationList();
		}
		
		public function RemoveAnimationSlot(index:int):Boolean
		{
			if (index >= 0 && index < animationLists.length)
			{
				animationLists = animationLists.splice(index, 1);
				return true;
			}
			return false;
		}
		
		public function SaveAnimationToSlot(index:int, animateList:AnimationList):void
		{
			if (index >= 0 && index < animationLists.length)
			{
				animationLists[index] = animateList;
			}
		}
		public function CheckIfPresetDataExists():Boolean { return defaultSettings != null;}
		public function GetID():int { return m_Id;}
		public function GetName():String { return m_name; }
		public function GetDefaultMusicName():String { return m_defaultMusicName; }
		public function GetAnimationList(animId:int):AnimationList
		{
			if (animId >= 0 && animId < animationLists.length)
			{
				return animationLists[animId];
			}
			return null;
		}
		
		public function ExportCharacterDataForStorage():ByteArray
		{
			var characterByteArray:ByteArray = new ByteArray();
			characterByteArray.writeObject(data);
			characterByteArray.writeObject(m_defaultMusicName);
			characterByteArray.writeBoolean(m_randomizePlayAnim);
			characterByteArray.writeObject(m_lockedAnimation);
			characterByteArray.writeObject(animationLists);
			return characterByteArray;
		}
		
		public function ImportCharacterDataFromStorage(charStorageData:ByteArray)
		{
			charStorageData.position = 0;
			data = charStorageData.readObject();
			m_defaultMusicName = charStorageData.readObject();
			m_randomizePlayAnim = charStorageData.readBoolean();
			m_lockedAnimation = charStorageData.readObject();
			animationLists = charStorageData.readObject();
			
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
