package game.modules.fullscreens
{
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import starling.display.DisplayObject;
	import starling.display.Stage;
	import flash.events.MouseEvent;
	import game.GameApplication;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class FullScreenManager
	{
		static public const HELP_POINT:Point = new Point();
		
		private var _gameApplication:GameApplication;
		private var _nativeStage:flash.display.Stage;
		private var _starlingStage:starling.display.Stage;
		private var _map:Dictionary;
		
		public function FullScreenManager(gameApplication:GameApplication, nativeStage:flash.display.Stage, starlingStage:starling.display.Stage)
		{
			_map = new Dictionary();
			_starlingStage = starlingStage;
			_nativeStage = nativeStage;
			_gameApplication = gameApplication;
			_nativeStage.addEventListener(MouseEvent.CLICK, onNativeMouseClick);
		}
		
		public function bind(target:DisplayObject):void
		{
			_map[target] = target;
		}
		
		private function onNativeMouseClick(e:MouseEvent):void
		{
			HELP_POINT.setTo(e.stageX, e.stageY);
			var result:DisplayObject = _starlingStage.hitTest(HELP_POINT, true);
			while(result && !(result in _map))
			{
				result = result.parent;
				if (result == null || result == _starlingStage)
				{
					return;
				}
			}
			if (result && (result in _map))
			{
				_gameApplication.fullScreen = !_gameApplication.fullScreen;
			}
		}
		
		public function get fullScreen():Boolean
		{
			return _gameApplication.fullScreen;
		}
	
	}

}