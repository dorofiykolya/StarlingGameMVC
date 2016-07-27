package game.modules.net 
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface INetLogger 
	{
		function send(key:String, data:Object):void;
		function receive(key:String, data:Object):void;
	}
	
}