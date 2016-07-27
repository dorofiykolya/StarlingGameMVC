package game.modules.devices
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	import common.context.links.Link;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class DeviceExtension implements IExtension
	{
		
		public function DeviceExtension()
		{
		
		}
		
		/* INTERFACE common.context.extensions.IExtension */
		
		public function extend(context:IContext):void
		{
			CONFIG::ANDROID
			{
				import game.modules.devices.android.AndroidConfiguration;
				context.install(AndroidConfiguration);
				
				import game.modules.devices.android.AndroidDeviceInfo;
				context.install(new Link(AndroidDeviceInfo, IDeviceInfo));
			}
			CONFIG::IOS
			{
				import game.modules.devices.ios.IOSConfiguration;
				context.install(IOSConfiguration);
				
				import game.modules.devices.ios.IOSDeviceInfo;
				context.install(new Link(new IOSDeviceInfo, IDeviceInfo));
			}
		}
	
	}

}