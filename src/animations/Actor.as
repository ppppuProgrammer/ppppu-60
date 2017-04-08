package animations 
{
	import flash.display.Sprite;
	
	/**
	 * Actors are Sprites that are added to the Canvas (aka TemplateBase). They are the actual sprites that take orders from DispObjInfo and tweens. Actors have 3 layers for placing graphics into. Think of these layers as costumes, they change the appearance of the actor. The layers are top, main, and bottom. Main is the primary layer that graphics are added to, top and bottom layers exist to add onto the main layer without actually modifying the graphics in the main layer, which could cause visual discrepancies later on.
	 * @author 
	 */
	public class Actor extends Sprite 
	{
		private var topLayer:Sprite;
		private var mainLayer:Sprite;
		private var bottomLayer:Sprite;
		
		public static const LAYER_MAIN:int = 1;
		public static const LAYER_BOTTOM:int = 0;		
		public static const LAYER_TOP:int = 2;
		
		public function Actor() 
		{
			super();
			//topLayer = new Sprite();
			//topLayer.name = "Top";
			//mainLayer = new Sprite();
			//mainLayer.name = "Main";
			//bottomLayer = new Sprite();
			//bottomLayer.name = "Bottom";
			//addChild(bottomLayer);
			//addChild(mainLayer);
			//addChild(topLayer);
		}
		
		//Removes all graphics from the actor's layers and also removes the layers from the actor's display list.
		public function ClearAllGraphics():void
		{
			this.removeChildren();
			topLayer = mainLayer = bottomLayer = null; //null the references to the graphic set asset.
			//topLayer.removeChildren();
			//mainLayer.removeChildren();
			//bottomLayer.removeChildren();
		}
		
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
			//Something is already in the layer we want to assign the given sprite to.
			if (layerSprite)
			{
				this.removeChild(layerSprite);
				layerSprite = null;
			}
			layerSprite = sprite;
			if (this.contains(layerSprite) == false)
			{
				this.addChildAt(layerSprite, Math.min(layer, this.numChildren));
			}
			
			/*var layerSprite:Sprite;
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
			}	*/		
		}
		
		//Changes the visibility of the children display objects in the actor. Done this way as a tween may control the visibility of the actor itself, there by undoing any direct visibility changes done to the actor.
		public function ChangeVisibility(visible:Boolean):void
		{
			for (var i:int = 0,l:int = this.numChildren; i < l; i++) 
			{
				this.getChildAt(i).visible = visible;
			}
			//topLayer.visible = mainLayer.visible = bottomLayer.visible = visible;
		}
		
	}

}