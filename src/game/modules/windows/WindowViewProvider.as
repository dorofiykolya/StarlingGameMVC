package game.modules.windows 
{
	import common.injection.IInjector;
	import common.system.IDisposable;
	import mvc.mediators.IMediatorProvider;
	import starling.animation.Juggler;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class WindowViewProvider implements IMediatorProvider 
	{
		[Inject]
		public var injector:IInjector;
		[Inject]
		public var layers:WindowLayerMap;
		[Inject]
		public var juggler:Juggler;
		
		private var _windowMediator:WindowMediator;
		private var _viewClass:Class;
		private var _result:IWindowView;
		private var _windowType:WindowType;
		
		public function WindowViewProvider(windowType:WindowType, viewClass:Class) 
		{
			_windowType = windowType;
			_viewClass = viewClass;
		}
		
		/* INTERFACE mvc.mediators.IMediatorProvider */
		
		public function provide(mediator:Object, expected:Class):void 
		{
			_windowMediator = WindowMediator(mediator);
			_result = IWindowView(new _viewClass());
			_result.juggler = juggler;
			_windowMediator.mediate(_result);
		}
		
		public function unProvide():void 
		{
			if (_windowMediator != null)
			{
				_windowMediator.unmediate();
				var disposable:IDisposable = _result as IDisposable;
				if (disposable != null)
				{
					disposable.dispose();
				}
				_windowMediator = null;
				_result = null;
			}
		}
		
		public function dispose():void 
		{
			unProvide();
		}
		
	}

}