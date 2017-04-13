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
		private var signal2:Signal2 = new Signal2;
		private var signal3:Signal3 = new Signal3;
		private var currentAnimationName:String;
		public function Director(assetColorizer:Colorizer) 
		{
			colorizer = assetColorizer;
		}
		
		public function AnimationWasChanged(newAnimationName:String):void
		{
			currentAnimationName = newAnimationName;
			signal2.dispatch("AnimationChanged", currentAnimationName);
		}
		
		//Used for nothing.
		public function onSignal2(command:*, value:*): void
		{
			var commandStr:String = command as String;
			if (commandStr == "DisableActorsRequest")
			{
				//Got the request, now send the vector list to all listening actors as a command.
				signal2.dispatch("DisableActorsCommand", value);
			}
			else if (commandStr == "ActorAssetListRequest")
			{
				signal2.dispatch(command, value);
			}
			else if (commandStr == "AssetListDelivery")
			{
				//Send the asset list received from an actor to any objects listening for them.
				signal2.dispatch(command, value);
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
			signal2.addSlot(actor);
			signal3.addSlot(actor);
			actor.RegisterDirector(this);
			//Send a message for any menus listening that a new actor was available for use. 
			signal2.dispatch("NewActorRegistered", actor.name);
		}
		
		//Intended to register a menu to receive messages from the signal2 object this class contains
		public function RegisterMenuForMessaging(menu:Slot2):void
		{
			signal2.addSlot(menu);
		}
		
		public function UpdateAnimationInUse(animationName:String):void
		{
			currentAnimationName = animationName;
		}
		
		public function ChangeAssetForAllActorsBySetName(setName:String):void
		{
			signal2.dispatch("ChangeAssetForAllActors", setName);
		}
		
		public function ChangeAssetForActor(actorName:String, assetId:int):void
		{
			signal3.dispatch("ChangeAsset", actorName, assetId);
		}		
	}

}