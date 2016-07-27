package game.modules.uifactory.factory.converter 
{
    import com.okapp.mvc.IContext;
    import game.modules.uifactory.factory.Element;
    import game.modules.uifactory.factory.ElementProperty;
    import common.injection.IInjector;
    import common.injection.Injector;
    import flash.utils.Dictionary;
	/**
     * ...
     * @author dorofiy.com
     */
    public class PropertyConverterManager 
    {
        private var _injector:IInjector;
        private var _converters:Dictionary;
        
        public function PropertyConverterManager(injector:IInjector) 
        {
            _injector = injector;
            _converters = new Dictionary();
        }
        
        public function map(type:Class, converter:IPropertyConverter):void
        {
            _converters[type] = converter;
            _injector.inject(converter);
        }
        
        public function getConverter(type:Class):IPropertyConverter
        {
            return _converters[type];
        }
        
        public function apply(item:ElementProperty):void
        {
            var converter:IPropertyConverter = _converters[item.classType];
            if (converter)
            {
                item.value = converter.convert(item.value);
            }
        }
        
    }

}