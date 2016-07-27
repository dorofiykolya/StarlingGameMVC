package game.modules.logs 
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface ILogger 
	{
		function log(message:Object, context:Object = null):void;
		function note(message:Object, context:Object = null):void;
		function warning(message:Object, context:Object = null):void;
		function error(message:Object, error:Error = null):void;
		function alert(message:Object, context:Object = null):void;
		function inspect(value:Object):void;
	}
	
}