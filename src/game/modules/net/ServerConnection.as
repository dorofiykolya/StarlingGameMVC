package game.modules.net
{
	import common.events.EventDispatcher;
	import common.system.net.Socket;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import game.modules.logs.ILogger;
	import game.modules.net.events.NetEvent;
	import game.modules.net.events.NetIOErrorEvent;
	import game.modules.net.events.NetSecurityErrorEvent;
	import game.modules.net.events.NetSocketDataEvent;
	
	[Event(name = "securityError", type = "game.modules.net.events.NetSecurityErrorEvent")]
	[Event(name = "socketData", type = "game.modules.net.events.NetSocketDataEvent")]
	[Event(name = "ioError", type = "game.modules.net.events.NetIOErrorEvent")]
	[Event(name = "connect", type = "game.modules.net.events.NetEvent")]
	[Event(name = "close", type = "game.modules.net.events.NetEvent")]
	
	/**
	 * ...
	 * @author ...
	 */
	public class ServerConnection extends EventDispatcher implements ISocketConnection
	{
		private var _socket:Socket;
		private var _logger:ILogger;
		
		public function ServerConnection(logger:ILogger)
		{
			_logger = logger;
			_socket = new Socket();
			_socket.addEventListener(Event.CLOSE, onSocketClose);
			_socket.addEventListener(Event.CONNECT, onSocketConnect);
			_socket.addEventListener(IOErrorEvent.IO_ERROR, onSocketIOError);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSocketSecurityError);
			//_socket.loadPolicyFile = true;
		}
		
		public function get socket():Socket
		{
			return _socket;
		}
		
		private function onSocketSecurityError(e:SecurityErrorEvent):void
		{
			_logger.note(">>>connection: securityError: " + e.errorID + ", " + e.text);
			dispatchEventAs(NetSecurityErrorEvent, e.type, false, e.text, [e.errorID, e.text]);
		}
		
		private function onSocketData(e:ProgressEvent):void
		{
			dispatchEventAs(NetSocketDataEvent, e.type, false, _socket, [e.bytesLoaded, e.bytesTotal]);
		}
		
		private function onSocketIOError(e:IOErrorEvent):void
		{
			_logger.note(">>>connection: ioError: " + e.errorID + ", " + e.text);
			dispatchEventAs(NetIOErrorEvent, e.type, false, e.text, [e.errorID, e.text]);
		}
		
		private function onSocketConnect(e:Event):void
		{
			_logger.note(">>>connection: connected: " + host + ":" + port);
			dispatchEventAs(NetEvent, e.type);
		}
		
		private function onSocketClose(e:Event):void
		{
			_logger.note(">>>connection: closed: " + host + ":" + port);
			dispatchEventAs(NetEvent, e.type);
		}
		
		/* INTERFACE game.modules.net.IConnection */
		
		public function connect(host:String, port:int):void
		{
			_logger.note(">>>user connection: connect: " + host + ":" + port);
			_socket.connect(host, port);
		}
		
		public function reconnect():void
		{
			_logger.note(">>>user connection: reconnect: " + host + ":" + port);
			_socket.reconnect();
		}
		
		public function close():void
		{
			_logger.note(">>>user connection: close");
			_socket.close();
		}
		
		/* DELEGATE common.system.net.Socket */
		
		public function get connected():Boolean 
		{
			return _socket.connected;
		}
		
		public function get host():String
		{
			return _socket.host;
		}
		
		public function get port():int
		{
			return _socket.port;
		}
	}
}