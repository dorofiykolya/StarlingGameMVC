package game.modules.uifactory.factory.decoders
{
    import com.okapp.mvc.IContext;
    import game.modules.uifactory.factory.Element;
    import common.injection.IInjector;
    import common.injection.Injector;
    import common.system.ClassType;
    import flash.utils.Dictionary;
    
    /**
     * ...
     * @author dorofiy.com
     */
    public class DecoderManager
    {
        private var _injector:IInjector;
        private var _converters:Dictionary;
        
        public function DecoderManager(injector:IInjector)
        {
            _injector = injector;
            _converters = new Dictionary();
        }
        
        public function map(type:Class, converter:IDecoder):void
        {
            _converters[type] = converter;
            _injector.inject(converter);
        }
        
        public function getByType(type:Class):IDecoder
        {
            return _converters[type];
        }
        
        public function convert(value:Object):Element
        {
            var decoder:IDecoder = _converters[ClassType.getAsClass(value)] as IDecoder;
            if (decoder)
            {
                return decoder.decode(value);
            }
            return null;
        }
    
    }

}