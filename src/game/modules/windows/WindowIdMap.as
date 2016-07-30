package game.modules.windows
{
	import common.system.Assert;
	import common.system.ClassType;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class WindowIdMap
	{
		private var _collection:Dictionary;
		
		public function WindowIdMap()
		{
			_collection = new Dictionary();
		}
		
		public function map(windowMediator:Class, windowId:WindowId, windowType:WindowType):void
		{
			Assert.subclassOf(windowMediator, WindowMediator);
			
			_collection[windowId] = new WindowTypeInfo(windowId, windowType, windowMediator);
		}
		
		public function getMediatorType(windowId:WindowId):Class
		{
			return getInfo(windowId).windowMediator;
		}
		
		public function getWindowType(windowId:WindowId):WindowType
		{
			return getInfo(windowId).windowType;
		}
		
		public function getInfo(windowId:WindowId):WindowTypeInfo
		{
			return _collection[windowId];
		}
	
	}

}