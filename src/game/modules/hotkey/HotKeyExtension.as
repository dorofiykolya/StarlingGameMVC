package game.modules.hotkey 
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class HotKeyExtension implements IExtension
	{
		
		public function HotKeyExtension() 
		{
			
		}
		
		/* INTERFACE common.context.extensions.IExtension */
		
		public function extend(context:IContext):void 
		{
			context.install(HotKeyConfiguration);
			context.install(HotKeyManager);
		}
		
	}

}