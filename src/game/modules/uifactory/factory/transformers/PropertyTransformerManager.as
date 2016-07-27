package game.modules.uifactory.factory.transformers 
{
    import com.okapp.mvc.IContext;
    import game.modules.uifactory.factory.converter.PropertyConverterManager;
    import game.modules.uifactory.factory.Element;
    import game.modules.uifactory.factory.ElementProperty;
    import common.injection.IInjector;
    import common.injection.Injector;
    import common.system.Assert;
    import common.system.IDisposable;
    import common.system.TypeObject;
    import flash.utils.Dictionary;
	/**
     * ...
     * @author dorofiy.com
     */
    public class PropertyTransformerManager extends TypeObject implements IDisposable 
    {
        
        private var _properties:Dictionary;
        private var _injector:IInjector;
        private var _converters:PropertyConverterManager;
        
        public function PropertyTransformerManager(injector:IInjector, converters:PropertyConverterManager) 
        {
            _converters = converters;
            _injector = injector;
            _properties = new Dictionary();
        }
        
        public function map(property:String, transformer:IPropertyTransformer):void
        {
            Assert.notNull(transformer);
            _properties[property] = transformer;
            _injector.inject(transformer);
        }
        
        public function unmap(property:String):void
        {
            delete _properties[property];
        }
        
        public function apply(element:Element):void
        {
            for each (var item:ElementProperty in element.properties) 
            {
                _converters.apply(item);
                var transorm:IPropertyTransformer = _properties[item.name];
                if (transorm)
                {
                    transorm.apply(item);
                }
            } 
        }
        
        /* INTERFACE common.system.IDisposable */
        
        public function dispose():void 
        {
            
        }
        
    }

}