package game.modules.applications 
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	import common.context.links.Link;
	import common.system.Environment;
	import game.GameDescription;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ApplicationExtension implements IExtension 
	{
		
		public function ApplicationExtension() 
		{
			
		}
		
		
		/* INTERFACE common.context.extensions.IExtension */
		
		public function extend(context:IContext):void 
		{
			context.install(ApplicationManager);
			context.install(IdleManager);
			context.install(new Link(GameDescription, IApplicationDescription));
		}
		
	}

}