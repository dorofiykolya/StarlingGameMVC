package game.modules.uibuilder 
{
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface IUIBuilderFactory 
	{
		function createByLayout(layout:Object):Sprite;
		function disposeLayout(layout:DisplayObject):void;
	}
	
}