package game.modules.net.events
{
	import common.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class NetEvent extends Event
	{
		public static const CLOSE:String = "close";
		public static const CONNECT:String = "connect";
		
		public function NetEvent(type:Object)
		{
			super(type);
		}
	
	}

}