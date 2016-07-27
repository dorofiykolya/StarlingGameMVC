package game.modules.preloaders
{
	import common.events.Event;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class PreloaderDependencyEvent extends Event
	{
		public static const COMPLETE:String = "preloaderDependencyEvent.complete";
		
		public function PreloaderDependencyEvent(type:Object, bubbles:Boolean = false, data:Object = null)
		{
			super(type, bubbles, data);
		}
	
	}

}