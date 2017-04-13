package animations 
{
	import com.jacksondunstan.signals.Signal2;
	import com.jacksondunstan.signals.Signal3;
	import com.jacksondunstan.signals.Slot2;
	import com.jacksondunstan.signals.Slot3;
	import flash.display.Sprite;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Actors are Sprites that are added to the Canvas (aka TemplateBase). They are the actual sprites that take orders from DispObjInfo and tweens. Actors have 3 layers for placing graphics into. Think of these layers as costumes, they change the appearance of the actor. The layers are top, main, and bottom. Main is the primary layer that graphics are added to, top and bottom layers exist to add onto the main layer without actually modifying the graphics in the main layer, which could cause visual discrepancies later on.
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
		
		//A list of assets that can be applied to this particular actor and the data for utilizing them.
		private var assetList:Vector.<AssetData> = new Vector.<AssetData>;
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
		
		//Removes all graphics from the actor's layers and also removes the layers from the actor's display list.
		public function ClearAllGraphics():void
		{
			//this.removeChildren();
			//topLayer = mainLayer = bottomLayer = null; //null the references to the graphic set asset.
			topLayer.removeChildren();
			mainLayer.removeChildren();
			bottomLayer.removeChildren();
		}
		
		public function RegisterDirector(director:Director):void
		{
			signal2.addSlot(director);
			signal3.addSlot(director);
		}
		
		public function SelectAssetToUse(assetId:int):void
		{
			var assetData:AssetData = assetList[assetId];
			ChangeGraphicInLayer(assetData.layer, assetData.asset); 
			switch(assetData.layer)
			{
				case LAYER_TOP:
					topAssetInUse = assetData
					break;
				case LAYER_MAIN:
					mainAssetInUse = assetData;
					break;
				case LAYER_BOTTOM:
					bottomAssetInUse = assetData;
					break;
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
				layerSprite.addChild(sprite);
				if (layerSprite.parent == null)
				{
					this.addChildAt(layerSprite, Math.min(layer, this.numChildren));
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
				if (assetData.properties != null && "Colorable" in assetData.properties)
				{
					signal3.dispatch("RegisterColorables", assetData.asset, assetData.properties.Colorable);
				}
			}
		}
		
		//
		/*public function onSignal0(): void
		{
		}*/
		
		public function onSignal2(command:*, value:*): void
		{
			var commandStr:String = command as String;
			if (commandStr == "AnimationChanged")
			{
				var animationName:String = value as String;
				DisableActorsCheck(topAssetInUse, animationName);
				DisableActorsCheck(mainAssetInUse, animationName);
				DisableActorsCheck(bottomAssetInUse, animationName);
			}
			else if (commandStr == "DisableActorsCommand")
			{
				var disableList:Vector.<String> = value as Vector.<String>;
				if (disableList.indexOf(this.name) > -1)
				{
					this.ChangeVisibility(false);
				}
			}
			else if (commandStr == "ChangeAssetForAllActors")
			{
				var setName:String = value as String;
				for (var i:int = 0, l:int = assetList.length; i < l; i++) 
				{
					if (assetList[i].setName == setName)
					{
						ChangeGraphicInLayer(assetList[i].layer, assetList[i].asset);
						return;
					}
				}
			}
			else if (commandStr == "ActorAssetListRequest")
			{
				var actorName:String = value as String;
				if (actorName == this.name)
				{
					var assetPayload:Vector.<Object> = new Vector.<Object>();
					for (var j:int = 0, k:int = assetList.length; j < k; j++) 
					{
						assetPayload[assetPayload.length] = {AssetSet: assetList[j].setName, AssetClass: Object(assetList[j].asset).constructor, AssetLayer: assetList[j].layer };
					}
					
					signal2.dispatch("AssetListDelivery", assetPayload);
				}
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
			
		}
		//Parameters:
		//assetData - contains the data for the asset that is currently being used for the actor.
		//animationName - The name of the current animation being played
		private function DisableActorsCheck(assetData:AssetData, animationName:String):void
		{
			if (assetData == null) { return; }
			
			var disableActorData:Array = (assetData.properties != null && "DisableActor" in assetData.properties) ? assetData.properties.DisableActor : null;
			if (disableActorData)
			{
				//disableActorData is a 2n array (2 values are used every for iteration), which the values used being for actor name, animations for, and unused.
				var disableActorsList:Vector.<String> = new Vector.<String>;
				//The animation that an actor will be disabled for
				var animationFor:String;
				for (var i:int = 0, l:int = disableActorData.length / 2 ; i < l; ++i) 
				{
					animationFor = disableActorData[1] as String;
					if (animationFor == "_ALL" || animationName)
					{
						disableActorsList[disableActorsList.length] == disableActorData[0] as String;
					}
				}
				if (disableActorsList.length > 0)
				{
					signal2.dispatch("DisableActorsRequest", disableActorsList);
				}
			}
		}
		
	}

}