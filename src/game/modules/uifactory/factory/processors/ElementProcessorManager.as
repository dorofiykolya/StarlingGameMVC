package game.modules.uifactory.factory.processors 
{
    import game.modules.uifactory.factory.Element;
    import game.modules.uifactory.factory.ElementFactory;
    import common.injection.IInjector;
    import common.injection.Injector;
	/**
     * ...
     * @author dorofiy.com
     */
    public class ElementProcessorManager 
    {
        private var _processors:Vector.<IElementProcessor>;
        private var _injector:IInjector;
        private var _parent:ElementFactory;
        
        public function ElementProcessorManager(injector:Injector, parent:ElementFactory) 
        {
            _parent = parent;
            _injector = injector;
            _processors = new Vector.<IElementProcessor>();
        }
        
        public function apply(element:Element, target:Object):void
        {
            for each (var item:IElementProcessor in _processors) 
            {
                item.apply(element, target);
            }
        }
        
        public function add(processor:IElementProcessor):void
        {
            var index:int = _processors.indexOf(processor);
            if (index == -1)
            {
                _processors[_processors.length] = processor;
                _injector.inject(processor);
            }
        }
        
        public function remove(processor:IElementProcessor):void
        {
            var index:int = _processors.indexOf(processor);
            if (index != -1)
            {
                _processors.splice(index, 1);
            }
        }
    }

}