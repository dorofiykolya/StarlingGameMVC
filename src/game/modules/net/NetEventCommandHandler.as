package game.modules.net
{
	import common.system.net.Socket;
	import flash.utils.ByteArray;
	import game.modules.logs.ILogger;
	import game.modules.net.events.NetEvent;
	import game.modules.net.events.NetSocketDataEvent;
	
	/**
	 * ...
	 * @author ...
	 */
	public class NetEventCommandHandler
	{
		private var _server:ISocketConnection;
		private var _parser:INetParser;
		private var _buffer:ByteArray;
		private var _temp:ByteArray;
		private var _handler:INetHandler;
		private var _logger:ILogger;
		private var _errorHandler:INetErrorHandler;
		private var _netLogger:INetLogger;
		
		public function NetEventCommandHandler(server:ISocketConnection, parser:INetParser, handler:INetHandler, errorHandler:INetErrorHandler, logger:ILogger, netLogger:INetLogger)
		{
			_netLogger = netLogger;
			_errorHandler = errorHandler;
			_buffer = new ByteArray();
			_temp = new ByteArray();
			_server = server;
			_parser = parser;
			_handler = handler;
			_logger = logger;
			_server.addEventListener(NetSocketDataEvent.SOCKET_DATA, onSocketData);
			_server.addEventListener(NetEvent.CLOSE, onSocketClose);
			_server.addEventListener(NetEvent.CONNECT, onSocketConnect);
		}
		
		private function onSocketConnect(e:NetEvent):void
		{
			_buffer.clear();
			_temp.clear();
		}
		
		private function onSocketClose(e:NetEvent):void
		{
			_buffer.clear();
			_temp.clear();
		}
		
		private function onSocketData(e:NetSocketDataEvent):void
		{
			var socket:Socket = e.data as Socket;
			if (socket.bytesAvailable != 0)
			{
				while (socket.bytesAvailable != 0)
				{
					_buffer.writeByte(socket.readByte());
				}
				var result:ParseResult;
				while (!(result = _parser.unparse(_buffer)).isNotEnoughBytes)
				{
					switch (result.status)
					{
						case ParseResult.SUCCESS_STATUS: 
							_temp.clear();
							_temp.writeBytes(_buffer, result.bytes, _buffer.length - result.bytes);
							_buffer.clear();
							_buffer.writeBytes(_temp, 0, _temp.length);
							
							invoke(result.result);
							break;
						case ParseResult.ERROR_STATUS: 
							_temp.clear();
							_temp.writeBytes(_buffer, result.bytes, _buffer.length - result.bytes);
							_buffer.clear();
							_buffer.writeBytes(_temp, 0, _temp.length);
							break;
					}
				}
			}
		}
		
		private function invoke(value:Object):void
		{
			for (var key:Object in value)
			{
				_netLogger.receive(String(key), value[key]);
				_logger.note("-IN->" + key);
				if ("error" in value[key])
				{
					_errorHandler.invoke(key, value[key].error);
				}
				else
				{
					_handler.invoke(key, value[key]);
				}
			}
		}
	}

}