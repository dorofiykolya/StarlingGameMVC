package game.mvc
{
	import game.modules.applications.IApplicationDescription;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ContextConfiguration
	{
		public var correctAspectRatio:Boolean;
		public var fps:int = 60;
		public var maxNetLogs:int = 1000;
		public var mobileAssetsPath:String = "assets";
		public var browserAssetsPath:String = "assets";
		public var mobileSoundsPath:String = "sounds";
		public var browserSoundsPath:String = "sounds";
		
		public function ContextConfiguration()
		{
		
		}
	
	}

}