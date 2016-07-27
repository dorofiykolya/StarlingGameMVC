package game.modules.net.events
{
	import common.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class NetSecurityErrorEvent extends NetEvent
	{
		public static const SECURITY_ERROR:String = "securityError";
		
		public var errorID:int;
		public var text:String;
		
		public function NetSecurityErrorEvent(type:Object)
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