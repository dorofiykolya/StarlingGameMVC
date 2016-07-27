package game.modules.hotkey 
{
	import common.system.keyboard.KeyboardMap;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class HotKeyManager 
	{
		private var _keyboard:KeyboardMap;
		
		public function HotKeyManager(nativeStage:Stage) 
		{
			_keyboard = new KeyboardMap(nativeStage);
		}
		
		/* DELEGATE common.system.keyboard.KeyboardMap */
		
		public function map(charOrKeyCode:Object, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false):EventDispatcher 
		{
			return _keyboard.map(charOrKeyCode, ctrlKey, altKey, shiftKey);
		}
		
	}

}