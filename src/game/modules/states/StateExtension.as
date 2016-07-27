package game.modules.states 
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	import common.context.links.Link;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class StateExtension implements IExtension 
	{
		
		public function StateExtension() 
		{
			
		}
		
		/* INTERFACE common.context.extensions.IExtension */
		
		public function extend(context:IContext):void 
		{
			context.install(StateDispatcher);
			context.install(new Link(StateDispatcher, IStateListener, "stateListener"));
			context.install(new Link(StateDispatcher, IStateDispatcher, "stateDispatcher"));
		}
		
	}

}