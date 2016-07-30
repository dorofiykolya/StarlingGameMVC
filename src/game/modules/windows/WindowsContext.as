package game.modules.windows 
{
	import common.context.Context;
	import common.context.IContext;
	import common.injection.IInjector;
	import mvc.mediators.IMediatorContext;
	import mvc.mediators.MediatorContext;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class WindowsContext implements IContext
	{
		private var _context:Context;
		private var _parent:IContext;
		private var _mediatorContext:MediatorContext;
		
		public function WindowsContext(parent:IContext) 
		{
			_context = new Context(parent);
			_parent = parent;
			_mediatorContext = new MediatorContext(this);
			injector.map(IMediatorContext).toValue(_mediatorContext);
		}
		
		public function get mediator():IMediatorContext
		{
			return _mediatorContext;
		}
		
		public function getObject(type:Class, name:String = null):Object 
		{
			return _context.getObject(type, name);
		}
		
		public function install(...extensions):IContext 
		{
			_context.install.apply(null, extensions);
			return this;
		}
		
		public function get injector():IInjector 
		{
			return _context.injector;
		}
		
		public function get parent():IContext 
		{
			return _parent;
		}
		
		public function initialize():void
		{
			_context.initialize();
		}
		
	}

}