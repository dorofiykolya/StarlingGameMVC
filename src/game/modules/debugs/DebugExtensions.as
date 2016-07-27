package game.modules.debugs 
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	import common.system.Environment;
	import game.modules.resources.LocalDataLoaderManager;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class DebugExtensions implements IExtension
	{
		
		public function DebugExtensions() 
		{
			
		}
		
		public function extend(context:IContext):void 
		{
			context.install(DebugManager);
			
			if (Environment.isDebugger && (Environment.isStandAlone))
			{
				context.install(LocalDataLoaderManager);
			}
		}
		
	}

}