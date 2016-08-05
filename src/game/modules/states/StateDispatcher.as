package game.modules.states
{
	import common.events.EventDispatcher;
	import common.system.Assert;
	
	[Event(name = "enter", type = "game.modules.states.StateEvent")]
	[Event(name = "exit", type = "game.modules.states.StateEvent")]
	[Event(name = "change", type = "game.modules.states.ChangeStateEvent")]
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class StateDispatcher implements IStateDispatcher
	{
		private var _eventDispatcher:EventDispatcher;
		private var _previous:State;
		private var _current:State;
		
		public function StateDispatcher()
		{
			_eventDispatcher = new EventDispatcher();
		}
		
		public function any(... states):Boolean
		{
			for each (var item:Object in states)
			{
				if (item == _current)
				{
					return true;
				}
			}
			return false;
		}
		
		public function get previous():State
		{
			return _previous;
		}
		
		public function get current():State
		{
			return _current;
		}
		
		public function set current(state:State):void
		{
			if (_current != state)
			{
				Assert.notNull(state);
				
				var next:State = state
				_eventDispatcher.dispatchEventAs(StateEvent, StateEvent.EXIT, false, null, [_previous, _current, next]);
				_previous = _current;
				_eventDispatcher.dispatchEventAs(StateEvent, StateEvent.ENTER, false, null, [_previous, _current, next]);
				_current = next;
				_eventDispatcher.dispatchEventAs(ChangeStateEvent, ChangeStateEvent.CHANGE, false, _current, [null, _previous, _current]);
			}
		}
		
		public function addEventListener(type:Object, listener:Function):void
		{
			_eventDispatcher.addEventListener(type, listener);
		}
		
		public function removeEventListener(type:Object, listener:Function):void
		{
			_eventDispatcher.removeEventListener(type, listener);
		}
		
		public function removeEventListeners(type:Object = null):void
		{
			_eventDispatcher.removeEventListeners(type);
		}
		
		public function hasEventListener(type:Object, listener:Function = null):Boolean
		{
			return _eventDispatcher.hasEventListener(type, listener);
		}
	}
}