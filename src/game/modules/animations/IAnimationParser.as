package game.modules.animations
{
	import game.modules.animations.descriptions.LayersDescription;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface IAnimationParser
	{
		function parse(value:Object):LayersDescription;
	}

}