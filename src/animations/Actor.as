package animations 
{
	import com.jacksondunstan.signals.Signal2;
	import com.jacksondunstan.signals.Signal3;
	import com.jacksondunstan.signals.Slot2;
	import com.jacksondunstan.signals.Slot3;
	import flash.display.Sprite;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Actors are Sprites that are added to the Canvas. They are the actual sprites that are affected by DispObjInfo (for ordering) and tweens (for animation). Actors have 3 layers for placing graphics into. Think of these layers as costumes, they change the appearance of the actor. The layers are top, main, and bottom. Main is the primary layer that graphics are added to, top and bottom layers exist to add onto the main layer without actually modifying the graphics in the main layer, which could cause visual discrepancies later on. Once a graphic is set to it, the main layer must always have a graphic.
	 * @author 
	 */
	public class Actor extends Sprite implements Slot2, Slot3
	{
		private var topLayer:Sprite;
		private var mainLayer:Sprite;
		private var bottomLayer:Sprite;
		
		private var topAssetInUse:AssetData;
		private var mainAssetInUse:AssetData;
		private var bottomAssetInUse:AssetData;
		
		public static const LAYER_MAIN:int = 1;
		public static const LAYER_BOTTOM:int = 0;		
		public static const LAYER_TOP:int = 2;
		
		//The number of assets that have requested this actor to be disabled (invisible).
		private var disableRequestCount:int = 0;
		
		//A list of assets that can be applied to this particular actor and the data for utilizing them.
		private var assetList:Vector.<AssetData> = new Vector.<AssetData>;
		//Signals used to communicate with the director.
		private var signal2:Signal2 = new Signal2;
		private var signal3:Signal3 = new Signal3;
		public function Actor() 
		{
			super();
			topLayer = new Sprite();
			topLayer.name = "TopLayer";
			mainLayer = new Sprite();
			mainLayer.name = "MainLayer";
			bottomLayer = new Sprite();
			bottomLayer.name = "BottomLayer";
			addChild(bottomLayer);
			addChild(mainLayer);
			addChild(topLayer);
		}
		
		public function RegisterDirector(director:Director):void
		{
			signal2.addSlot(director);
			signal3.addSlot(director);
		}
		
		public function SelectAssetToUse(assetId:int):void
		{
			var assetData:AssetData = assetList[assetId];
			var assetCurrentlyUsed:AssetData = GetCurrentlyUsedAssetForLayer(assetData.layer);
			
			if (assetCurrentlyUsed == assetData) //Both are the same and i's already in use, so see if the asset should be removed from its layer.
			{
				//Main layer is not allowed to be empty once an asset is set to it.
				
				//Check that the layer is not main. If this is true, unset the asset
				if (assetData.layer != LAYER_MAIN)
				{
					RemoveAssetFromUse(assetData);
					//signal2.dispatch("Actor_ReportingAssetChanged", [this.name, "", assetData.layer]);
				}
			}
			else //An unused asset was selected to be used
			{
				//Remove the currently used asset
				RemoveAssetFromUse(assetCurrentlyUsed);
				SetAssetForUse(assetData);
				//signal2.dispatch("Actor_ReportingAssetChanged", [this.name, assetData.setName, assetData.layer]);
			}
			
		}
		
		public function RemoveAssetFromUse(assetData:AssetData):void
		{
			if (assetData == null) { return; }
			
			switch(assetData.layer)
			{
				case LAYER_TOP:
					if (topAssetInUse == null) { return;}
					topAssetInUse = null;
					break;
				case LAYER_MAIN:
					if (mainAssetInUse == null) { return;}
					mainAssetInUse = null;
					break;
				case LAYER_BOTTOM:
					if (bottomAssetInUse == null) { return;}
					bottomAssetInUse = null;
					break;
			}
			//Send a message to reduce the disable actor requests if this asset was capable of making such a request.
			var enableActorData:Array = GetDisableActorDataFromAsset(assetData);
			if (enableActorData)
			{
				//Send a request to enable an actor. This is the inverse of the "DisableActorsForAssetChangeRequest" request, particulary in the regard that both requests do not know what the current animation is and need the director to get that information.
				signal2.dispatch("EnableActorRequest", enableActorData);
			}
			//Removes the graphic from the layer
			ChangeGraphicInLayer(assetData.layer, null);
			signal2.dispatch("Actor_ReportingAssetChanged", [this.name, "", assetData.layer]);
		}
		
		public function SetAssetForUse(assetData:AssetData):void
		{
			if (assetData == null) { return; }
			
			switch(assetData.layer)
			{
				case LAYER_TOP:
					topAssetInUse = assetData;
					break;
				case LAYER_MAIN:
					mainAssetInUse = assetData;
					break;
				case LAYER_BOTTOM:
					bottomAssetInUse = assetData;
					break;
			}
			
			//Send a message to reduce the disable actor requests if this asset was capable of making such a request.
			var disableActorData:Array = GetDisableActorDataFromAsset(assetData);
			if (disableActorData)
			{
				//Send a request to disable an actor. This is the inverse of the "EnableActorRequest" request, particulary in the regard that both requests do not know what the current animation is and need the director to get that information.
				signal2.dispatch("DisableActorsForAssetChangeRequest", disableActorData);
			}
			//Add the graphic to the layer
			ChangeGraphicInLayer(assetData.layer, assetData.asset);
			signal2.dispatch("Actor_ReportingAssetChanged", [this.name, assetData.setName, assetData.layer]);
		}
		
		[inline]
		private function GetDisableActorDataFromAsset(assetData:AssetData):Array
		{
			if (assetData.properties != null && "DisableActor" in assetData.properties)
			{return assetData.properties.DisableActor as Array; }
			else
			{return null;}
		}
		
		[inline]
		private function GetCurrentlyUsedAssetForLayer(layer:int):AssetData
		{
			switch(layer)
			{
				case LAYER_TOP:
					return topAssetInUse;
					break;
				case LAYER_MAIN:
					return mainAssetInUse;
					break;
				case LAYER_BOTTOM:
					return bottomAssetInUse;
				default:
					return null;
			}
		}
		
		[inline]
		public function ChangeGraphicInLayer(layer:int, sprite:Sprite):void
		{			
			var layerSprite:Sprite;
			switch(layer)
			{
				case LAYER_TOP:
					layerSprite = topLayer;
					break;
				case LAYER_MAIN:
					layerSprite = mainLayer;
					break;
				case LAYER_BOTTOM:
					layerSprite = bottomLayer;
					break;
			}
			if (layerSprite)
			{
				layerSprite.removeChildren();
				if (sprite)
				{
					layerSprite.addChild(sprite);
					if (layerSprite.parent == null)
					{
						this.addChildAt(layerSprite, Math.min(layer, this.numChildren));
					}
				}
			}
		}
		
		//Changes the visibility of the children display objects in the actor. Done this way as a tween may control the visibility of the actor itself, there by undoing any direct visibility changes done to the actor.
		[inline]
		public function ChangeVisibility(visible:Boolean):void
		{
			topLayer.visible = mainLayer.visible = bottomLayer.visible = visible;
		}
		
		public function AddAsset(assetData:AssetData):void
		{
			if (assetData == null) { return;}
			var conflict:Boolean = false;
			//There can not be multiple assets in the same set for the same actor.
			for (var i:int = 0, l:int = assetList.length; i < l; i++) 
			{
				if (assetList[i].setName == assetData.setName)
				{
					conflict = true; break;
				}
			}
			if (conflict == false)
			{
				assetList[assetList.length] = assetData;
				signal2.dispatch("SetNameOfAddedAsset", assetData.setName);
				if (assetData.properties != null && "Colorable" in assetData.properties)
				{
					signal3.dispatch("RegisterColorables", assetData.asset, assetData.properties.Colorable);
				}
			}
		}
		
		public function onSignal2(command:*, value:*): void
		{
			var commandStr:String = command as String;
			if (commandStr == "AnimationChanged")
			{
				var animationName:String = value as String;
				//Since the new animation may not require an actor to be disabled, reset the count.
				disableRequestCount = 0;
				DisableActorsCheck_OnAnimationSwitch(topAssetInUse, animationName);
				DisableActorsCheck_OnAnimationSwitch(mainAssetInUse, animationName);
				DisableActorsCheck_OnAnimationSwitch(bottomAssetInUse, animationName);
			}
			else if (commandStr == "DisableActorsCommand")
			{
				var disableList:Vector.<String> = value as Vector.<String>;
				
				if (disableList.indexOf(this.name) > -1)
				{
					++disableRequestCount;					
				}	
				DisableRequestCountCheck();
			}
			else if (commandStr == "EnableActorsCommand")
			{
				var enableList:Vector.<String> = value as Vector.<String>;
				
				if (enableList.indexOf(this.name) > -1)
				{
					--disableRequestCount;	

				}	
				DisableRequestCountCheck();
			}
			
			else if (commandStr == "ActorAssetListRequest")
			{
				var actorName:String = value as String;
				if (actorName == this.name)
				{
					var assetPayload:Vector.<Object> = new Vector.<Object>();
					var showAssetInList:Boolean = true;
					for (var j:int = 0, k:int = assetList.length; j < k; j++) 
					{
						if (assetList[j].properties && ("ShowInMenus" in assetList[j].properties))
						{
							//showAssetInList = assetList[j].properties.ShowInMenus as Boolean;
						}
						if (showAssetInList)
						{
							assetPayload[assetPayload.length] = { AssetSet: assetList[j].setName, AssetClass: Object(assetList[j].asset).constructor, AssetLayer: assetList[j].layer };
						}
						//reset the value so the next asset isn't affected if there the ShowInMenus property isn't found in the assetdata.
						showAssetInList = true;
					}
					
					signal2.dispatch("AssetListDelivery", assetPayload);
				}
			}
			else if (commandStr == "ClearAllAssets")
			{
				RemoveAssetFromUse(GetCurrentlyUsedAssetForLayer(0));
				RemoveAssetFromUse(GetCurrentlyUsedAssetForLayer(1));
				RemoveAssetFromUse(GetCurrentlyUsedAssetForLayer(2));
			}
			
		}
		
		public function onSignal3(command:*, value:*, value2:*): void
		{
			var commandStr:String = command as String;
			if (commandStr == "ChangeAsset")
			{
				var targetedActor:String = value as String;
				if (this.name == targetedActor)
				{
					SelectAssetToUse(value2 as int);
				}
			}
			else if (commandStr == "ChangeAssetByName")
			{
				var targetedActor:String = value as String;
				if (this.name == targetedActor)
				{
					var setName:String = value2[0];					
					var layer:int = value2[1];
					if (setName == "")
					{
						
						RemoveAssetFromUse(GetCurrentlyUsedAssetForLayer(layer));
					}
					for (var j:int = 0, k:int = assetList.length; j < k; j++) 
					{
						if (assetList[j].layer == layer && assetList[j].setName == setName)
						{
							SetAssetForUse(assetList[j]);
							//SelectAssetToUse(j);
							break;
						}
					}
					
				}
			}
			else if (commandStr == "ChangeAssetForAllActors")
			{
				var setName:String = value as String;
				var applySet:Boolean = value2 as Boolean;
				var asset:AssetData;
				for (var i:int = 0, l:int = assetList.length; i < l; i++) 
				{
					asset = assetList[i];
					if (asset.setName == setName)
					{
						//Actor is to use the set
						if (applySet)
						{
							RemoveAssetFromUse(GetCurrentlyUsedAssetForLayer(asset.layer));
							SetAssetForUse(asset);
							//signal2.dispatch("Actor_ReportingAssetChanged", [this.name, asset.setName, asset.layer]);
						}
						else
						{
							//Actor is to remove the set. 
							//Main layer assets can not be removed unless there is another asset ready to take its place.
							if (asset.layer != LAYER_MAIN)
							{
								RemoveAssetFromUse(asset);
								//signal2.dispatch("Actor_ReportingAssetChanged", [this.name, "", asset.layer]);
							}
							
						}
					}
				}
			}
			
		}
		//Called when an asset for an actor was changed and sends a requests for other actors to be disabled. Since actors do not know what the current animation is, the director will need to do some additional checks to see if the actors should be disabled.
		/*private function DisableActorsCheck_OnAssetSwitch(assetData:AssetData)
		{
			if (assetData == null) { return; }
			
			var disableActorData:Array = GetDisableActorDataFromAsset(assetData);
			if (disableActorData)
			{
				signal2.dispatch("DisableActorsForAssetChangeRequest", disableActorData);
			}
		}*/
		
		//Called when the animation was changed and sends a requests for other actors to be disabled
		//Parameters:
		//assetData - contains the data for the asset that is currently being used for the actor.
		//animationName - The name of the current animation being played
		private function DisableActorsCheck_OnAnimationSwitch(assetData:AssetData, animationName:String):void
		{
			if (assetData == null) { return; }
			
			var disableActorData:Array = GetDisableActorDataFromAsset(assetData);
			if (disableActorData)
			{
				//disableActorData is a 2n array (2 values are used every for iteration), which the values used being for actor name and animations in that order
				var disableActorsList:Vector.<String> = new Vector.<String>;
				//The animation that an actor will be disabled for
				var animationFor:String;
				for (var i:int = 0, l:int = disableActorData.length ; i < l; i+=2) 
				{
					animationFor = disableActorData[i+1] as String;
					if (animationFor == "_ALL" || animationName)
					{
						disableActorsList[disableActorsList.length] = disableActorData[i] as String;
					}
				}
				if (disableActorsList.length > 0)
				{
					signal2.dispatch("DisableActorsRequest", disableActorsList);
				}
			}
		}
		
		[inline]
		private function DisableRequestCountCheck():void
		{
			if (disableRequestCount > 0)
			{this.ChangeVisibility(false);}
			else
			{this.ChangeVisibility(true);}
		}
		
	}

}