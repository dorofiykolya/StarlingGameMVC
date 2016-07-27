package game.modules.net.events
{
	import common.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class NetIOErrorEvent extends NetEvent
	{
		public static const IO_ERROR:String = "ioError";
		
		public var errorID:int;
		public var text:String;
		
		public function NetIOErrorEvent(type:Object)
		{
			super(type);
		}
		
		override protected function initializeEvent(args:Array):Event
		{
			errorID = args[0];
			text = args[1];
			return this;
		}
	
	}

}