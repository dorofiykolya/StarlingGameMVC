package game.modules.uifactory.processors
{
    import game.modules.uifactory.factory.ElementProperty;
    import game.modules.uifactory.factory.processors.IPropertyProcessor;
    import common.events.IDispatcher;
    import starling.display.DisplayObject;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    
    /**
     * ...
     * @author Mike Silanin
     */
    public class ClickProcessor implements IPropertyProcessor
    {
        [Inject]
        public var dispatcher:IDispatcher;
        
        public function ClickProcessor()
        {
        
        }
        
        /* INTERFACE com.okapp.pirates.ui.core.factory.processors.IPropertyProcessor */
        
        public function apply(property:ElementProperty, target:Object):void
        {
            var displayObject:DisplayObject = target as DisplayObject;
            if (target)
            {
                displayObject.addEventListener(TouchEvent.TOUCH, onTouchHanler);
            }
        }
        
        private function onTouchHanler(event:TouchEvent):void
        {
            var touch:Touch = event.getTouch(DisplayObject(event.target), TouchPhase.ENDED);
            if (touch)
            {
                dispatcher.dispatchEventWith("onClick", false, event.target);
            }
        }
    }
}