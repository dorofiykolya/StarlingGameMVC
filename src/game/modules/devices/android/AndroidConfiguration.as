package game.modules.devices.android 
{
	import common.context.IContext;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import game.GameApplication;
	import game.configurations.Configuration;
	import game.modules.applications.NativeApplicationManager;
	import game.modules.logs.ILogger;
	import game.modules.net.ISocketConnection;
	import game.modules.utils.FpsUtil;
	import mvc.configurations.IConfigurable;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AndroidConfiguration implements IConfigurable 
	{
		[Inject]
		public var configuration:Configuration;
		[Inject]
		public var nativeStage:Stage;
		[Inject]
		public var gameApp:GameApplication;
		[Inject]
		public var logger:ILogger;
		[Inject]
		public var connection:ISocketConnection;
		[Inject]
		public var fpsUtil:FpsUtil;
		
		private var _exitTimer:Timer;
		private var _nativeApp:NativeApplicationManager;
		
		public function AndroidConfiguration() 
		{
			
		}
		
		
		/* INTERFACE mvc.configurations.IConfigurable */
		
		public function config(context:IContext):void 
		{
			_exitTimer = new Timer(configuration.exitTime * 1000, 1);
			_nativeApp = new NativeApplicationManager();
			
			nativeStage.addEventListener(Event.ACTIVATE, onActivateHandler);
			nativeStage.addEventListener(Event.DEACTIVATE, onDeactivateHandler);
		}
		
		private function onExitTimerComplete(e:TimerEvent = null):void
		{
			_exitTimer.stop();
			if (!gameApp.active)
			{
				try
				{
					sleep();
				}
				catch (error:Error)
				{
					logger.error("[game.modules.devices.android.AndroidConfiguration][onExitTimerComplete]", error);
				}
				exit();
			}
		}
		
		private function exit():void 
		{
			_nativeApp.exit();
		}
		
		private function sleep():void 
		{
			nativeStage.frameRate = configuration.sleepFps;
			connection.close();
		}
		
		private function unsleep():void
		{
			nativeStage.frameRate = configuration.fps;
			connection.reconnect();
		}
		
		private function onDeactivateHandler(e:Event):void 
		{
			if (!configuration.ignoreExit)
			{
				_exitTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onExitTimerComplete);
				_exitTimer.reset();
				_exitTimer.start();
			}
		}
		
		private function onActivateHandler(e:Event):void 
		{
			_exitTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onExitTimerComplete);
			_exitTimer.reset();
			_exitTimer.stop();
			configuration.ignoreExit = false;
			unsleep();
			fpsUtil.start();
		}
		
	}

}