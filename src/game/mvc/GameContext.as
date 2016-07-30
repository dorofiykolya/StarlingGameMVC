package game.mvc
{
	import common.context.links.Link;
	import common.events.EventDispatcher;
	import common.events.IEventListener;
	import common.system.ClassType;
	import common.system.application.Application;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.setTimeout;
	import game.modules.applications.ApplicationManager;
	import game.modules.consoles.ConsoleExtension;
	import game.modules.formats.FormatsExtension;
	import game.modules.fullscreens.FullScreenManager;
	import game.modules.hotkey.HotKeyExtension;
	import game.modules.logs.LoggerExtension;
	import game.modules.storage.StorageManager;
	import game.mvc.configurations.OrientationConfiguration;
	import game.mvc.configurations.StageConfiguration;
	import game.mvc.configurations.StarlingConfiguration;
	import game.mvc.events.GameContextEvent;
	import game.mvc.extensions.FullscreenExtension;
	import game.mvc.extensions.StarlingExtension;
	import game.mvc.view.ILayers;
	import game.mvc.view.starling.StarlingLayers;
	import mvc.MVCContext;
	
	[Event(name = "stageReady", type = "game.mvc.events.GameContextEvent")]
	[Event(name = "preInitialize", type = "game.mvc.events.GameContextEvent")]
	[Event(name = "postInitialize", type = "game.mvc.events.GameContextEvent")]
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class GameContext extends MVCContext implements IEventListener
	{
		private var _app:Application;
		private var _rootClass:Class;
		private var _eventDispatcher:EventDispatcher;
		private var _stage:Stage;
		
		public function GameContext(app:Application, starlingRootClass:Class, configuration:ContextConfiguration = null)
		{
			_app = app;
			_rootClass = starlingRootClass;
			_eventDispatcher = new EventDispatcher();
			
			if (configuration == null) configuration = new ContextConfiguration();
			install(new Link(configuration, ContextConfiguration, "configuration"));
			
			var configurationType:Class = ClassType.getAsClass(configuration);
			if (configurationType != ContextConfiguration)
			{
				install(new Link(configuration, configurationType, String(configurationType)));
			}
			
			install(new Link(app, Application, "application"));
			install(new Link(this, GameContext, "gameContext"));
			install(new Link(StarlingLayers, ILayers));
			install(StageConfiguration);
			install(StorageManager);
			install(OrientationConfiguration);
			install(ApplicationManager);
			install(StarlingConfiguration);
			install(FullScreenManager);
			install(LoggerExtension);
			install(HotKeyExtension);
			install(ConsoleExtension);
			install(FormatsExtension);
			
			if (app.stage)
			{
				initializeStage();
				initializeContext();
			}
			else
			{
				app.addEventListener(Event.ADDED_TO_STAGE, toStage);
			}
		}
		
		/* INTERFACE common.events.IEventListener */
		
		public function addEventListener(type:Object, listener:Function):void
		{
			_eventDispatcher.addEventListener(type, listener);
		}
		
		public function removeEventListener(type:Object, listener:Function):void
		{
			_eventDispatcher.removeEventListener(type, listener);
		}
		
		public function removeEventListeners(type:Object = null):void
		{
			_eventDispatcher.removeEventListeners(type);
		}
		
		protected function get nativeStage():Stage
		{
			return _app.stage;
		}
		
		private function initializeStage():void
		{
			install(new Link(_app.stage, Stage, "nativeStage"));
			install(new FullscreenExtension(_app.stage));
			install(new StarlingExtension(_app.stage, _rootClass));
			
			_eventDispatcher.dispatchEventAs(GameContextEvent, GameContextEvent.STAGE_READY, false, this);
		}
		
		private function toStage(e:Event):void
		{
			_app.removeEventListener(Event.ADDED_TO_STAGE, toStage);
			initializeStage();
			initializeContext();
		}
		
		private function initializeContext():void
		{
			setTimeout(delayInitialize, 1);
		}
		
		private function delayInitialize():void
		{
			_eventDispatcher.dispatchEventAs(GameContextEvent, GameContextEvent.PRE_INITIALIZE, false, this);
			initialize();
			_eventDispatcher.dispatchEventAs(GameContextEvent, GameContextEvent.POST_INITIALIZE, false, this);
		}
	
	}

}