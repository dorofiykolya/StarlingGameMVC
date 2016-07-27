package game.modules.net.events
{
	import common.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class NetSocketDataEvent extends Event
	{
		public static const SOCKET_DATA:String = "socketData";
		
		public var bytesLoaded:int
		public var bytesTotal:int;
		
		public function NetSocketDataEvent(type:Object)
		{
			super(type);
		}
		
		override protected function initializeEvent(args:Array):Event
		{
			bytesLoaded = args[0];
			bytesTotal = args[1];
			return this;
		}
	
	}

}