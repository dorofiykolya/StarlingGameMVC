package game.modules.devices.ios
{
	import game.modules.devices.DeviceSupportQuality;
	import game.modules.devices.IDeviceInfo;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class IOSDeviceInfo implements IDeviceInfo
	{
		private var _textureMaxSize:int = 4096;
		private var _totalMemory:int = 512;
		private var _supportQuality:DeviceSupportQuality;
		
		public function IOSDeviceInfo()
		{
		
		}
		
		
		/* INTERFACE game.modules.devices.IDeviceInfo */
		
		public function get supportQuality():DeviceSupportQuality 
		{
			return _supportQuality;
		}
		
		/* INTERFACE game.modules.devices.IDeviceInfo */
		
		public function get textureMaxSize():int
		{
			return _textureMaxSize;
		}
		
		public function get totalMemory():int
		{
			return _totalMemory;
		}
	
	}

}