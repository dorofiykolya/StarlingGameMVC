package game.mvc.view.starling
{
	import game.mvc.view.ILayer;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class StarlingLayer extends Sprite implements ILayer
	{
		
		public function StarlingLayer()
		{
		
		}
		
		/* INTERFACE game.view.ILayer */
		
		public function add(value:Object):void
		{
			addChild(DisplayObject(value));
		}
		
		public function remove(value:Object):void
		{
			removeChild(DisplayObject(value));
		}
	
	}

}