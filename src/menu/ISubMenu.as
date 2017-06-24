package menu 
{
	
	/**
	 * ...
	 * @author 
	 */
	public interface ISubMenu 
	{
		function InitializeMenu(app:AppCore):void;
		CONFIG::debug
		{
		//Used when the reload menu button is pressed, which will have the menu remove its menu components and reload their xml definition file
		function Reset():void;
		}
		
	}
	
}