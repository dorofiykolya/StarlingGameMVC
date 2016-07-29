package game.modules.applications
{
	import common.events.Event;
	import common.system.application.Application;
	import flash.events.Event;
	import flash.utils.getTimer;
	import starling.display.Stage;
	import starling.events.EnterFrameEvent;
	import starling.events.TouchEvent;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class IdleManager
	{
		private static const KEEP_AWAKE:String = "keepAwake";
		private static const NORMAL:String = "normal";
		
		private var _app:NativeApplicationManager;
		private var _idleThreshold:int = 30 * 1000;
		private var _application:Application;
		private var _lastTouch:int;
		private var _lock:Boolean;
		
		public function IdleManager(stage:Stage, app:Application)
		{
			_application = app;
			_app = new NativeApplicationManager();
			
			_application.addEventListener(flash.events.Event.ACTIVATE, onActivate);
			stage.addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrameHandler);
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onPreloaderClose(e:Object):void 
		{
			lock = false;
		}
		
		private function onPreloaderOpen(e:Object):void 
		{
			lock = true;
		}
		
		private function onActivate(e:Object):void
		{
			setKeepAwake();
		}
		
		private function onTouch(e:TouchEvent):void
		{
			_lastTouch = getTimer();
		}
		
		private function onEnterFrameHandler(e:EnterFrameEvent):void
		{
			if (_application.active && isKeepAwake)
			{
				var now:int = getTimer();
				var diff:int = now - _lastTouch;
				if (diff > _idleThreshold && !lock)
				{
					setNormal();
				}
			}
		}
		
		private function setKeepAwake():void
		{
			if (!isKeepAwake)
			{
				_app.systemIdleMode = KEEP_AWAKE;
			}
		}
		
		private function setNormal():void
		{
			if (isKeepAwake)
			{
				_app.systemIdleMode = NORMAL;
			}
		}
		
		public function get isKeepAwake():Boolean
		{
			return _app.systemIdleMode == KEEP_AWAKE;
		}
		
		public function get lock():Boolean 
		{
			return _lock;
		}
		
		public function set lock(value:Boolean):void 
		{
			_lock = value;
			if (_lock && !isKeepAwake)
			{
				setKeepAwake();
			}
		}
	
	}

}