package game.modules.resources
{
	import common.events.Event;
	import common.events.EventDispatcher;
	import common.system.ClassType;
	import common.system.text.StringUtil;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	import game.modules.assets.IAssetsManager;
	import game.modules.logs.ILogger;
	import starling.textures.TextureOptions;
	
	[Event(name = "complete", type = "common.events.Event")]
	/**
	 * ...
	 * @author ...
	 */
	public class LocalDataLoaderManager extends EventDispatcher
	{
		private var _assets:IAssetsManager;
		private var _loader:URLLoader;
		private var _logger:ILogger;
		private var _queue:Vector.<String>;
		private var _current:URLRequest;
		private var _results:Vector.<FileInfo>;
		private var _completed:Boolean;
		
		public function LocalDataLoaderManager(assets:IAssetsManager, logger:ILogger)
		{
			_logger = logger;
			_assets = assets;
			_queue = new <String>["data.xml"];
			_results = new Vector.<FileInfo>();
			
			_loader = new URLLoader();
			_loader.dataFormat = URLLoaderDataFormat.TEXT;
			_loader.addEventListener(flash.events.Event.COMPLETE, onComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loadNext();
		}
		
		private function loadNext():void
		{
			if (_queue.length != 0)
			{
				_current = new URLRequest(_queue.shift());
				try
				{
					_loader.load(_current);
					_logger.note("debug file load: " + _current.url);
				}
				catch (e:Error)
				{
					_logger.error("debug file error: " + _current.url, e);
					_completed = true;
					dispatchEventWith(common.events.Event.COMPLETE);
					removeEventListeners();
				}
			}
			else
			{
				process();
				_completed = true;
				dispatchEventWith(common.events.Event.COMPLETE);
				removeEventListeners();
			}
		}
		
		private function onIOError(e:IOErrorEvent):void
		{
			_logger.note("debug file ioError: " + _current.url + ", " + e.text);
			loadNext();
		}
		
		private function process():void
		{
			for each (var info:FileInfo in _results)
			{
				_assets.enqueueWithName(new URLRequest(info.url), null, new TextureOptions(info.scale, false, "bgra", info.repeat));
			}
		}
		
		private function onComplete(e:Object = null):void
		{
			_logger.note("debug file loaded: " + _current.url);
			
			var xml:XML = XML(_loader.data);
			for each (var file:XML in xml.file)
			{
				var url:String = String(file);
				if (!StringUtil.isEmpty(url))
				{
					_results.push(new FileInfo(url, Number(ClassType.cast(file.@scale, Number)), Boolean(ClassType.cast(String(file.@repeat), Boolean))));
				}
			}
			
			for each (var data:XML in xml.data)
			{
				if (!StringUtil.isEmpty(String(data)))
				{
					_queue.push(String(data));
				}
			}
			
			loadNext();
		}
		
		public function get completed():Boolean 
		{
			return _completed;
		}
	}
}

class FileInfo
{
	public var url:String;
	public var scale:Number;
	public var repeat:Boolean;
	
	public function FileInfo(url:String, scale:Number, repeat:Boolean)
	{
		this.url = url;
		this.scale = scale;
		this.repeat = repeat;
		
		if (scale <= 0 || isNaN(scale))
		{
			this.scale = 1.0;
		}
	}
}