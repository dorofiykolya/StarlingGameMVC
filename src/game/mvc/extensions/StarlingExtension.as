package game.mvc.extensions
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	import common.system.Environment;
	import common.system.TypeObject;
	import flash.display.Stage;
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.display.Stage;
    
    /**
     * ...
     * @author dorofiy.com
     */
    public class StarlingExtension extends TypeObject implements IExtension
    {
        private var _starling:Starling;
        private var _stage:flash.display.Stage;
        private var _juggler:Juggler;
		private var _rootClass:Class;
        
        public function StarlingExtension(stage:flash.display.Stage, rootClass:Class)
        {
            _stage = stage;
			_rootClass = rootClass;
        }
        
        /* INTERFACE com.okapp.mvc.extensions.IExtension */
        
        public function extend(context:IContext):void
        {
            Starling.multitouchEnabled = true;
            Starling.handleLostContext = !Environment.isIOS;
            
            _starling = new Starling(_rootClass, _stage, null, null, "auto", "auto"); // Context3DProfile.BASELINE_EXTENDED
            _starling.antiAliasing = 1;
			_starling.showStats = Environment.isStandAlone || Environment.isDebugger;
			_starling.stage.broadcastEnterFrameEvent = false;
            
            _juggler = new Juggler();
            
            _starling.juggler.add(_juggler);
			
            context.injector.map(Juggler).toValue(_juggler);
            context.injector.map(starling.display.Stage).toValue(_starling.stage);
            context.injector.map(Starling).toValue(_starling);
        }
    }
}