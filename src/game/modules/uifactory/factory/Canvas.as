package game.modules.uifactory.factory
{
    import game.modules.uifactory.factory.handlers.IHandler;
    import common.system.Assert;
    import starling.display.DisplayObject;
    import starling.display.DisplayObjectContainer;
    import starling.display.SpriteBox;
    
    /**
     * ...
     * @author dorofiy.com
     */
    public class Canvas extends SpriteBox
    {
        private var _fabric:ElementFactory;
        private var _element:Element;
        
        public function Canvas(factory:ElementFactory)
        {
            _fabric = factory;
        }
        
        public function decode(value:Object):void
        {
            fill(_fabric.decode(value));
        }
        
        public function fill(element:Element):void
        {
            Assert.notNull(element);
            _element = element;
            var container:DisplayObjectContainer;
            if (element.classType)
            {
                container = _fabric.create(element) as DisplayObjectContainer;
            }
            if (container == null)
            {
                container = this;
            }
            fillElement(element, container);
        }
        
        private function fillElement(element:Element, container:DisplayObjectContainer):void
        {
            for each (var item:Element in element.elements)
            {
                var handler:IHandler = _fabric.handlers.getHandler(item.name)
                if (handler)
                {
                    handler.apply(item, container);
                }
                else if (item.type == null && item.name in container)
                {
                    var func:Function = container[item.name] as Function;
                    if (Boolean(func))
                    {
                        if (func.length == 0)
                        {
                            func();
                        }
                        else
                        {
                            invokeMethod(func, item, container);
                        }
                    }
                }
                else
                {
                    var result:Object = _fabric.create(item);
                    if (result)
                    {
                        var display:DisplayObject = result as DisplayObject;
                        if (display)
                        {
                            display.name = item.id;
                            container.insert(display as DisplayObject);
                        }
                        var displayContainer:DisplayObjectContainer = display as DisplayObjectContainer;
                        if (displayContainer)
                        {
                            fillElement(item, displayContainer);
                        }
                        else
                        {
                            fillHandlers(item, result);
                        }
                    }
                }
            }
        }
        
        private function invokeMethod(func:Function, element:Element, container:DisplayObjectContainer):void
        {
            var params:ElementProperty = element.getProperty("params");
            if (params)
            {
                func.apply(null, params.value);
            }
            else
            {
                func();
            }
        }
        
        private function fillHandlers(element:Element, target:Object):void
        {
            var handler:IHandler = _fabric.handlers.getHandler(element.name)
            if (handler)
            {
                handler.apply(element, target);
            }
        }
    }

}