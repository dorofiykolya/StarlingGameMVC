package game.modules.fullscreens
{
	import common.system.application.controllers.DisplayStateController;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import starling.display.DisplayObject;
	import starling.display.Stage;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class FullScreenManager
	{
		static public const HELP_POINT:Point = new Point();
		
		private var _nativeStage:flash.display.Stage;
		private var _starlingStage:starling.display.Stage;
		private var _map:Dictionary;
		private var _displayState:DisplayStateController;
		
		public function FullScreenManager(nativeStage:flash.display.Stage, starlingStage:starling.display.Stage)
		{
			_map = new Dictionary();
			_starlingStage = starlingStage;
			_nativeStage = nativeStage;
			_displayState = new DisplayStateController(nativeStage);
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
				if (fullScreen)
				{
					_displayState.normal();
				}
				else
				{
					_displayState.fullScreenInteractive();
				}
			}
		}
		
		public function get fullScreen():Boolean
		{
			return _displayState.isFullScreen || _displayState.isFullScreenInteractive;
		}
	
	}

}