package game.mvc.view.controllers
{
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class TouchControllerEvent extends TouchEvent
	{
		
		[Event(name = "click", type = "game.view.controllers.TouchControllerEvent")]
		[Event(name = "down", type = "game.view.controllers.TouchControllerEvent")]
		[Event(name = "up", type = "game.view.controllers.TouchControllerEvent")]
		[Event(name = "over", type = "game.view.controllers.TouchControllerEvent")]
		[Event(name = "out", type = "game.view.controllers.TouchControllerEvent")]
		[Event(name = "clickWithoutDrag", type = "game.view.controllers.TouchControllerEvent")]
		[Event(name = "swipe", type = "game.view.controllers.TouchControllerEvent")]
		[Event(name = "upWithoutDrag", type = "game.view.controllers.TouchControllerEvent")]
		
		static public const CLICK:String = "click";
		static public const DOWN:String = "down";
		static public const UP:String = "up";
		static public const OVER:String = "over";
		static public const OUT:String = "out";
		static public const CLICK_WITHOUT_DRAG:String = "clickWithoutDrag";
		static public const SWIPE:String = "swipe";
		static public const UP_WITHOUT_DRAG:String = "upWithoutDrag";
		
		private var _autoRepeat:Boolean;
		private var _target:EventDispatcher;
		
		public function TouchControllerEvent(type:String, touches:Vector.<Touch>, shiftKey:Boolean = false, ctrlKey:Boolean = false, bubbles:Boolean = true, autoRepeat:Boolean = false, target:EventDispatcher = null)
		{
			super(type, touches, shiftKey, ctrlKey, bubbles);
			_autoRepeat = autoRepeat;
		}
		
		override public function get target():EventDispatcher 
		{
			return _target;
		}
		
		public function get autoRepeat():Boolean
		{
			return _autoRepeat;
		}
		
		public function get swipeX():Number
		{
			return TouchController(currentTarget).gestureSwipeDirection.x;
		}
		
		public function get swipeY():Number
		{
			return TouchController(currentTarget).gestureSwipeDirection.y;
		}
	}
}