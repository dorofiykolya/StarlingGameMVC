package game.modules.windows
{
	import starling.animation.Juggler;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface IWindowView
	{
		function set juggler(value:Juggler):void;
		function get juggler():Juggler;
		
		function get content():DisplayObject;
		function set content(value:DisplayObject):void;
		
		function get background():DisplayObject;
		function set background(value:DisplayObject):void;
	}

}