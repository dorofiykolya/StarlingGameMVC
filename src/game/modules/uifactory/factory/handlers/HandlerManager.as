package game.modules.uifactory.factory.handlers 
{
    import com.okapp.mvc.IContext;
    import game.modules.uifactory.factory.Element;
    import game.modules.uifactory.factory.ElementFactory;
    import common.injection.IInjector;
    import common.injection.Injector;
    import flash.utils.Dictionary;
	/**
     * ...
     * @author dorofiy.com
     */
    public class HandlerManager 
    {
        private var _injector:IInjector;
        private var _handler:Dictionary;
        private var _parent:ElementFactory;
        
        public function HandlerManager(injector:Injector, parent:ElementFactory) 
        {
            _parent = parent;
            _injector = injector;
            _handler = new Dictionary();
        }
        
        public function map(name:String, handler:IHandler):void
        {
            _handler[name] = handler;
            _injector.inject(handler);
        }
        
        public function getHandler(name:String):IHandler
        {
            return _handler[name];
        }
        
        public function apply(element:Element, target:Object):Boolean
        {
            var handler:IHandler = _handler[element.name];
            var parentFactory:ElementFactory = _parent;
            while (handler == null && parentFactory)
            {
                handler = parentFactory.handlers._handler[element.name];
                parentFactory = parentFactory.parent;
            }
            if (handler)
            {
                handler.apply(element, target);
                return true;
            }
            return false;
        }
        
    }

}