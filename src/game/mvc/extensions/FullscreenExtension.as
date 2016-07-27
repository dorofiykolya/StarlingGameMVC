package game.mvc.extensions
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	import common.system.TypeObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.MouseEvent;
    
    /**
     * ...
     * @author dorofiy.com
     */
    public class FullscreenExtension extends TypeObject implements IExtension
    {
		private static const FULL_SCREEN_INTERACTIVE_ACCEPTED:String = "fullScreenInteractiveAccepted";
		
        private var _stage:Stage;
        private var _lock:Boolean;
        
        public function FullscreenExtension(stage:Stage)
        {
            _stage = stage;
        }
        
        private function onLockFrameHandler(e:Event):void
        {
            _stage.removeEventListener(Event.ENTER_FRAME, onLockFrameHandler);
            _lock = false;
        }
        
        private function onFullScreenHandler(e:FullScreenEvent):void
        {
            _lock = true;
            _stage.addEventListener(Event.ENTER_FRAME, onLockFrameHandler);
        }
        
        private function onMouseHandler(e:MouseEvent):void
        {
            if (_lock)
            {
                e.stopImmediatePropagation();
            }
        }
        
        /* INTERFACE com.okapp.mvc.extensions.IExtension */
        
        public function extend(context:IContext):void
        {
            _stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseHandler);
            _stage.addEventListener(MouseEvent.CLICK, onMouseHandler);
            _stage.addEventListener(MouseEvent.MOUSE_UP, onMouseHandler);
            _stage.addEventListener(FULL_SCREEN_INTERACTIVE_ACCEPTED, onFullScreenHandler);
        }
    }
}