package game.modules.sounds
{
	import game.modules.logs.ILogger;
	import common.injection.IInjector;
	import flash.utils.Dictionary;
	import game.modules.assets.IAssetProvider;
	import treefortress.sound.SoundAS;
	import treefortress.sound.SoundManager;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class SoundChannel
	{
		internal var internalManager:game.modules.sounds.SoundManager;
		private var _globalMute:Boolean;
		private var _controllers:Dictionary;
		private var _injector:IInjector;
		private var _channel:Channel;
		private var _assetProvider:IAssetProvider;
		private var _logger:ILogger;
		private var _impl:treefortress.sound.SoundManager;
		
		public function SoundChannel(injector:IInjector, channel:Channel, assetProvider:IAssetProvider, logger:ILogger, impl:treefortress.sound.SoundManager)
		{
			_impl = impl;
			_logger = logger;
			_assetProvider = assetProvider;
			_channel = channel;
			_injector = injector;
			_controllers = new Dictionary();
		}
		
		public function getBy(id:String):SoundController
		{
			var result:SoundController = _controllers[id];
			if (result == null)
			{
				result = new SoundController(_channel, id, _assetProvider, _logger, _impl);
				_injector.inject(result);
				result.internalChannel = this;
				_controllers[id] = result;
			}
			return result;
		}
		
		public function play(id:String):SoundController
		{
			_logger.note("[game.modules.sounds.SoundChannel][play] " + id);
			if (_channel.oneInstance)
			{
				internalFadeOut(id);
			}
			return getBy(id).play();
		}
		
		public function playLoop(id:String):SoundController
		{
			_logger.note("[game.modules.sounds.SoundChannel][playLoop] " + id);
			if (_channel.oneInstance)
			{
				internalFadeOut(id);
			}
			return getBy(id).playLoop();
		}
		
		public function stop(id:String):SoundController
		{
			return getBy(id).stop();
		}
		
		public function get mute():Boolean
		{
			return _impl.group(String(_channel.value)).mute;
		}
		
		public function set mute(value:Boolean):void
		{
			_impl.group(String(_channel.value)).mute = value;
		}
		
		public function fadeOut():SoundChannel
		{
			internalFadeOut(null);
			
			return this;
		}
		
		private function internalFadeOut(exclude:String):void
		{
			for each (var item:SoundController in _controllers)
			{
				if(exclude == null || item.id != exclude)
				{
					item.fadeOut();
				}
			}
		}
	
	}

}