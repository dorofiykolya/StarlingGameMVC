package game.modules.windows 
{
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class WindowQueue 
	{
		private var _list:Vector.<PathStack>;
		
		public function WindowQueue() 
		{
			_list = new Vector.<PathStack>();
		}
		
		public function enqueue(value:PathStack):void
		{
			_list.push(value);
		}
		
		public function dequeue():PathStack
		{
			return _list.shift();
		}
		
		public function get isEmpty():Boolean
		{
			return count == 0;
		}
		
		public function get count():int
		{
			return _list.length;
		}
		
		public function clear():void
		{
			_list.length = 0;
		}
		
		public function peek():PathStack
		{
			return _list[0];
		}
		
	}

}