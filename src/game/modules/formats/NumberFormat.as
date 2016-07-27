package game.modules.formats
{
	import flash.globalization.LocaleID;
	import flash.globalization.NumberFormatter;
	import flash.system.Capabilities;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class NumberFormat
	{
		private var _formatter:NumberFormatter;
		
		public function NumberFormat()
		{
			_formatter = new NumberFormatter(LocaleID.DEFAULT);
		}
		
		public function format(value:Number):String
		{
			return _formatter.formatNumber(value);
		}
	
	}

}