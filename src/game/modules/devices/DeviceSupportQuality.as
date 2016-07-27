package game.modules.devices
{
	import common.system.Enum;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class DeviceSupportQuality extends Enum
	{
		public static const LOW:DeviceSupportQuality = new DeviceSupportQuality(0, "low");
		public static const HLOW:DeviceSupportQuality = new DeviceSupportQuality(1, "normal UI, low other");
		public static const NORMAL:DeviceSupportQuality = new DeviceSupportQuality(2, "all normal");
		public static const HNORMAL:DeviceSupportQuality = new DeviceSupportQuality(3, "high UI, normal other");
		public static const HIGH:DeviceSupportQuality = new DeviceSupportQuality(4, "high all");
		
		public function DeviceSupportQuality(value:int, description:String = null)
		{
			super(value);
		}
	
	}

}