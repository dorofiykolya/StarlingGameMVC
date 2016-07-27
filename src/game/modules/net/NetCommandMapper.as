package game.modules.net 
{
	import common.context.IContext;
	import common.events.IEventDispatcher;
	import mvc.commands.CommandMapper;
	import mvc.commands.IEventCommandMap;
	/**
	 * ...
	 * @author ...
	 */
	public class NetCommandMapper extends CommandMapper
	{
		
		public function NetCommandMapper(eventCommandMap:IEventCommandMap, context:IContext, key:Object, eventType:Class, eventDispatcher:IEventDispatcher) 
		{
			super(eventCommandMap, context, key, eventType, eventDispatcher);
		}
		
	}

}