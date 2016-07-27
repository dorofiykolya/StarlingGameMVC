package game.modules.uifactory.processors
{
    import game.modules.uifactory.factory.Element;
    import game.modules.uifactory.factory.ElementProperty;
    import game.modules.uifactory.factory.processors.IElementProcessor;
    import flash.geom.Rectangle;
    import flash.utils.Dictionary;
    import starling.display.DisplayObject;
    import starling.display.Stage;
    import starling.events.ResizeEvent;
    
    /**
     * ...
     * @author dorofiy.com
     */
    public class HUDPositionProcessor implements IElementProcessor
    {
        private const HELP_RECT:Rectangle = new Rectangle();
        private var isValidSize:Boolean;
        
        [Inject]
        public var stage:Stage;
        
        private var _hud:Dictionary;
        
        public function HUDPositionProcessor()
        {
            _hud = new Dictionary();
        }
        
        /* INTERFACE com.okapp.pirates.ui.core.factory.processors.IElementProcessor */
        
        public function apply(element:Element, result:Object):void
        {
            var display:DisplayObject = result as DisplayObject;
            if (display)
            {
                isValidSize = false;
                
                _hud[result] = element;
                
                var left:ElementProperty = element.getProperty("left");
                var right:ElementProperty = element.getProperty("right");
                var top:ElementProperty = element.getProperty("top");
                var bottom:ElementProperty = element.getProperty("bottom");
                
                if (left)
                {
                    display.x = Number(left.value);
                }
                if (right)
                {
                    getObjectBounds(display, HELP_RECT);
                    display.x = stage.stageWidth - HELP_RECT.width - Number(right.value);
                }
                if (top)
                {
                    display.y = Number(top.value);
                }
                if (bottom)
                {
                    getObjectBounds(display, HELP_RECT);
                    display.y = stage.stageHeight - HELP_RECT.height - Number(bottom.value);
                }
                
                stage.addEventListener(ResizeEvent.RESIZE, onResizeHandler);
            }
        }
        
        private function onResizeHandler(event:ResizeEvent):void 
        {
            for (var object:Object in _hud) 
            {
                apply(_hud[object], object);
            }
        }
        
        private function getObjectBounds(object:DisplayObject, result:Rectangle):void
        {
            if (!isValidSize)
            {
                object.getBounds(object.parent, result);
                isValidSize = true;
            }
        }
    
    }

}