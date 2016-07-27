package game.modules.versions 
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class VersionExtension implements IExtension 
	{
		
		public function VersionExtension() 
		{
			
		}
		
		
		/* INTERFACE common.context.extensions.IExtension */
		
		public function extend(context:IContext):void 
		{
			context.install(VersionManager);
		}
		
	}

}