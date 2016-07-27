package game.mvc.view
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface ILayers
	{
		function getLayer(index:int):ILayer;
		function get touchable():Boolean;
		function set touchable(value:Boolean):void;
	}

}