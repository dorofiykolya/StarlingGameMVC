package game.modules.localizations 
{
	import common.events.Event;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocalizationEvent extends Event 
	{
		public static const CHANGE:String = "localizationEvent.change";
		
		public function LocalizationEvent(type:Object, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
			
		}
		
	}

}