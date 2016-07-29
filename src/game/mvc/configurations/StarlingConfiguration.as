package game.mvc.configurations
{
	import common.context.IContext;
	import common.events.IDispatcher;
	import common.system.application.Application;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import mvc.commands.IEventCommandMap;
	import mvc.configurations.IConfigurable;
	import starling.core.Starling;
    
    /**
     * ...
     * @author dorofiy.com
     */
    public class StarlingConfiguration implements IConfigurable
    {
        [Inject]
        public var starling:Starling;
        [Inject]
        public var stage:Stage;
        [Inject]
        public var application:Application;
        [Inject]
        public var dispatcher:IDispatcher;
        [Inject]
        public var command:IEventCommandMap;
        
        public function StarlingConfiguration()
        {
        
        }
        
        /* INTERFACE com.okapp.mvc.configurations.IConfiguration */
        
        public function config(context:IContext):void
        {
            if (application.loaded)
            {
                onAppLoadCompleteHandler(null);
            }
            else
            {
                application.addEventListener(flash.events.Event.COMPLETE, onAppLoadCompleteHandler);
            }
            if (starling.context)
            {
                onContext3DCreatedHandler();
            }
            else
            {
                starling.addEventListener(Event.CONTEXT3D_CREATE, onContext3DCreatedHandler);
            }
            starling.start();
        }
        
        private function onContext3DCreatedHandler(event:Object = null):void
        {
            dispatcher.dispatchEventWith(Event.CONTEXT3D_CREATE);
        }
        
        private function onAppLoadCompleteHandler(event:Object = null):void
        {
            application.removeEventListener(Event.COMPLETE, onAppLoadCompleteHandler);
            
            starling.stage.stageWidth = stage.stageWidth;
            starling.stage.stageHeight = stage.stageHeight;
            
            const viewPort:Rectangle = starling.viewPort;
            viewPort.width = stage.stageWidth;
            viewPort.height = stage.stageHeight;
            starling.viewPort = viewPort;
        }
    }
}