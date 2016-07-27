package game.modules.csv
{
	import common.csv.CSV;
	import common.system.collection.IEnumerable;
	import common.system.collection.IEnumerator;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class CSVParser implements ICSVParser, IEnumerable
	{
		private var _csv:CSV;
		private var _toType:Class;
		
		public function CSVParser(toType:Class)
		{
			_toType = toType;
		}
		
		public function parse(value:ByteArray):void
		{
			value.position = 0;
			var str:String = value.readUTFBytes(value.length);
			str = str.split("\r\n").join("\n");
			_csv = new CSV(str, "\n", ";", _toType);
		}
		
		public function get count():int
		{
			return _csv.count;
		}
		
		public function getEnumerator():IEnumerator
		{
			return _csv;
		}
	}

}