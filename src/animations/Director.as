package animations 
{
	import com.jacksondunstan.signals.Signal2;
	import com.jacksondunstan.signals.Signal3;
	import com.jacksondunstan.signals.Slot2;
	import com.jacksondunstan.signals.Slot3;
	import flash.display.Sprite;
	/**
	 * A manager class that gives Actors commands and also acts on requests from Actors.
	 * @author 
	 */
	public class Director implements Slot2, Slot3
	{
		//Ref to the colorizer so Actors can request to have accepted assets be colorized. 
		private var colorizer:Colorizer;
		private var appSignaller2:Signal2 = new Signal2;
		private var actorSignaller2:Signal2 = new Signal2;
		private var signal3:Signal3 = new Signal3;
		private var currentAnimationName:String;
		public function Director(appCore:Slot2, assetColorizer:Colorizer) 
		{
			appSignaller2.addSlot(appCore);
			colorizer = assetColorizer;
		}
		
		public function AnimationWasChanged(newAnimationName:String):void
		{
			currentAnimationName = newAnimationName;
			actorSignaller2.dispatch("AnimationChanged", currentAnimationName);
		}
		
		
		public function onSignal2(command:*, value:*): void
		{
			var commandStr:String = command as String;
			if (commandStr == "DisableActorsRequest")
			{
				//Got the request, now send the vector list to all listening actors as a command.
				actorSignaller2.dispatch("DisableActorsCommand", value);
			}
			else if (commandStr == "DisableActorsForAssetChangeRequest")
			{
				//Actor requested to disable other actors but didn't know what the current animation was. 
				var disableActorData:Array = value as Array;
				var actorsToDisableList:Vector.<String> = new Vector.<String>();
				
				for (var i:int = 0, l:int = disableActorData.length ; i < l; i+=2) 
				{
					if ((disableActorData[i + 1] as String) == "_ALL" || currentAnimationName)
					{
						actorsToDisableList[actorsToDisableList.length] = disableActorData[i];
					}
				}
				//Got the request, now send the vector list to all listening actors as a command.
				actorSignaller2.dispatch("DisableActorsCommand", actorsToDisableList);
			}
			else if (command == "EnableActorRequest")
			{
				//An actor requested to enable other actors due to an asset change but didn't know what the current animation was. 
				//Every 2 items in the array is a pair, the first being the actor name and the second being the animation name.
				var enableActorData:Array = value as Array;
				var actorsToEnableList:Vector.<String> = new Vector.<String>();
				
				for (var i:int = 0, l:int = enableActorData.length ; i < l; i+=2) 
				{
					if ((enableActorData[i + 1] as String) == "_ALL" || currentAnimationName)
					{
						actorsToEnableList[actorsToEnableList.length] = enableActorData[i];
					}
				}
				//Got the request, now send the vector list to all listening actors as a command.
				actorSignaller2.dispatch("EnableActorsCommand", actorsToEnableList);
			}
			else if (commandStr == "ActorAssetListRequest")
			{
				actorSignaller2.dispatch(command, value);
			}
			else if (commandStr == "AssetListDelivery")
			{
				//Send the asset list received from an actor to any objects listening for them.
				appSignaller2.dispatch(command, value);
			}
			else if (commandStr == "ApplyAssetToActor")
			{
				ChangeAssetForActor(value[0] as String, value[1] as int);
				//signal3.dispatch();
			}
			else if (commandStr == "ApplySetToAllActors")
			{
				ChangeAssetForAllActorsBySetName(value[0] as String, value[1] as Boolean);
			}
			else if (commandStr == "AddedAssetToActorResult")
			{
				appSignaller2.dispatch(command, value);
			}
			else if (commandStr == "Actor_ReportingAssetChanged")
			{
				appSignaller2.dispatch(command, value);
			}
		}
		
		//Used when a signal is received from an Actor to change visibility of other actors or for registering assets with colorable data.
		public function onSignal3(command:*, value:*, value2:*): void
		{
			var commandStr:String = command as String;
			if (commandStr == "RegisterColorables")
			{
				var sprite:Sprite = value as Sprite;
				var colorableData:Object = value2 as Object;
				colorizer.AddColorizeData(sprite, colorableData);
			}
		}
		
		//Registers an Actor to send and receive messages to/from the Director. 
		public function RegisterActor(actor:Actor):void
		{
			actorSignaller2.addSlot(actor);
			signal3.addSlot(actor);
			actor.RegisterDirector(this);
			//Send a message for any menus listening that a new actor was available for use. 
			appSignaller2.dispatch("NewActorRegistered", actor.name);
		}
		
		//Intended to register a menu to receive messages from the signal2 object this class contains
		public function RegisterMenuForMessaging(menu:Slot2):void
		{
			appSignaller2.addSlot(menu);
		}
		
		public function UpdateAnimationInUse(animationName:String):void
		{
			currentAnimationName = animationName;
		}
		
		[inline]
		public function ChangeAssetForAllActorsBySetName(setName:String, applyMode:Boolean):void
		{
			signal3.dispatch("ChangeAssetForAllActors", setName, applyMode);
		}

		[inline]
		public function ChangeAssetForActorByCharData(data:Object):void
		{
			actorSignaller2.dispatch("ChangeAssetByData", data);
		}
		/*public function ChangeAssetForActorByName(actorName:String, layer:int, setName:String):void
		{
			signal3.dispatch("ChangeAssetByName", actorName, [setName, layer]);
		}*/	
		
		[inline]
		public function ChangeAssetForActor(actorName:String, assetId:int):void
		{
			signal3.dispatch("ChangeAsset", actorName, assetId);
		}		
		
		[inline]
		public function ChangeAssetForActorBySetName(actorName:String, assetSet:String, layer:int):void
		{
			signal3.dispatch("ChangeAssetBySetName", actorName, [assetSet, layer]);
		}	
		
		public function ClearAllActors():void
		{
			actorSignaller2.dispatch("ClearAllAssets", null);
		}
		
		/*public function ChangeColorsForAssets(colorizeData:Object):void
		{
			colorizer.ChangeColorsUsingCharacterData(colorizeData);
		}*/
	}

}