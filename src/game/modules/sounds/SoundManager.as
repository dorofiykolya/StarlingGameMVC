package game.modules.sounds
{
	import common.events.EventDispatcher;
	import common.injection.IInjector;
	import common.system.Environment;
	import common.system.application.Application;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	import game.modules.assets.IAssetProvider;
	import game.modules.logs.ILogger;
	import treefortress.sound.SoundAS;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class SoundManager extends EventDispatcher
	{
		private var _channels:Dictionary;
		private var _injector:IInjector;
		private var _assetProvider:IAssetProvider;
		private var _logger:ILogger;
		private var _impl:treefortress.sound.SoundManager;
		private var _application:Application;
		private var _mute:Boolean;
		
		public function SoundManager(injector:IInjector, assetProvider:IAssetProvider, logger:ILogger, application:Application, nativeStage:Stage)
		{
			_application = application;
			_logger = logger;
			_assetProvider = assetProvider;
			_injector = injector;
			_channels = new Dictionary();
			_impl = new treefortress.sound.SoundManager();
			_mute = _impl.mute;
			
			nativeStage.addEventListener(Event.ACTIVATE, onApplicationActiveHandler);
			nativeStage.addEventListener(Event.DEACTIVATE, onApplicationDeactiveHandler);
			
			updateSoundByActive();
			
			if (Environment.isMobile)
			{
				try
				{
					if (Object(SoundMixer).hasOwnProperty("audioPlaybackMode"))
					{
						SoundMixer["audioPlaybackMode"] = "ambient";
					}
				}
				catch (e:Error)
				{
					
				}
			}
		}
		
		private function onApplicationDeactiveHandler(e:Event):void 
		{
			updateSoundByActive();
		}
		
		private function onApplicationActiveHandler(e:Event):void 
		{
			updateSoundByActive();
		}
		
		private function updateSoundByActive():void
		{
			if (_application.active)
			{
				SoundMixer.soundTransform = new SoundTransform(1);
			}
			else
			{
				SoundMixer.soundTransform = new SoundTransform(0);
			}
		}
		
		public function getChannel(channel:Channel):SoundChannel
		{
			if (!(channel in _channels))
			{
				var current:SoundChannel = new SoundChannel(_injector, channel, _assetProvider, _logger, _impl);
				current.internalManager = this;
				_injector.inject(current);
				_channels[channel] = current;
			}
			return _channels[channel];
		}
		
		public function get mute():Boolean
		{
			return _mute;
		}
		
		public function set mute(value:Boolean):void
		{
			_mute = value;
			_impl.mute = value;
		}
	
	}

}