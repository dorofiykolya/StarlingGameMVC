package game.modules.net
{
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface INetParser
	{
		function parse(value:Object, buffer:ByteArray):void;
		function unparse(buffer:ByteArray):ParseResult;
	}

}