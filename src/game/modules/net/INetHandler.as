package game.modules.net
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface INetHandler
	{
		function add(packet:Packet, command:NetCommand):void;
		function remove(packet:Packet, command:NetCommand):void;
		function invoke(key:Object, value:Object):void;
	}

}