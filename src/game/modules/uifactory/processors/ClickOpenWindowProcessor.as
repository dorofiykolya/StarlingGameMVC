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
	public class ClickOpenWindowProcessor implements IPropertyProcessor 
	{
		[Inject]
		public var dispatcher:IDispatcher;
		
		public function ClickOpenWindowProcessor() 
		{
			
		}
		
		/* INTERFACE com.okapp.pirates.ui.core.factory.processors.IPropertyProcessor */
		
		public function apply(property:ElementProperty, target:Object):void 
		{
			var displayObject:DisplayObject = target as DisplayObject;
			if (displayObject)
			{
				displayObject.addEventListener(TouchEvent.TOUCH, function(event:TouchEvent):void
                {
                    var touch:Touch = event.getTouch(DisplayObject(event.target), TouchPhase.ENDED);
                    if (touch)
                    {
                        dispatcher.dispatchEventWith("onClickOpenWindow", false, String(property.value));
                    }
                });
			}
		}
	}
}