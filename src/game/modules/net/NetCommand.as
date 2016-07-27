package game.modules.net
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class NetCommand
	{
		private var _dataType:Class;
		private var _flags:Array;
		
		public function NetCommand(dataType:Class, flags:Array)
		{
			_dataType = dataType;
			_flags = flags;
		}
		
		public function containsFlag(flag:NetCommandFlag):Boolean
		{
			return _flags.indexOf(flag) != -1;
		}
		
		public function get dataType():Class
		{
			return _dataType;
		}
		
		public function execute(data:Object = null):void
		{
		
		}
	
	}

}