package game.modules.sounds
{
	import common.system.Enum;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Channel extends Enum
	{
		public static const MUSIC:Channel = new Channel("music", true);
		public static const FX:Channel = new Channel("fx", false);
		
		private var _oneInstance:Boolean;
		
		public function Channel(name:String, oneInstance:Boolean)
		{
			super(name);
			_oneInstance = oneInstance;
			
		}
		
		public function get oneInstance():Boolean 
		{
			return _oneInstance;
		}
	
	}

}