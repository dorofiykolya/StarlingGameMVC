package game.modules.uifactory.factory.processors 
{
    import com.okapp.mvc.IContext;
    import game.modules.uifactory.factory.Element;
    import game.modules.uifactory.factory.ElementFactory;
    import game.modules.uifactory.factory.ElementProperty;
    import common.injection.IInjector;
    import common.injection.Injector;
    import common.system.IDisposable;
    import common.system.TypeObject;
    import flash.utils.Dictionary;
	/**
     * ...
     * @author dorofiy.com
     */
    public class PropertyProcessorManager extends TypeObject implements IDisposable
    {
        private var _properties:Dictionary;
        private var _injector:IInjector;
        private var _parent:ElementFactory;
        
        public function PropertyProcessorManager(injector:Injector, parent:ElementFactory) 
        {
            _parent = parent;
            _injector = injector;
            _properties = new Dictionary();
        }
        
        public function map(property:String, processor:IPropertyProcessor):void
        {
            _properties[property] = processor;
            _injector.inject(processor);
        }
        
        public function unmap(property:String):void
        {
            delete _properties[property];
        }
        
        public function getProcessor(property:String):IPropertyProcessor
        {
            return _properties[property];
        }
        
        public function apply(element:Element, result:Object):void
        {
            for each (var item:ElementProperty in element.properties) 
            {
                var processor:IPropertyProcessor = _properties[item.name];
                var parentFactory:ElementFactory = _parent;
                while(processor == null && parentFactory)
                {
                    processor = parentFactory.propertyProcessors._properties[item.name];
                    parentFactory = parentFactory.parent;
                }
                if (processor)
                {
                    processor.apply(item, result);
                }
                else if(item.name in result)
                {
                    result[item.name] = item.classType(item.value);
                }
            } 
        }
        
        /* INTERFACE common.system.IDisposable */
        
        public function dispose():void 
        {
            
        }
        
    }

}