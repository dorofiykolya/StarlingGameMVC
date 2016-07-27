package game.modules.alert 
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AlertExtension implements IExtension 
	{
		
		public function AlertExtension() 
		{
			
		}
		
		
		/* INTERFACE common.context.extensions.IExtension */
		
		public function extend(context:IContext):void 
		{
			context.install(AlertManager);
		}
		
	}

}