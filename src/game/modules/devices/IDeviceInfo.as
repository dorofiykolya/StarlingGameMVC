package game.modules.devices 
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface IDeviceInfo 
	{
		function get textureMaxSize():int;
		function get totalMemory():int;
		function get supportQuality():DeviceSupportQuality;
	}
	
}