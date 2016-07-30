package game.modules.windows
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class WindowTypeInfo
	{
		private var _windowId:WindowId;
		private var _windowMediator:Class;
		private var _windowType:WindowType;
		
		public function WindowTypeInfo(windowId:WindowId, windowType:WindowType, windowMediator:Class)
		{
			_windowMediator = windowMediator;
			_windowType = windowType;
			_windowId = windowId;
		}
		
		public function get windowId():WindowId
		{
			return _windowId;
		}
		
		public function get windowMediator():Class
		{
			return _windowMediator;
		}
		
		public function get windowType():WindowType
		{
			return _windowType;
		}
	}
}