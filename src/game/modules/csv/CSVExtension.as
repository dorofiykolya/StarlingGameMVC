package game.modules.csv
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	import common.system.ClassType;
	import common.system.Type;
	import common.system.reflection.Constant;
	import common.system.reflection.Field;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class CSVExtension implements IExtension
	{
		private var _parsersType:Object;
		private var _csvEmbedsType:Object;
		
		/**
		 *
		 * @param	parsersType (class or instance) with fields/contents ICSVParser
		 * @param	embedsType (class or instance) with fields/constants embeded or instances csv (text/bytearray)
		 */
		public function CSVExtension(parsersType:Object, csvEmbedsType:Object)
		{
			_csvEmbedsType = csvEmbedsType;
			_parsersType = parsersType;
		}
		
		public function extend(context:IContext):void
		{
			var embedType:Type = ClassType.getType(_csvEmbedsType);
			
			for each (var constant:Constant in embedType.constants)
			{
				parserByMember(constant.name, context);
			}
			
			for each (var field:Field in embedType.fields)
			{
				parserByMember(field.name, context);
			}
			
			for (var key:String in _csvEmbedsType)
			{
				parserByMember(key, context);
			}
		}
		
		private function parserByMember(memberName:String, context:IContext):void
		{
			if (memberName in _parsersType)
			{
				var parser:ICSVParser = _parsersType[memberName] as ICSVParser;
				context.install(parser);
				parse(parser, _csvEmbedsType[memberName]);
			}
		}
		
		private function parse(parser:ICSVParser, value:Object):void
		{
			if (value is Class)
			{
				parser.parse(ByteArray(new value));
			}
			else if (value is ByteArray)
			{
				parser.parse(ByteArray(value));
			}
			else if (value is String)
			{
				var byteArray:ByteArray = new ByteArray();
				byteArray.writeUTFBytes(String(value));
				byteArray.position = 0;
				parser.parse(byteArray);
			}
			else
			{
				throw new ArgumentError("unsupported value:" + value);
			}
		}
	
	}

}