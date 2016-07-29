package game.mvc.events
{
	import common.events.Event;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class GameContextEvent extends Event
	{
		public static const STAGE_READY:String = "stageReady";
		public static const PRE_INITIALIZE:String = "preInitialize";
		public static const POST_INITIALIZE:String = "postInitialize";
		
		public function GameContextEvent(type:Object, data:Object = null)
		{
			super(type, bubbles, data);
		}
	
	}

}