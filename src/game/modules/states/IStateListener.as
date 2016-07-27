package game.modules.states
{
	import common.events.IEventListener;
	
	[Event(name = "enter", type = "game.modules.states.StateEvent")]
	[Event(name = "exit", type = "game.modules.states.StateEvent")]
	[Event(name = "change", type = "game.modules.states.ChageStateEvent")]
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface IStateListener extends IEventListener
	{
	
	}

}