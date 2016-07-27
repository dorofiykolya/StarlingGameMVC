package game.modules.net
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class NetJsonParser implements INetParser
	{
		private static const JSON_REGEXP:RegExp = new RegExp("[" + String.fromCharCode(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31) + "]", "gi");
		
		private var _compress:Boolean;
		private var _compressBuffer:ByteArray;
		private var _endian:String;
		private var _parserResult:ParseResult;
		private var _uncompressBuffer:ByteArray;
		
		public function NetJsonParser()
		{
			_compressBuffer = new ByteArray();
			_uncompressBuffer = new ByteArray();
			_endian = Endian.BIG_ENDIAN;
			_parserResult = new ParseResult();
		}
		
		/* INTERFACE game.modules.net.INetParser */
		
		public function parse(value:Object, buffer:ByteArray):void
		{
			var send:String = value as String;
			if (send == null)
			{
				send = JSON.stringify(jsonCorrect(value));
			}
			
			if (_compress)
			{
				_compressBuffer.clear();
				_compressBuffer.writeUTFBytes(send);
				_compressBuffer.compress();
				buffer.writeUnsignedInt(_compressBuffer.length);
				buffer.writeBytes(_compressBuffer, 0, _compressBuffer.length);
			}
			else
			{
				buffer.writeUTFBytes(send);
				buffer.writeByte(0);
			}
		}
		
		public function unparse(buffer:ByteArray):ParseResult
		{
			var lastPosition:uint = buffer.position;
			if (buffer.length >= 4)
			{
				buffer.position = 0;
				buffer.endian = _endian;
				var bytes:int = buffer.readInt();
				if (buffer.bytesAvailable >= bytes)
				{
					_uncompressBuffer.clear();
					buffer.readBytes(_uncompressBuffer, 0, bytes);
					_uncompressBuffer.position = 0;
					_uncompressBuffer.uncompress();
					_uncompressBuffer.position = 0;
					var json:String = _uncompressBuffer.readUTFBytes(_uncompressBuffer.bytesAvailable);
					
					_parserResult.bytes = bytes + 4;
					json = String(jsonCorrect(json));
					_parserResult.result = JSON.parse(json);
					_parserResult.status = ParseResult.SUCCESS_STATUS;
					return _parserResult;
				}
			}
			_parserResult.bytes = 0;
			_parserResult.result = null;
			_parserResult.status = ParseResult.NOT_ENOUGH_BYTES_STATUS;
			buffer.position = lastPosition;
			return _parserResult;
		}
		
		private static function jsonCorrect(data:Object):Object
		{
			var result:String = data as String;
			if (result != null)
			{
				result = result.replace(JSON_REGEXP, "");
				return result;
			}
			return data;
		}
	
	}

}