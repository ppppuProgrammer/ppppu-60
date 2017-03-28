package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import modifications.AssetsMod;
	import modifications.ModArchive;
	
	/**
	 * ...
	 * @author 
	 */
	public class BaseAssetsArchive extends ModArchive 
	{
		
		public function BaseAssetsArchive() 
		{
			var eyeballColorProperties:Object = { Group: ["Iris", "Pupil"], Target: ["Iris", "Pupil"] };
			modsList[modsList.length] = new AssetsMod(new Eyeball, "EyeballL", { Colorable: eyeballColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Eyeball, "EyeballR", { Colorable: eyeballColorProperties } );
			
			var leggingsColorProperties:Object = { Group: "Leggings", Target: "Legging" };
			modsList[modsList.length] = new AssetsMod(new LowerLeg, "LowerLegL", { Colorable: leggingsColorProperties } );
			modsList[modsList.length] = new AssetsMod(new LowerLeg, "LowerLegR", { Colorable: leggingsColorProperties } );
			
			var lipColorProperties:Object  = { Group: "Lip", Target: "Lips" };
			modsList[modsList.length] = new AssetsMod(new ClosedSmile, "ClosedSmile", { Colorable: lipColorProperties } );
			modsList[modsList.length] = new AssetsMod(new OpenSmile, "OpenSmile", { Colorable: lipColorProperties } );
			
			var nippleColorProperties:Object  = { Group: "Nipple", Target: "Color" };
			modsList[modsList.length] = new AssetsMod(new Nipple, "NippleL", { Colorable: nippleColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Nipple, "NippleR", { Colorable: nippleColorProperties } );
			
			var areolaColorProperties:Object  = { Group: "Areola", Target: "Color" };
			modsList[modsList.length] = new AssetsMod(new Areola, "AreolaL", { Colorable: areolaColorProperties } );
			modsList[modsList.length] = new AssetsMod(new Areola, "AreolaR", { Colorable: areolaColorProperties } );
		}
		
	}
	
}