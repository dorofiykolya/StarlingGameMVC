package game.modules.localizations
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LocalizationValue
	{
		/**
		 * key (example: "hello")
		 */
		public var id:String;
		
		/**
		 * value (example: "Hello World!")
		 */
		public var value:String;
		
		public function LocalizationValue(id:String = null, value:String = null)
		{
			this.id = id;
			this.value = value;
		}
	
	}

}