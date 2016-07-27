package game.modules.uifactory.factory.factories 
{
    import com.okapp.mvc.IContext;
    import game.modules.uifactory.factory.Element;
    import game.modules.uifactory.factory.ElementFactory;
    import common.injection.IInjector;
    import common.injection.Injector;
    import common.system.IDisposable;
	import common.system.TypeObject;
    import flash.utils.Dictionary;
	
	/**
     * ...
     * @author dorofiy.com
     */
    public class FactoryManager extends TypeObject implements IDisposable
    {
        private var _defaultFactory:IFactory;
        private var _factories:Dictionary;
        private var _injector:IInjector;
        private var _parent:ElementFactory;
        
        public function FactoryManager(injector:Injector, parent:ElementFactory) 
        {
            _parent = parent;
            _injector = injector;
            _factories = new Dictionary();
        }
        
        public function map(type:Class, factory:IFactory):void
        {
            _factories[type] = factory;
            _injector.inject(factory);
        }
        
        public function unmap(type:Class):void
        {
            delete _factories[type];
        }
        
        public function apply(element:Element):Object
        {
            if (element.classType)
            {
                var factory:IFactory = _factories[element.classType];
                var parentFactory:ElementFactory = _parent;
                while (factory == null && parentFactory)
                {
                    factory = parentFactory.factories._factories[element.classType];
                    parentFactory = parentFactory.parent;
                }
                if (factory)
                {
                    return factory.apply(element);
                }
            }
            return _defaultFactory.apply(element);
        }
        
        /* INTERFACE common.system.IDisposable */
        
        public function dispose():void 
        {
            
        }
        
        public function get defaultFactory():IFactory 
        {
            return _defaultFactory;
        }
        
        public function set defaultFactory(value:IFactory):void 
        {
            _defaultFactory = value;
        }
        
    }

}