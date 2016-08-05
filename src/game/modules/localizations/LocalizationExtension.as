package game.modules.localizations 
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	import common.context.links.Link;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocalizationExtension implements IExtension 
	{
		
		public function LocalizationExtension() 
		{
			
		}
		
		
		/* INTERFACE common.context.extensions.IExtension */
		
		public function extend(context:IContext):void 
		{
			context.install(LocalizationManager);
			context.install(new Link(LocalizationManager, ILocalizeBinder));
			context.install(new Link(LocalizationManager, ILocalizeProvider));
		}
		
	}

}