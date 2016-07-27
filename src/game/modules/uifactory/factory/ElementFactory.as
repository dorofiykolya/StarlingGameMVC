package game.modules.uifactory.factory
{
    import com.okapp.mvc.IContext;
	import common.context.IContext;
    import game.modules.uifactory.factory.converter.PropertyConverterManager;
    import game.modules.uifactory.factory.decoders.DecoderManager;
    import game.modules.uifactory.factory.decoders.IDecoder;
    import game.modules.uifactory.factory.factories.DefaultFactory;
    import game.modules.uifactory.factory.factories.FactoryManager;
    import game.modules.uifactory.factory.handlers.HandlerManager;
    import game.modules.uifactory.factory.processors.ElementProcessorManager;
    import game.modules.uifactory.factory.processors.PropertyProcessorManager;
    import game.modules.uifactory.factory.transformers.PropertyTransformerManager;
    import common.injection.IInjector;
    import common.injection.Injector;
    import common.system.Assert;
    import common.system.Cache;
    import common.system.IDisposable;
    import common.system.TypeObject;
    
    /**
     * ...
     * @author dorofiy.com
     */
    public class ElementFactory extends TypeObject implements IDisposable
    {
        private var _propertyProcessors:PropertyProcessorManager;
        private var _elementProcessors:ElementProcessorManager;
        private var _transformers:PropertyTransformerManager;
        private var _factories:FactoryManager;
        private var _decoders:DecoderManager;
        private var _converters:PropertyConverterManager;
        private var _handlers:HandlerManager;
        private var _context:IContext;
        private var _injector:Injector;
        private var _useCache:Boolean;
        private var _cache:Cache;
        private var _parent:ElementFactory;
        
        public function ElementFactory(context:IContext, parent:ElementFactory = null)
        {
            _context = context;
            _parent = parent;
            _injector = new Injector();
            _injector.parent = context.injector;
            _cache = new Cache();
            _useCache = true;
            
            _injector.map(IInjector).toValue(_injector);
            _injector.map(IContext).toValue(context);
            
            _converters = new PropertyConverterManager(_injector);
            _transformers = new PropertyTransformerManager(_injector, _converters);
            
            _decoders = new DecoderManager(_injector);
            
            _propertyProcessors = new PropertyProcessorManager(_injector, _parent);
            _elementProcessors = new ElementProcessorManager(_injector, _parent);
            _factories = new FactoryManager(_injector, _parent);
            _handlers = new HandlerManager(_injector, _parent);
            _factories.defaultFactory = new DefaultFactory(_injector);
            
            _injector.map(PropertyTransformerManager).toValue(_transformers);
            _injector.map(FactoryManager).toValue(_factories);
            _injector.map(DecoderManager).toValue(_decoders);
            _injector.map(PropertyConverterManager).toValue(_converters);
            _injector.map(HandlerManager).toValue(_handlers);
            _injector.map(PropertyProcessorManager).toValue(_propertyProcessors);
        }
        
        public function decode(value:Object):Element
        {
            var element:Element = value as Element;
            if (element == null)
            {
                if (_useCache)
                {
                    element = _cache.getValue(value) as Element;
                }
                if (element == null)
                {
                    element = _decoders.convert(value);
                    if (element == null && _parent)
                    {
                        element = _parent.decode(value);
                    }
                    applyTransform(element);
                    if (_useCache)
                    {
                        _cache.setValue(value, element);
                    }
                }
            }
            return element;
        }
        
        public function encode(element:Element, encodeType:Class):Object
        {
            var decoder:IDecoder = _decoders.getByType(encodeType);
            if (decoder == null && _parent)
            {
                return _parent.encode(element, encodeType);
            }
            return decoder.encode(element);
        }
        
        public function create(value:Object):Object
        {
            return createByElement(decode(value));
        }
        
        public function createByElement(element:Element):Object
        {
            Assert.notNull(element);
            Assert.notNull(element.type);
            var result:Object = _factories.apply(element);
            _propertyProcessors.apply(element, result);
            if (_parent)
            {
                _parent._elementProcessors.apply(element, result);
            }
            _elementProcessors.apply(element, result);
            return result;
        }
        
        public function get factories():FactoryManager
        {
            return _factories;
        }
        
        public function get propertyProcessors():PropertyProcessorManager
        {
            return _propertyProcessors;
        }
        
        public function get elementProcessors():ElementProcessorManager
        {
            return _elementProcessors;
        }
        
        public function get transformers():PropertyTransformerManager
        {
            return _transformers;
        }
        
        public function get decoders():DecoderManager
        {
            return _decoders;
        }
        
        public function get converters():PropertyConverterManager
        {
            return _converters;
        }
        
        public function get handlers():HandlerManager
        {
            return _handlers;
        }
        
        public function get useCache():Boolean
        {
            return _useCache;
        }
        
        public function set useCache(value:Boolean):void
        {
            _useCache = value;
        }
        
        public function deleteCache():void
        {
            _cache.clear();
        }
        
        public function get parent():ElementFactory
        {
            return _parent;
        }
        
        /* INTERFACE common.system.IDisposable */
        
        public function dispose():void
        {
            _cache.clear();
        }
        
        private function applyTransform(element:Element):void
        {
            if (element)
            {
                _transformers.apply(element);
                for each (var item:Element in element.elements)
                {
                    applyTransform(item);
                }
            }
        }
    }
}