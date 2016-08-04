package game.modules.debugs
{
	import common.system.text.StringUtil;
	import starling.display.DisplayObject;
	import starling.display.Stage;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class DebugMouseLogManager
	{
		[Inject]
		public var stage:Stage;
		
		private var _enabled:Boolean;
		
		public function DebugMouseLogManager()
		{
		
		}
		
		public function toggleLogAtMouse():void
		{
			if (!_enabled)
			{
				stage.addEventListener(TouchEvent.TOUCH, onStageHoverTraceAtMouse);
			}
			else
			{
				stage.removeEventListener(TouchEvent.TOUCH, onStageHoverTraceAtMouse);
			}
			_enabled = !_enabled;
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