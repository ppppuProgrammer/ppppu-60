package animations 
{
	import flash.display.Sprite;
	
	/**
	 * Holds a list of various sprites that can be used to display the background. Works similiar to the Actor class.
	 * @author 
	 */
	public class ExchangeableBackground extends Sprite 
	{
		public var currentlyUsedImage:Sprite;
		protected var spriteList:Vector.<Sprite> = new Vector.<Sprite>();
		public function ExchangeableBackground() 
		{
			super();
			
		}
		
		public function GetSpriteList():Vector.<Sprite>
		{
			return spriteList;
		}
		
		public function AddNewBackgroundAsset(asset:Sprite):Boolean
		{
			//var assetName:String = asset.name;
			for (var i:int = 0, l:int = spriteList.length; i < l; i++) 
			{
				if (spriteList[i].name == asset.name)
				{
					return false;
				}
			}

			spriteList[spriteList.length] = asset;
			return true;


		}
		
		public function SelectBackgroundAsset(assetId:int):void
		{
			if (assetId >= spriteList.length || assetId < -1) { return; }
			if (currentlyUsedImage)
			{
				this.removeChild(currentlyUsedImage);
			}
			if (assetId > -1)
			{
				currentlyUsedImage = addChild(spriteList[assetId]) as Sprite;
			}
		}
		
		
	}

}