package game.modules.devices.android
{
	import flash.system.Capabilities;
	import game.configurations.Configuration;
	import game.modules.devices.DeviceSupportQuality;
	import game.modules.devices.IDeviceInfo;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AndroidDeviceInfo implements IDeviceInfo
	{
		private var _textureMaxSize:int;
		private var _totalMemory:int;
		private var _quality:DeviceSupportQuality;
		
		public function AndroidDeviceInfo(configuration:Configuration)
		{
			try
			{
				var instance:DeviceRAMInterface = DeviceRAMInterface.deviceRAM;
				_textureMaxSize = instance.getTextureMaxSize;
				_totalMemory = instance.getTotalMemory;
			}
			catch (e:Error)
			{
				_textureMaxSize = 2048;
				_totalMemory = 1024;
			}
			
			var resolution:Number = Math.max(Capabilities.screenResolutionX, Capabilities.screenResolutionY);
			
			var isLow:Boolean = _totalMemory <= configuration.minRamSize || _textureMaxSize <= 1024 || resolution <= 640;
			var isHLow:Boolean = isLow && _totalMemory >= 460 && _textureMaxSize >= 2048 && resolution >= 640;
			var isNornal:Boolean = _totalMemory >= 760 && _textureMaxSize >= 2048 && resolution >= 640;
			var isHNormal:Boolean = _totalMemory >= 1024 && _textureMaxSize >= 4096 && resolution >= 640;
			var isHight:Boolean = _totalMemory >= 1800 && _textureMaxSize >= 4096 && resolution >= 640;
			
			if (isLow)
			{
				_quality = DeviceSupportQuality.LOW;
			}
			if (isHLow)
			{
				_quality = DeviceSupportQuality.HLOW;
			}
			if (isNornal)
			{
				_quality = DeviceSupportQuality.NORMAL;
			}
			if (isHNormal)
			{
				_quality = DeviceSupportQuality.HNORMAL;
			}
			if (isHight)
			{
				_quality = DeviceSupportQuality.HIGH;
			}
		}
		
		public function get supportQuality():DeviceSupportQuality
		{
			return _quality;
		}
		
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