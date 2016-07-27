package game.modules.net
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	import common.context.links.Link;
	import flash.utils.IDataInput;
	import game.configurations.ConnectionConfiguration;
	import game.net.NetListener;
	import game.net.ServerRequest;
	
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
			context.install(ServerRequest);
			context.install(ConnectionConfiguration);
			context.install(UINetLoggerManager);
			context.install(new Link(NetLoggerManager, INetLogger, "netLogger"));
			context.install(new Link(NetListener, INetHandler, "netListener"));
			context.install(new Link(NetErrorListener, INetErrorHandler, "errorListener"));
			context.install(new Link(ServerConnection, ISocketConnection, "connection"));
			context.install(new Link(NetJsonParser, INetParser));
			context.install(new Link(NetEventCommandHandler));
			context.install(new Link(NetConnectionSender, IConnectionSend, "send"));
		}
	
	}

}