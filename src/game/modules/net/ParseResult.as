package game.modules.net
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ParseResult
	{
		public static const SUCCESS_STATUS:String = "successStatus";
		public static const ERROR_STATUS:String = "errorStatus";
		public static const NOT_ENOUGH_BYTES_STATUS:String = "notEnoughBytesStatus";
		
		public var result:Object;
		public var status:String;
		public var bytes:int;
		
		public function ParseResult()
		{
		
		}
		
		public function get isSuccess():Boolean
		{
			return status == SUCCESS_STATUS;
		}
		
		public function get isError():Boolean
		{
			return status == ERROR_STATUS;
		}
		
		public function get isNotEnoughBytes():Boolean
		{
			return status == NOT_ENOUGH_BYTES_STATUS;
		}
	
	}

}