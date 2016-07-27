package game.modules.hotkey 
{
	//import com.demonsters.debugger.MonsterDebugger;
	import com.demonsters.debugger.MonsterDebugger;
	import common.context.IContext;
	import flash.events.KeyboardEvent;
	import game.modules.consoles.ConsoleManager;
	import game.modules.net.ISocketConnection;
	import game.modules.net.UINetLoggerManager;
	import mvc.configurations.IConfigurable;
	import starling.display.Stage;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class HotKeyConfiguration implements IConfigurable 
	{
		[Inject]
		public var keyboardManager:HotKeyManager;
		[Inject]
		public var uiNetLoggerManager:UINetLoggerManager;
		[Inject]
		public var consoleManager:ConsoleManager;
		[Inject]
		public var stage:Stage;
		[Inject]
		public var connection:ISocketConnection;
		
		public function HotKeyConfiguration() 
		{
			
		}
		
		/* INTERFACE mvc.configurations.IConfigurable */
		
		public function config(context:IContext):void 
		{
			keyboardManager.map("r", true).addEventListener(KeyboardEvent.KEY_UP, onCtrlRHandler);
			keyboardManager.map("`", true).addEventListener(KeyboardEvent.KEY_UP, onTildaHandler);
			keyboardManager.map("1", true).addEventListener(KeyboardEvent.KEY_UP, onKey1Handler);
			keyboardManager.map("2", true).addEventListener(KeyboardEvent.KEY_UP, onKey2Handler);
			keyboardManager.map("3", true).addEventListener(KeyboardEvent.KEY_UP, onKey3Handler);
		}
		
		private function onCtrlRHandler(e:KeyboardEvent):void 
		{
			connection.reconnect();
		}
		
		private function onKey3Handler(e:KeyboardEvent):void 
		{
			MonsterDebugger.initialize(stage);
		}
		
		private function onKey2Handler(e:KeyboardEvent):void 
		{
			//MonsterDebugger.initialize(stage);
		}
		
		private function onKey1Handler(e:KeyboardEvent):void 
		{
			if (consoleManager.opened)
			{
				consoleManager.close();
			}
			else
			{
				consoleManager.open();
			}
		}
		
		private function onTildaHandler(e:KeyboardEvent):void 
		{
			if (uiNetLoggerManager.opened)
			{
				uiNetLoggerManager.close();
			}
			else
			{
				uiNetLoggerManager.open();
			}
		}
		
	}

}