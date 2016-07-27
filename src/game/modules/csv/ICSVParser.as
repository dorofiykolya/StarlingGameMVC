package game.modules.csv
{
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface ICSVParser
	{
		function parse(value:ByteArray):void;
	}

}