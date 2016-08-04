package game.modules.animations.descriptions
{
	import starling.display.DisplayObject;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface IDescriptionFactory
	{
		function instantiate():DisplayObject;
		function get type():DescriptionType;
	}

}