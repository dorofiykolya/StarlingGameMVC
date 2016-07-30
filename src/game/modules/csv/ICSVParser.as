package game.modules.csv
{
	import common.system.collection.IEnumerator;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface ICSVParser extends IEnumerator
	{
		function parse(value:ByteArray):void;
	}

}