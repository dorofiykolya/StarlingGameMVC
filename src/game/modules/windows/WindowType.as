package game.modules.windows 
{
	import common.system.Enum;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class WindowType extends Enum 
	{
		static public const WINDOWS:WindowType = new WindowType("windows");
		static public const POPUP:WindowType = new WindowType("popUp");
		
		public function WindowType(name:String) 
		{
			super(value);
		}
		
	}

}