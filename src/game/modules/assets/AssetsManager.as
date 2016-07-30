package game.modules.assets
{
	import common.events.EventDispatcher;
	import common.events.IEventDispatcher;
	import common.system.Environment;
	import common.system.text.StringUtil;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	import game.mvc.ContextConfiguration;
	import starling.events.Event;
	import starling.extensions.fonts.BinaryBitmapFont;
	import starling.extensions.textures.BinaryTextureAtlas;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.textures.TextureOptions;
	import starling.utils.AssetManager;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AssetsManager extends EventDispatcher implements IAssetsManager, IAssetProvider
	{
		private static const NAME_REGEX:RegExp = /([^\?\/\\]+?)(?:\.([\w\-]+))?(?:\?.*)?$/;
		
		[Inject]
		public var eventDispather:IEventDispatcher;
		[Inject]
		public var configuration:ContextConfiguration;
		
		private var _assetManager:AssetManager;
		
		public function AssetsManager()
		{
			_assetManager = new AssetManager();
			_assetManager.keepTextureAtlas = true;
			_assetManager.numConnections = 50;
			_assetManager.verbose = true;//Environment.isDebugger;
			_assetManager.addEventListener(Event.TEXTURES_RESTORED, onTextureRestored);
		}
		
		private function onTextureRestored(e:Event):void
		{
			eventDispather.dispatchEventWith(e.type);
		}
		
		public function addAsset(id:String, provider:AssetProvider):void
		{
			_assetManager.enqueueWithName(provider.getValue(), id, provider.getOptions());
		}
		
		/* DELEGATE starling.utils.AssetManager */
		
		public function addTextureAtlas(name:String, atlas:TextureAtlas):void
		{
			_assetManager.addTextureAtlas(name, atlas);
		}
		
		public function enqueue(... rawAssets):void
		{
			_assetManager.enqueue.apply(null, [].concat(rawAssets));
		}
		
		public function getTexture(name:String):Texture
		{
			return _assetManager.getTexture(name);
		}
		
		public function getTextureAtlas(name:String):TextureAtlas
		{
			return _assetManager.getTextureAtlas(name);
		}
		
		public function getTextureNames(prefix:String = "", result:Vector.<String> = null):Vector.<String>
		{
			return _assetManager.getTextureNames(prefix, result);
		}
		
		public function getTextures(prefix:String = "", result:Vector.<Texture> = null):Vector.<Texture>
		{
			return _assetManager.getTextures(prefix, result);
		}
		
		/* DELEGATE starling.utils.AssetManager */
		
		public function loadQueue(onProgress:Function):void
		{
			_assetManager.loadQueue(function(ratio:Number):void
			{
				if (ratio == 1.0)
				{
					processBinaries();
					setTimeout(onProgress, 1, 1.0);
				}
				else
				{
					onProgress(ratio);
				}
			});
		}
		
		/* INTERFACE game.modules.assets.IAssetsManager */
		
		public function addTexture(name:String, texture:Texture):void
		{
			_assetManager.addTexture(name, texture);
		}
		
		/* INTERFACE game.modules.assets.IAssetsManager */
		
		public function enqueueWithName(asset:Object, name:String = null, options:TextureOptions = null):String
		{
			return _assetManager.enqueueWithName(asset, name, options);
		}
		
		/* INTERFACE game.modules.assets.IAssetProvider */
		
		public function getObject(name:String):Object
		{
			return _assetManager.getObject(name);
		}
		
		public function getXml(name:String):XML
		{
			return _assetManager.getXml(name);
		}
		
		public function getSound(name:String):Sound
		{
			return _assetManager.getSound(name);
		}
		
		public function getByteArray(name:String):ByteArray
		{
			return _assetManager.getByteArray(name);
		}
		
		public function get isLoading():Boolean
		{
			return _assetManager.isLoading;
		}
		
		public function getAssetsFilePath(fileName:String):String
		{
			var left:Boolean = (StringUtil.endsWith(assetsPath, "/") || StringUtil.endsWith(assetsPath, "\\"));
			var right:Boolean = (StringUtil.startsWith(fileName, "/") || StringUtil.startsWith(fileName, "\\"));
			
			if (left && right)
			{
				return assetsPath + StringUtil.removeLeftChars(fileName, 1);
			}
			else if (!left && !right)
			{
				return assetsPath + "/" + fileName;
			}
			
			return assetsPath + fileName;
		}
		
		public function get soundsPath():String
		{
			if (Environment.isMobile)
			{
				return configuration.mobileSoundsPath;
			}
			return configuration.browserSoundsPath;
		}
		
		public function getSoundsFilePath(fileName:String):String
		{
			var left:Boolean = (StringUtil.endsWith(soundsPath, "/") || StringUtil.endsWith(soundsPath, "\\"));
			var right:Boolean = (StringUtil.startsWith(fileName, "/") || StringUtil.startsWith(fileName, "\\"));
			
			if (left && right)
			{
				return soundsPath + StringUtil.removeLeftChars(fileName, 1);
			}
			else if (!left && !right)
			{
				return soundsPath + "/" + fileName;
			}
			
			return soundsPath + fileName;
		}
		
		public function get assetsPath():String
		{
			if (Environment.isMobile)
			{
				return configuration.mobileAssetsPath;
			}
			return configuration.browserAssetsPath;
		}
		
		protected function processBinaries():void
		{
			var names:Vector.<String> = _assetManager.getByteArrayNames();
			for each (var name:String in names)
			{
				var item:ByteArray = getByteArray(name);
				//var now:int = getTimer();
				var textureName:String;
				if (BinaryTextureAtlas.isBinaryTextureAtlas(item))
				{
					textureName = getName(BinaryTextureAtlas.getTexturePath(item));
					if (!getTextureAtlas(textureName))
					{
						addTextureAtlas(textureName, new BinaryTextureAtlas(getTexture(textureName), item));
						//trace("TIME ATLAS: " + textureName + ":" + (getTimer() - now));
					}
				}
				else if (BinaryBitmapFont.isBinaryBitmapFont(item))
				{
					textureName = getName(BinaryBitmapFont.getTexturePath(item));
					if (!TextField.getBitmapFont(BinaryBitmapFont.getFontName(item)))
					{
						TextField.registerBitmapFont(new BinaryBitmapFont(getTexture(textureName), item), BinaryBitmapFont.getFontName(item));
						//trace("TIME FONT: " + textureName + ":" + (getTimer() - now));
					}
				}
			}
		}
		
		protected function getName(path:String):String
		{
			path = path.replace(/%20/g, " "); // URLs use '%20' for spaces
			path = getBasenameFromUrl(path);
			
			if (path) return path;
			else throw new ArgumentError("Could not extract path from String '" + path + "'");
		}
		
		protected function getBasenameFromUrl(url:String):String
		{
			var matches:Array = NAME_REGEX.exec(url);
			if (matches && matches.length > 0) return matches[1];
			else return null;
		}
	}

}