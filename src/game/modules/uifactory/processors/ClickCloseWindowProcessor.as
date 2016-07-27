/**
 * Created by Denis on 01.12.2014.
 */
package game.modules.uifactory.processors
{
    import game.modules.uifactory.factory.ElementProperty;
    import game.modules.uifactory.factory.processors.IPropertyProcessor;

    import common.events.IDispatcher;

    import starling.display.DisplayObject;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;


    public class ClickCloseWindowProcessor implements  IPropertyProcessor
    {

        [Inject]
        public var dispatcher:IDispatcher;

        public function ClickCloseWindowProcessor()
        {
        }

        public function apply(property:ElementProperty, target:Object):void
        {
            var displayObject:DisplayObject = target as DisplayObject;
            if (displayObject)
            {
                displayObject.addEventListener(TouchEvent.TOUCH, function(event:TouchEvent):void
               {
                   if ( event.getTouch(DisplayObject(event.target), TouchPhase.ENDED))
                   {
                       dispatcher.dispatchEventWith("onClickCloseWindow", false, String(property.value));
                   }
               });
            }
        }
    }
}
