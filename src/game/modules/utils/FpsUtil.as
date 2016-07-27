package game.modules.utils
{
	import flash.display.Stage;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import game.configurations.Configuration;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class FpsUtil
	{
		private var _minFps:int;
		private var _maxFps:int;
		private var _timer:Timer;
		private var _nativeStage:Stage;
		
		public function FpsUtil(configuration:Configuration, nativeStage:Stage)
		{
			_nativeStage = nativeStage;
			_timer = new Timer(100, 5);
			_minFps = configuration.sleepFps;
			_maxFps = configuration.fps;
		}
		
		public function start():void
		{
			if (!_timer.hasEventListener(TimerEvent.TIMER))
			{
				_timer.addEventListener(TimerEvent.TIMER, onTimer);
				_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			}
			_timer.reset();
			_timer.start();
		}
		
		private function onTimerComplete(e:TimerEvent):void
		{
			stop();
		}
		
		private function onTimer(e:TimerEvent):void
		{
			if (_nativeStage.frameRate == _minFps)
			{
				_nativeStage.frameRate = _maxFps;
			}
			else
			{
				_nativeStage.frameRate = _minFps;
			}
		}
		
		public function get minFrameRate():int
		{
			return _minFps;
		}
		
		public function set minFrameRate(value:int):void
		{
			if (value <= 0)
			{
				value = 4;
			}
			_minFps = value;
		}
		
		public function get maxFrameRate():int
		{
			return _maxFps;
		}
		
		public function set maxFrameRate(value:int):void
		{
			if (value <= 0)
			{
				value = 25;
			}
			_maxFps = value;
		}
		
		public function stop():void
		{
			_timer.stop();
			_nativeStage.frameRate = _maxFps;
		}
	
	}

}