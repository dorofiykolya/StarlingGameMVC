package game.modules.consoles
{
	import com.junkbyte.console.Cc;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.system.System;
	import game.modules.logs.ILogger;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ConsoleManager
	{
		private var _opened:Boolean;
		private var _starling:Starling;
		private var _stage:Stage;
		private var _logger:ILogger;
		
		public function ConsoleManager(nativaStage:Stage, starling:Starling, logger:ILogger)
		{
			_logger = logger;
			_starling = starling;
			_stage = nativaStage;
			Cc.start(null);
		}
		
		public function open():void
		{
			initialize();
			if (Cc.instance)
			{
				_stage.frameRate = 60;
				_stage.addChild(Cc.instance);
				//_stage.focus = Cc.instance.panels.mainPanel.textField;
				Cc.instance.width = _stage.stageWidth;
				Cc.instance.height = _stage.stageHeight;
				_starling.stage.touchable = false;
			}
			_opened = true;
		}
		
		public function close():void
		{
			if (Cc.instance)
			{
				if (Cc.instance.stage)
				{
					Cc.instance.parent.removeChild(Cc.instance);
					_starling.stage.touchable = true;
				}
			}
			_opened = false;
		}
		
		public function get opened():Boolean
		{
			return _opened;
		}
		
		private function initialize():void
		{
			try
			{
				if (Cc.instance)
				{
					return;
				}
				Cc.commandLine = true;
				Cc.config.alwaysOnTop = true;
				Cc.config.style.big();
				Cc.config.commandLineAllowed = true;
				Cc.config.commandLineAutoCompleteEnabled = true;
				Cc.config.commandLineAutoScope = true;
				Cc.config.showLineNumber = true;
				Cc.config.showTimestamp = true;
				Cc.start(_stage, "");
				Cc.instance.addEventListener(Event.ADDED_TO_STAGE, function(e:Event):void
				{
					//_stage.focus = Cc.instance.panels.mainPanel.textField;
					Cc.commandLine = true;
					_starling.stage.touchable = false;
				});
				Cc.visible = true;
				Cc.commandLine = true;
				Cc.instance.panels.mainPanel.moveable = false;
				Cc.instance.panels.mainPanel.scalable = false;
				Cc.addSlashCommand("/gc", System.gc);
				Cc.instance.width = _stage.stageWidth;
				Cc.instance.height = _stage.stageHeight;
				//_stage.focus = Cc.instance.panels.mainPanel.textField;
				Cc.commandLine = true;
				_starling.stage.touchable = false;
				_stage.frameRate = 60;
			}
			catch (error:Error)
			{
				_logger.error("[ConsoleManager][consoleShowHide] " + error.message, error);
			}
		}
	
	}

}