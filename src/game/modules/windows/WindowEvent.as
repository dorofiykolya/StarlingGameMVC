package game.modules.windows 
{
	import common.events.Event;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class WindowEvent extends Event 
	{
		public static const OPENED:String = "windowEvent.opened";
		public static const CLOSED:String = "windowEvent.closed";
		public static const CLOSED_ALL:String = "windowEvent.closedAll";
		
		public function WindowEvent(type:Object, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
		}
		
		public function get windowId():WindowId
		{
			return WindowId(data);
		}
		
	}

}