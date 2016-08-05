package game.modules.states
{
	import common.events.IEventDispatcher;
	
	[Event(name = "enter", type = "game.modules.states.StateEvent")]
	[Event(name = "exit", type = "game.modules.states.StateEvent")]
	[Event(name = "change", type = "game.modules.states.ChageStateEvent")]
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface IStateDispatcher extends IStateListener
	{
		function get previous():State;
		function get current():State;
		function set current(value:State):void;
	}

}