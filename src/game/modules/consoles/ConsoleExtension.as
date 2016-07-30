package game.modules.consoles 
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ConsoleExtension implements IExtension 
	{
		
		public function ConsoleExtension() 
		{
			
		}
		
		/* INTERFACE common.context.extensions.IExtension */
		
		public function extend(context:IContext):void 
		{
			context.install(ConsoleManager);
			context.install(ConsoleConfiguration);
		}
		
	}

}