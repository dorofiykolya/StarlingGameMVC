package game.modules.logs
{
	import com.junkbyte.console.Cc;
	import common.system.utils.ObjectUtils;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Logger implements ILogger
	{
		
		public function Logger()
		{
		
		}
		
		/* INTERFACE game.modules.logs.ILogger */
		
		public function log(message:Object, context:Object = null):void
		{
			Cc.log(message);
			trace("Debug:   " + message);
			if (context != null)
			{
				Cc.inspect(context);
			}
		}
		
		public function note(message:Object, context:Object = null):void
		{
			Cc.log(message);
			trace("Info:    " + String(message));
			if (context != null)
			{
				Cc.inspect(context);
			}
		}
		
		public function warning(message:Object, context:Object = null):void
		{
			Cc.warn(message);
			trace("Warning: " + String(message));
			if (context != null)
			{
				Cc.inspect(context);
			}
		}
		
		public function error(message:Object, exception:Error = null):void
		{
			Cc.fatal(message);
			var errorMessage:String;
			if (exception != null)
			{
				errorMessage = String(exception);
			}
			else
			{
				errorMessage = "";
			}
			trace("Error:   " + String(message) + ", " + errorMessage);
		}
		
		public function alert(message:Object, context:Object = null):void
		{
			Cc.error(message);
			trace("Fatal:   " + String(message));
			if (context != null)
			{
				Cc.inspect(context);
			}
		}
		
		public function inspect(value:Object):void
		{
			Cc.inspect(value);
			trace(ObjectUtils.toString(value));
		}
	
	}

}