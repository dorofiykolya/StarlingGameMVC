package game.modules.assets
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AssetsQuality
	{
		public static const LOW:AssetsQuality = new AssetsQuality("low");
		public static const NORMAL:AssetsQuality = new AssetsQuality("normal");
		public static const HIGH:AssetsQuality = new AssetsQuality("high");
		
		private var value:String;
		
		public function AssetsQuality(value:String)
		{
			this.value = value;
		}
		
		public function toString():String
		{
			return value;
		}
	}
}