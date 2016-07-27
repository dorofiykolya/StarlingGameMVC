package game.modules.alert 
{
	import game.modules.logs.ILogger;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AlertManager 
	{
		private var _logger:ILogger;
		
		public function AlertManager(logger:ILogger) 
		{
			_logger = logger;
		}
		
		public function alert(title:String, message:String, buttonLabel:String, callback:Function):void
		{
			CONFIG::ANDROID
			{
				try
				{				
					import com.freshplanet.ane.AirAlert.AirAlert;
					if (AirAlert.isSupported)
					{
						AirAlert.getInstance().showAlert(title, message, buttonLabel, callback);
					}
				}
				catch (e:Error)
				{
					_logger.error("[game.modules.alert.AlertManager][alert]", e);
				}
			}
			
			CONFIG::IOS
			{
				try
				{				
					import com.freshplanet.ane.AirAlert.AirAlert;
					if (AirAlert.isSupported)
					{
						AirAlert.getInstance().showAlert(title, message, buttonLabel, callback);
					}
				}
				catch (e:Error)
				{
					_logger.error("[game.modules.alert.AlertManager][alert]", e);
				}
			}
		}
		
	}

}