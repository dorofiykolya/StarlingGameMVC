package game.modules.net
{
	import core.net.NetLog;
	import game.configurations.Configuration;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class NetLoggerManager implements INetLogger
	{
		private var _configuration:Configuration;
		
		public function NetLoggerManager(configuration:Configuration)
		{
			_configuration = configuration;
		}
		
		/* INTERFACE game.modules.net.INetLogger */
		
		public function send(key:String, data:Object):void
		{
			NetLog.Limit = _configuration.maxNetLogs;
			NetLog.WriteSend(key, data);
		}
		
		public function receive(key:String, data:Object):void
		{
			NetLog.Limit = _configuration.maxNetLogs;
			NetLog.WriteReceive(key, data);
		}
	
	}

}