package core.net
{
	/**
	 * ...
	 * @author dorofiy
	 */
	public class NetLog
	{
		public static var Limit:uint = 700;
		private static var stack:Vector.<NetLog> = new Vector.<NetLog>();
		private static var current:NetLog;
		
		public static function get Logs():Vector.<NetLog>
		{
			return stack;
		}
		
		public static function Clear():void
		{
			stack.length = 0;
		}
		
		public static function WriteSend(key:String, data:Object):void
		{
			if (stack.length >= Limit)
			{
				current = stack.shift();
				current.Set(new Date, key, data, "SEND");
				stack[stack.length] = current;
				return;
			}
			stack[stack.length] = (new NetLog(new Date, key, data, "SEND"));
		}
		
		public static function WriteReceive(key:String, data:Object):void
		{
			if (stack.length >= Limit)
			{
				current = stack.shift();
				current.Set(new Date, key, data, "GET");
				stack[stack.length] = current;
				return;
			}
			stack[stack.length] = (new NetLog(new Date, key, data, "GET"));
		}
		
		////////////////////////// INSTANCE //////////////////////
		public var date:Date;
		public var key:String;
		public var value:Object;
		public var type:String;
		
		public function NetLog(date:Date = null, key:String = null, value:Object = null, type:String = null)
		{
			this.date = date;
			this.key = key;
			this.value = value;
			this.type = type;
		}
		
		public function Set(date:Date, key:String, value:Object, type:String):void
		{
			this.date = date;
			this.key = key;
			this.value = value;
			this.type = type;
		}
	}

}