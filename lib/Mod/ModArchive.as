package Mod 
{
	/**
	 * A ppppuMod subclass that is used as an archive that contains various ppppuMods that actually contain data to be added 
	 * to the ppppu program
	 * @author 
	 */
	public class ModArchive extends ppppuMod
	{
		protected var modsList:Vector.<ppppuMod> = new Vector.<ppppuMod>();
		public function ModArchive() 
		{
			
		}
		
		public function GetModsList():Vector.<ppppuMod> { return modsList; }
	
		/*FirstFrame should be defined by the subclass of the ModArchive. In the body for the function, the various mods that
		are to be added should be created and pushed (or added however you want) into the modsList vector and then 
		added to the mod archive's display list.*/
		//protected function FirstFrame(e:Event):void;
	}

}