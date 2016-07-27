package game.modules.assets 
{
	import common.events.Event;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AssetEvent extends Event 
	{
		public static const LOADED:String = "loaded";
		
		public function AssetEvent(type:Object, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
		}
		
	}

}