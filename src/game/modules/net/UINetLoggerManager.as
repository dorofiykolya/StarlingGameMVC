package game.modules.net
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import game.modules.logs.ILogger;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UINetLoggerManager
	{
		[Embed(source = "../../../embeds/logger/net_logger.swf", mimeType = "application/octet-stream")]
		private static const UI_NET_LOGGER:Class;
		
		private var _stage:Stage;
		private var _starling:Starling;
		private var _opened:Boolean;
		private var _isLoaded:Boolean;
		private var _content:Sprite;
		private var _loadStarted:Boolean;
		private var _logger:ILogger;
		private var _loader:Loader;
		
		public function UINetLoggerManager(nativeStage:Stage, starling:Starling, logger:ILogger)
		{
			_logger = logger;
			_stage = nativeStage;
			_starling = starling;
		}
		
		public function get opened():Boolean
		{
			return _opened;
		}
		
		public function open():void
		{
			if (_opened)
			{
				return;
			}
			_opened = true;
			_starling.stage.touchable = false;
			if (!_isLoaded)
			{
				startLoad();
			}
			else
			{
				_stage.addChild(_content);
			}
		}
		
		public function close():void
		{
			if (!_opened)
			{
				return;
			}
			_opened = false;
			_starling.stage.touchable = true;
			if (_isLoaded)
			{
				var parent:DisplayObjectContainer = _content.parent;
				if (parent)
				{
					parent.removeChild(_content);
				}
			}
		}
		
		private function startLoad():void
		{
			if (_loadStarted)
			{
				return;
			}
			_loadStarted = true;
			var context:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			context.allowCodeImport = true;
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete);
			_loader.loadBytes(new UI_NET_LOGGER, context);
		}
		
		private function onLoaderComplete(e:Event):void
		{
			try 
			{
				_content = _loader.content as Sprite;
				if (_opened)
				{
					_stage.addChild(_content);
				}
				_isLoaded = true;
			}
			catch (error:Error)
			{
				_logger.error(error.message, error);
			}
		}
	
	}

}