package game.modules.sounds
{
	import common.events.EventDispatcher;
	import flash.media.Sound;
	import game.modules.assets.IAssetProvider;
	import game.modules.logs.ILogger;
	import treefortress.sound.SoundAS;
	import treefortress.sound.SoundInstance;
	import treefortress.sound.SoundManager;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class SoundController extends EventDispatcher
	{
		internal var internalChannel:game.modules.sounds.SoundChannel;
		private var _logger:ILogger;
		private var _assetProvider:IAssetProvider;
		private var _id:String;
		private var _channel:Channel;
		private var _impl:treefortress.sound.SoundManager;
		private var _sound:SoundInstance;
		private var _queue:Vector.<String>;
		
		public function SoundController(channel:Channel, id:String, assetProvider:IAssetProvider, logger:ILogger, impl:treefortress.sound.SoundManager)
		{
			super();
			_impl = impl;
			_assetProvider = assetProvider;
			_logger = logger;
			_channel = channel;
			_id = id;
			_queue = new Vector.<String>();
		}
		
		private function checkSound():void
		{
			var sound:Sound = _assetProvider.getSound(_id);
			if (sound)
			{
				currentImpl.addSound(_id, sound);
			}
			else
			{
				currentImpl.loadSound(_assetProvider.getSoundsFilePath(_id), _id);
			}
		}
		
		private function onComplete(instance:SoundInstance):void
		{
			if (_queue.length != 0)
			{
				internalChannel.play(_queue.shift());
			}
		}
		
		public function enqueue(id:String):SoundController
		{
			_queue.push(id);
			return this;
		}
		
		public function play():SoundController
		{
			try
			{
				checkSound();
				_sound = currentImpl.play(_id);
				_sound.soundCompleted.add(onComplete);
				if (_channel.oneInstance)
				{
					_sound.fadeFrom(0, 1);
				}
			}
			catch (e:Error)
			{
				_logger.error("[SoundController][play] invalid sound id: " + _id, e);
			}
			return this;
		}
		
		public function playLoop():SoundController
		{
			try
			{
				checkSound();
				_sound = currentImpl.playLoop(_id);
				if (_channel.oneInstance)
				{
					_sound.fadeFrom(0, 1);
				}
			}
			catch (e:Error)
			{
				_logger.error("[SoundController][playLoop] invalid sound id: " + _id, e);
			}
			return this;
		}
		
		public function fadeOut():void
		{
			if (_sound)
			{
				_sound.fadeTo(0);
			}
		}
		
		public function stop():SoundController
		{
			if (_sound)
			{
				_sound.stop();
			}
			_queue.length = 0;
			return this;
		}
		
		public function get id():String
		{
			return _id;
		}
		
		private function get currentImpl():treefortress.sound.SoundManager
		{
			return _impl.group(String(_channel.value));
		}
	
	}

}