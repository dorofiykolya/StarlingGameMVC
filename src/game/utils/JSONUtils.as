package game.utils
{
	import common.system.utils.ObjectUtils;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class JSONUtils
	{
		
		public function JSONUtils()
		{
		
		}
		
		public static function fromString(value:String, toType:Class):Object
		{
			var obj:Object = JSON.parse(value);
			return ObjectUtils.toType(obj, toType);
		}
		
		public static function fromClass(value:Class, toType:Class):Object
		{
			var bytes:ByteArray = new value();
			return fromString(bytes.readUTFBytes(bytes.bytesAvailable), toType);
		}
	
	}

}