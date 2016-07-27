package game.modules.csv
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	import common.system.ClassType;
	import common.system.reflection.Constant;
	import embeds.CSVEmbeds;
	import embeds.CSVParserEmbeds;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class CSVExtension implements IExtension
	{
		
		public function CSVExtension()
		{
		
		}
		
		public function extend(context:IContext):void
		{
			context.install(CSVConfiguration);
			context.install(CSVManager);
			
			var constants:Vector.<Constant> = ClassType.getClassType(CSVEmbeds).constants;
			for each (var constant:Constant in constants)
			{
				var parser:ICSVParser = new (CSVParserEmbeds[constant.name]);
				context.install(parser);
				parse(parser, CSVEmbeds[constant.name]);
			}
		}
		
		private function parse(parser:ICSVParser, value:Class):void
		{
			parser.parse(ByteArray(new value));
		}
	
	}

}