package game.modules.resources
{
	import common.events.Event;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ResourceEvent extends Event
	{
		public static const PROGRESS:String = "progress";
		public static const COMPLETE:String = "complete";
		public static const LOADED:String = "loaded";
		
		public function ResourceEvent(type:Object, data:Object = null)
		{
			super(type, false, data);
		}
	
	}

}