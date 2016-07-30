package game.modules.net
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	import common.context.links.Link;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ConnectionExtension implements IExtension
	{
		
		public function ConnectionExtension()
		{
		
		}
		
		/* INTERFACE common.context.extensions.IExtension */
		
		public function extend(context:IContext):void
		{
			context.install(UINetLoggerManager);
			context.install(new Link(NetLoggerManager, INetLogger, "netLogger"));
			context.install(new Link(ServerConnection, ISocketConnection, "connection"));
			context.install(new Link(NetJsonParser, INetParser));
			context.install(new Link(NetEventCommandHandler));
			context.install(new Link(NetConnectionSender, IConnectionSend, "send"));
		}
	
	}

}