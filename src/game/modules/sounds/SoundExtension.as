package game.modules.sounds
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class SoundExtension implements IExtension
	{
		
		public function SoundExtension()
		{
		
		}
		
		/* INTERFACE common.context.extensions.IExtension */
		
		public function extend(context:IContext):void
		{
			context.install(SoundConfiguration);
			context.install(SoundManager);
		}
	
	}

}