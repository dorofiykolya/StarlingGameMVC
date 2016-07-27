package game.modules.net
{
	import common.events.IEventListener;
	import common.system.net.Socket;
	
	[Event(name = "securityError", type = "game.modules.net.events.NetSecurityErrorEvent")]
	[Event(name = "socketData", type = "game.modules.net.events.NetSocketDataEvent")]
	[Event(name = "ioError", type = "game.modules.net.events.NetIOErrorEvent")]
	[Event(name = "connect", type = "game.modules.net.events.NetEvent")]
	[Event(name = "close", type = "game.modules.net.events.NetEvent")]
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface ISocketConnection extends IEventListener
	{
		function connect(host:String, port:int):void;
		function reconnect():void;
		function close():void;
		function get host():String;
		function get port():int;
		function get socket():Socket;
		function get connected():Boolean;
	}
}