package game.modules.windows 
{
	import common.events.EventDispatcher;
	import common.system.utils.ObjectUtils;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class WindowData extends EventDispatcher
	{
		
		public function WindowData() 
		{
			
		}
		
		public function copy():WindowData
		{
			return ObjectUtils.clone(this) as WindowData;
		}
		
	}

}