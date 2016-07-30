package game.mvc.view
{
	import common.context.IContext;
	import common.context.links.Link;
	import common.events.EventDispatcher;
	import common.events.IEventListener;
	import common.injection.IInjector;
	import common.injection.Injector;
	import mvc.MVCContext;
	import mvc.mediators.IMediator;
	import mvc.mediators.IMediatorContext;
	import mvc.mediators.MediatorContext;
	import starling.animation.Juggler;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ViewContext extends MVCContext implements IEventListener
	{
		private var _mediatorContext:IMediatorContext;
		private var _uiJuggler:Juggler;
		private var _contextEventDispatcher:EventDispatcher;
		
		public function ViewContext(parent:IContext)
		{
			super(parent);
			
			parent.injector.map(ViewContext).toValue(this);
			
			_contextEventDispatcher = new EventDispatcher();
			
			_mediatorContext = new MediatorContext(this);
			injector.map(IMediatorContext).toValue(_mediatorContext);
			
			injector.map(IInjector).toValue(_mediatorContext.injector);
			injector.map(Injector).toValue(_mediatorContext.injector);
			
			_uiJuggler = new Juggler();
			install(new Link(_uiJuggler, Juggler, "juggler"));
		
		}
		
		public function load(type:Class):IMediator
		{
			return _mediatorContext.getObject(type) as IMediator;
		}
		
		public function unload(type:Class):void
		{
			_mediatorContext.unmap(type);
		}
		
		public function get mediatorContext():IMediatorContext
		{
			return _mediatorContext;
		}
		
		/* INTERFACE common.events.IEventListener */
		
		public function addEventListener(type:Object, listener:Function):void
		{
			_contextEventDispatcher.addEventListener(type, listener);
		}
		
		public function removeEventListener(type:Object, listener:Function):void
		{
			_contextEventDispatcher.removeEventListener(type, listener);
		}
		
		public function removeEventListeners(type:Object = null):void
		{
			_contextEventDispatcher.removeEventListeners(type);
		}
	
	}

}