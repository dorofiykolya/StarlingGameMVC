package game.modules.windows
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class PathStack
	{
		private var _list:Vector.<PathWindow>;
		
		public function PathStack()
		{
			_list = new Vector.<PathWindow>();
		}
		
		public function enqueue(value:PathWindow):void
		{
			_list.push(value);
		}
		
		public function pop():PathWindow
		{
			return _list.pop();
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
		
		public function peek():PathWindow
		{
			return _list[0];
		}
	
	}

}