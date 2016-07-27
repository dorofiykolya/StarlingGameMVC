package game.modules.net
{
	import common.system.ClassType;
	import common.system.Type;
	import common.system.utils.ObjectUtils;
	import flash.utils.ByteArray;
	import game.modules.logs.ILogger;
	
	/**
	 * ...
	 * @author ...
	 */
	public class NetConnectionSender implements IConnectionSend
	{
		private var _server:ISocketConnection;
		private var _parser:INetParser;
		private var _buffer:ByteArray;
		private var _logger:ILogger;
		private var _netLogger:INetLogger;
		
		public function NetConnectionSender(server:ISocketConnection, parser:INetParser, logger:ILogger, netLogger:INetLogger)
		{
			_buffer = new ByteArray();
			_server = server;
			_parser = parser;
			_logger = logger;
			_netLogger = netLogger;
		}
		
		/* INTERFACE game.modules.net.IConnectionSend */
		
		public function send(value:Object):void
		{
			if (!_server.connected)
			{
				_logger.error("send to not connected socket, packet:" + JSON.stringify(value), new Error());
				return;
			}
			
			if (value is String)
			{
				_netLogger.send(String(value), value);
				_logger.note("<-OUT-" + value);
			}
			else
			{
				for (var key:String in value)
				{
					_netLogger.send(key, value[key]);
					_logger.note("<-OUT-" + key);
				}
			}
			_buffer.clear();
			_parser.parse(value, _buffer);
			_server.socket.writeBytes(_buffer, 0, _buffer.length);
			_server.socket.flush();
		}
	}
}