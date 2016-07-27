package game.modules.logs
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	import common.context.links.Link;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LoggerExtension implements IExtension
	{
		
		public function LoggerExtension()
		{
		
		}
		
		/* INTERFACE common.context.extensions.IExtension */
		
		public function extend(context:IContext):void
		{
			context.install(new Link(Logger, ILogger, "logger"));
			context.install(LoggerManager);
		}
	
	}

}