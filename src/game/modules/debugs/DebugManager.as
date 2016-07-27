package game.modules.debugs
{
	import common.system.Environment;
	import common.system.text.StringUtil;
	import flash.external.ExternalInterface;
	import game.configurations.Configuration;
	import game.managers.windows.WindowId;
	import game.managers.windows.WindowsManager;
	import game.modules.preloaders.PreloaderManager;
	import starling.display.DisplayObject;
	import starling.display.Stage;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class DebugManager
	{
		[Inject]
		public var windowManager:WindowsManager;
		[Inject]
		public var configuration:Configuration;
		[Inject]
		public var preloaderManager:PreloaderManager;
		[Inject]
		public var stage:Stage;
		
		public function DebugManager()
		{
		
		}
		
		public function openStartWindow():void
		{
			windowManager.open(WindowId.START_DEBUG);
		}
		
		public function get needOpenDebugWindow():Boolean
		{
			if (!Environment.isMobile || configuration.isMobileEmulation)
			{
				if (!ExternalInterface.available && configuration.openStartWindow)
				{
					return true;
				}
			}
			return false;
		}
		
		public function toggleLogAtMouse():void
		{
			stage.addEventListener(TouchEvent.TOUCH, onStageHoverTraceAtMouse);
		}
		
		private function onStageHoverTraceAtMouse(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage, TouchPhase.HOVER);
			if (touch)
			{
				var target:DisplayObject = touch.target;
				var index:int;
				while (target)
				{
					trace(StringUtil.duplicateText(" ", index) + StringUtil.format("{0}, sX:{1}, sY:{2}, x:{3}, y:{4}", target + ":" + target.name, target.scaleX, target.scaleY, target.x, target.y));
					target = target.parent;
					index++;
				}
			}
		}
	
	}

}