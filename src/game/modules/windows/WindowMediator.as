package game.modules.windows
{
	import common.events.EventDispatcher;
	import common.injection.IInjector;
	import game.modules.assets.ITextureProvider;
	import game.modules.localizations.LocalizationManager;
	import game.modules.sounds.Channel;
	import game.modules.sounds.SoundManager;
	import game.modules.uibuilder.IUIBuilderFactory;
	import game.mvc.view.ILayer;
	import game.mvc.view.controllers.TouchController;
	import game.mvc.view.controllers.TouchControllerEvent;
	import mvc.mediators.IMediator;
	import starling.animation.Juggler;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.extensions.utils.DisplayListUtils;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class WindowMediator extends EventDispatcher implements IMediator
	{
		public static var defaultOpenSoundId:String;
		public static var defaultCloseSoundId:String;
		
		[Inject]
		public var localizeProvider:LocalizationManager;
		[Inject]
		public var uiBuilder:IUIBuilderFactory;
		[Inject]
		public var textureProvider:ITextureProvider;
		[Inject]
		public var juggler:Juggler;
		[Inject]
		public var injector:IInjector;
		[Inject]
		public var windowsManager:WindowsManager;
		[Inject]
		public var soundManager:SoundManager;
		
		private var _view:IWindowView;
		private var _layer:ILayer;
		private var _content:Sprite;
		private var _background:DisplayObject;
		private var _closeButton:DisplayObject;
		private var _data:WindowData;
		private var _closed:Boolean;
		private var _id:WindowId;
		private var _closeByBackground:Boolean;
		private var _openSoundId:String;
		private var _closeSoundId:String;
		private var _windowType:WindowType;
		
		public function WindowMediator()
		{
			_closeByBackground = true;
			_closed = true;
			_openSoundId = defaultOpenSoundId;
			_closeSoundId = defaultCloseSoundId;
		}
		
		public function get id():WindowId
		{
			return _id;
		}
		
		internal function initialization(id:WindowId, layer:ILayer, data:WindowData, windowType:WindowType):void
		{
			_windowType = windowType;
			_id = id;
			_layer = layer;
			_data = data;
		}
		
		protected function onOpenPlaySound():void
		{
			soundManager.getChannel(Channel.FX).play(_openSoundId);
		}
		
		protected function onClosePlaySound():void
		{
			soundManager.getChannel(Channel.FX).play(_closeSoundId);
		}
		
		protected function onOpen():void
		{
		
		}
		
		protected function onClose():void
		{
		
		}
		
		protected function onMediate():void
		{
		
		}
		
		public function get data():WindowData
		{
			return _data;
		}
		
		public function close():void
		{
			windowsManager.close(id);
		}
		
		public function back():void
		{
			windowsManager.back(id);
		}
		
		internal function closeView():void
		{
			if (!_closed)
			{
				onClose();
				onClosePlaySound();
				_layer.remove(view);
				_closed = true;
			}
		}
		
		public function get closed():Boolean
		{
			return _closed;
		}
		
		internal function openView():void
		{
			if (_closed)
			{
				onOpen();
				onOpenPlaySound();
				_layer.add(view);
				_closed = false;
			}
		}
		
		/* INTERFACE mvc.mediators.IMediator */
		
		public function mediate(target:Object):void
		{
			_view = IWindowView(target);
			onMediate();
		}
		
		public function unmediate():void
		{
		
		}
		
		public function get view():IWindowView
		{
			return _view;
		}
		
		public function get content():Sprite
		{
			return _content;
		}
		
		public function set content(value:Sprite):void
		{
			if (value != null)
			{
				_content = value;
				view.content = value;
			}
		}
		
		public function get background():DisplayObject
		{
			return _background;
		}
		
		public function set background(value:DisplayObject):void
		{
			if (value != null)
			{
				_background = value;
				view.background = _background;
				new TouchController(_background).addEventListener(TouchControllerEvent.CLICK, onClickClose);
			}
		}
		
		public function get closeButton():DisplayObject
		{
			return _closeButton;
		}
		
		public function set closeButton(value:DisplayObject):void
		{
			_closeButton = value;
			new TouchController(_closeButton, true).addEventListener(TouchControllerEvent.CLICK_WITHOUT_DRAG, onClickClose);
		}
		
		public function get closeByBackground():Boolean
		{
			return _closeByBackground;
		}
		
		public function set closeByBackground(value:Boolean):void
		{
			_closeByBackground = value;
		}
		
		protected function get openSoundId():String
		{
			return _openSoundId;
		}
		
		protected function set openSoundId(value:String):void
		{
			_openSoundId = value;
		}
		
		protected function get closeSoundId():String
		{
			return _closeSoundId;
		}
		
		protected function set closeSoundId(value:String):void
		{
			_closeSoundId = value;
		}
		
		public function get windowType():WindowType
		{
			return _windowType;
		}
		
		protected function createBackground(layout:Object, ... path):void
		{
			var sprite:Sprite = createByLayout(layout);
			var result:DisplayObject = sprite;
			if (path.length != 0)
			{
				result = DisplayListUtils.getByNamePath(sprite, path);
			}
			background = result;
		}
		
		protected function createContent(layout:Object):void
		{
			content = createByLayout(layout);
		}
		
		public function localize(key:String):String
		{
			return localizeProvider.localize(key);
		}
		
		public function createByLayout(layout:Object):Sprite
		{
			return uiBuilder.createByLayout(layout);
		}
		
		public function getContentElement(... path):DisplayObject
		{
			return DisplayListUtils.getByNamePath(content, path);
		}
		
		public function getTextField(... path):TextField
		{
			return TextField(DisplayListUtils.getByNamePath(content, path));
		}
		
		public function getTexture(name:String):Texture
		{
			return textureProvider.getTexture(name);
		}
		
		private function onClickClose(e:TouchControllerEvent):void
		{
			if (_closeByBackground)
			{
				back();
			}
		}
	}

}