package game.utils
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class QueueExcuter
	{
		private var _queue:Vector.<QueueExecuterItem>;
		
		public function QueueExcuter()
		{
			_queue = new Vector.<QueueExecuterItem>();
		}
		
		public function enqueue(func:Function, args:Array = null):void
		{
			_queue[_queue.length] = new QueueExecuterItem(func, args);
		}
		
		public function get count():int
		{
			return _queue.length;
		}
		
		public function clear():void
		{
			_queue.length = 0;
		}
		
		public function execute(iteration:int = 1):Boolean
		{
			while(iteration > 0 && _queue.length != 0)
			{
				var current:QueueExecuterItem = _queue.shift();
				current.func.apply(null, current.args);
				iteration--;
			}
			return iteration == 0;
		}
	}
}

class QueueExecuterItem
{
	public var func:Function;
	public var args:Array;
	
	public function QueueExecuterItem(func:Function, args:Array)
	{
		this.func = func;
		this.args = args;
	}
}