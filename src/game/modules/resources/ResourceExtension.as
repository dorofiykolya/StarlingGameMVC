package game.modules.resources
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ResourceExtension implements IExtension
	{
		
		public function ResourceExtension()
		{
		
		}
		
		/* INTERFACE common.context.extensions.IExtension */
		
		public function extend(context:IContext):void
		{
			context.install(ResourceManager);
			
			CONFIG::ANDROID
			{
				context.install(LocalDataLoaderManager);
			}
			
			CONFIG::IOS
			{
				context.install(LocalDataLoaderManager);
			}
		}
	
	}

}