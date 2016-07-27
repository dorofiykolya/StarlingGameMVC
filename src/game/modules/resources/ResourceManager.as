package game.modules.resources
{
	import common.events.Event;
	import common.events.EventDispatcher;
	import common.events.IDispatcher;
	import common.system.ClassType;
	import common.system.Type;
	import common.system.reflection.Constant;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.ProgressEvent;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	import flash.system.System;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import game.modules.assets.IAssetsManager;
	import game.modules.preloaders.PreloaderManager;
	import starling.textures.TextureOptions;
	import starling.utils.AssetManager;
	
	[Event(name = "loaded", type = "game.modules.resources.ResourceEvent")]
	[Event(name = "complete", type = "game.modules.resources.ResourceEvent")]
	[Event(name = "progress", type = "game.modules.resources.ResourceEvent")]
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ResourceManager extends EventDispatcher
	{
		private static const NAME_REGEX:RegExp = /([^\?\/\\]+?)(?:\.([\w\-]+))?(?:\?.*)?$/;
		
		private var _dispatcher:IDispatcher;
		private var _assetLoader:AssetManager;
		private var _queue:Vector.<ResourceLink>;
		private var _progress:Number;
		private var _loaders:Vector.<Loader>;
		private var _loaderContext:LoaderContext;
		private var _total:int;
		private var _processed:int;
		private var _assetsManager:IAssetsManager;
		private var _preloaderManager:PreloaderManager;
		private var _mapScale:Dictionary;
		private var _current:ResourceLink;
		private var _isComplete:Boolean;
		
		public function ResourceManager(assetsManager:IAssetsManager, preloaderManager:PreloaderManager, dispatcher:IDispatcher)
		{
			_dispatcher = dispatcher;
			_preloaderManager = preloaderManager;
			_assetsManager = assetsManager;
			_assetLoader = new AssetManager();
			_assetLoader.numConnections = 100;
			
			_mapScale = new Dictionary();
			_loaders = new Vector.<Loader>();
			_loaderContext = new LoaderContext(false, null, null);
			_loaderContext.allowCodeImport = true;
		}
		
		private function createLoader():Loader
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoaderProgress);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete);
			_loaders.push(loader);
			return loader;
		}
		
		private function onLoaderComplete(e:flash.events.Event):void
		{
			var content:Object = LoaderInfo(e.currentTarget).content;
			loadFromClassEmbeds(ClassType.getAsClass(content), _current.scale);
			_processed++;
			loadNext();
		}
		
		private function loadFromClassEmbeds(clazz:Class, scale:Number = 1.0):void
		{
			var type:Type = ClassType.getClassType(clazz);
			var list:Vector.<Constant> = type.constants.sort(function(c1:Constant, c2:Constant):int
			{
				return c1.name > c2.name ? 1 : -1;
			});
			for each (var cnst:Constant in list)
			{
				_assetsManager.enqueueWithName(clazz[cnst.name], cnst.name, new TextureOptions(scale, false));
			}
		}
		
		private function clearLoaders():void
		{
			for each (var loader:Loader in _loaders)
			{
				loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onLoaderProgress);
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaderComplete);
				loader.unloadAndStop(false);
			}
			_loaders.length = 0;
			System.gc();
		}
		
		private function onLoaderProgress(e:ProgressEvent):void
		{
		
		}
		
		private function loadNext():void
		{
			if (_queue.length == 0)
			{
				_preloaderManager.show();
				_preloaderManager.setProgress(0.75);
				_assetsManager.loadQueue(onAssetProgress);
			}
			else
			{
				var current:ResourceLink = _queue.shift();
				var name:String = getName(current.link);
				var source:ByteArray = _assetLoader.getByteArray(name);
				_current = current;
				createLoader().loadBytes(source, _loaderContext);
				_assetLoader.removeByteArray(name, true);
			}
		}
		
		public function load(links:Vector.<ResourceLink>):void
		{
			_queue = links.slice();
			_total = _queue.length;
			for each (var link:ResourceLink in links)
			{
				_mapScale[getName(link.link)] = link.scale;
				_assetLoader.enqueue(new URLRequest(link.link));
			}
			_preloaderManager.show();
			_preloaderManager.setProgress(0.5);
			_assetLoader.loadQueue(onProgress);
		}
		
		private function onAssetProgress(ratio:Number):void
		{
			_preloaderManager.setProgress(0.75 + (ratio * 0.23));
			
			if (ratio >= 1.0)
			{
				clearLoaders();
				_isComplete = true;
				dispatchEventAs(ResourceEvent, ResourceEvent.COMPLETE, false, this);
				_dispatcher.dispatchEventAs(ResourceEvent, ResourceEvent.COMPLETE, false, this);
			}
		}
		
		private function onProgress(ratio:Number):void
		{
			_progress = ratio;
			
			_preloaderManager.setProgress(0.5 + (_progress * 0.25));
			
			dispatchEventAs(ResourceEvent, ResourceEvent.PROGRESS, false, this);
			
			if (_progress >= 1.0)
			{
				dispatchEventAs(ResourceEvent, ResourceEvent.LOADED, false, this);
				loadNext();
			}
		}
		
		protected function getBasenameFromUrl(url:String):String
		{
			var matches:Array = NAME_REGEX.exec(url);
			if (matches && matches.length > 0) return matches[1];
			else return null;
		}
		
		protected function getName(rawAsset:Object):String
		{
			var name:String;
			
			if (rawAsset is String) name = rawAsset as String;
			else if (rawAsset is URLRequest) name = (rawAsset as URLRequest).url;
			else if (rawAsset is FileReference) name = (rawAsset as FileReference).name;
			
			if (name)
			{
				name = name.replace(/%20/g, " "); // URLs use '%20' for spaces
				name = getBasenameFromUrl(name);
				
				if (name) return name;
				else throw new ArgumentError("Could not extract name from String '" + rawAsset + "'");
			}
			else
			{
				name = ClassType.getQualifiedClassName(rawAsset);
				throw new ArgumentError("Cannot extract names for objects of type '" + name + "'");
			}
		}
		
		public function get progress():Number
		{
			return _progress;
		}
		
		public function get isComplete():Boolean
		{
			return _isComplete;
		}
	
	}

}