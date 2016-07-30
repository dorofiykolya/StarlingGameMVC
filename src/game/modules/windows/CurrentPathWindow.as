package game.modules.windows
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class CurrentPathWindow extends PathWindow
	{
		private var _windowType:WindowType;
		
		public function CurrentPathWindow(windowType:WindowType)
		{
			super(null, null);
			_windowType = windowType;
		}
		
		public function get windowType():WindowType
		{
			return _windowType;
		}
	
	}

}