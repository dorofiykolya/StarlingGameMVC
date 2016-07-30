package game.mvc.events
{
	import common.events.Event;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ViewContextEvent extends Event
	{
		public static const INITIALIZED:String = "viewContextInitialized";
		
		public function ViewContextEvent(type:Object, bubbles:Boolean = false, data:Object = null)
		{
			super(type, bubbles, data);
		}
	}

}