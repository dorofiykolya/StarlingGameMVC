package game.modules.localizations
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Localization
	{
		/**
		 * ID  (en, es, ...)
		 */
		public var name:String;
		
		/**
		 * language (English, ...)
		 */
		public var language:String;
		
		/**
		 * array of key-value
		 */
		public var localization:Vector.<LocalizationValue>;
		
		public function Localization()
		{
		
		}
	
	}

}