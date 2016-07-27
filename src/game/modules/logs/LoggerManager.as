package game.modules.logs
{
	import flash.display.Stage;
	import flash.events.ErrorEvent;
	import flash.events.UncaughtErrorEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LoggerManager
	{
		private var _logger:ILogger;
		
		public function LoggerManager(nativeStage:Stage, logger:ILogger)
		{
			_logger = logger;
			nativeStage.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onError);
		}
		
		private function onError(event:UncaughtErrorEvent):void
		{
			var message:String;
			if (event.error is Error)
			{
				message = Error(event.error).message;
				_logger.error(message, Error(event.error));
			}
			else if (event.error is ErrorEvent)
			{
				message = ErrorEvent(event.error).text;
				_logger.error(message);
			}
			else
			{
				message = event.error.toString();
				_logger.error(message);
			}
		}
	
	}

}