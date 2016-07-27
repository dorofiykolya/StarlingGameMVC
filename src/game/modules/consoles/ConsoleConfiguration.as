package game.modules.consoles
{
	import com.junkbyte.console.Cc;
	import common.context.IContext;
	import common.system.Environment;
	import mvc.configurations.IConfigurable;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ConsoleConfiguration implements IConfigurable
	{
		
		public function ConsoleConfiguration()
		{
		
		}
		
		/* INTERFACE mvc.configurations.IConfigurable */
		
		public function config(context:IContext):void
		{
			Cc.config.style.big();
			Cc.config.alwaysOnTop = true;
			Cc.config.commandLineAllowed = true;
			Cc.config.commandLineAutoCompleteEnabled = true;
			Cc.config.commandLineAutoScope = true;
			Cc.config.showLineNumber = true;
			Cc.config.showTimestamp = true;
			
			Cc.config.remotingPassword = "";
			Cc.remoting = !Environment.isMobile;
			Cc.remotingSocket("127.0.0.1", 9999);
			Cc.commandLine = true;
		}
	
	}

}