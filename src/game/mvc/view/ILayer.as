package game.mvc.view
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface ILayer
	{
		function add(value:Object):void;
		function remove(value:Object):void;
		function get visible():Boolean;
		function set visible(value:Boolean):void;
	}

}