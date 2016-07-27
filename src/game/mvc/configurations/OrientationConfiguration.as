package game.mvc.configurations
{
	import common.context.IContext;
	import common.system.Environment;
	import flash.display.Stage;
	import flash.events.AccelerometerEvent;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.sensors.Accelerometer;
	import game.mvc.ContextConfiguration;
	import mvc.configurations.IConfigurable;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class OrientationConfiguration implements IConfigurable
	{
		private static const DEFAULT:String = "default";
		private static const ROTATED_LEFT:String = "rotatedLeft";
		private static const ROTATED_RIGHT:String = "rotatedRight";
		private static const UNKNOWN:String = "unknown";
		private static const UPSIDE_DOWN:String = "upsideDown";
		
		private static const ORIENTATION:String = "orientation";
		private static const SETORIENTATION:String = "setOrientation";
		
		[Inject]
		public var stage:Stage;
		[Inject]
		public var starling:Starling;
		[Inject]
		public var configuration:ContextConfiguration;
		
		private var _accelerometer:Accelerometer;
		
		public function OrientationConfiguration()
		{
		
		}
		
		/* INTERFACE com.okapp.mvc.configurations.IConfiguration */
		
		public function config(context:IContext):void
		{
			if (Environment.isIOS && "autoOrients" in stage)
			{
				stage["autoOrients"] = false;
			}
			if (Accelerometer.isSupported && Environment.isAndroid && configuration.correctAspectRatio && ORIENTATION in stage && SETORIENTATION in stage)
			{
				_accelerometer = new Accelerometer();
				_accelerometer.setRequestedUpdateInterval(1000);
				_accelerometer.addEventListener(AccelerometerEvent.UPDATE, onAccelerometerHandler);
			}
			stage.addEventListener(Event.RESIZE, onResizeHandler);
			if (Environment.isDesktop)
			{
				stage.addEventListener("orientationChange", onResizeHandler);
			}
		}
		
		private function updateView(event:Object = null):void
		{
			if (starling)
			{
				starling.stage.stageWidth = stage.stageWidth;
				starling.stage.stageHeight = stage.stageHeight;
				
				const viewPort:Rectangle = starling.viewPort;
				viewPort.width = stage.stageWidth;
				viewPort.height = stage.stageHeight;
				starling.viewPort = viewPort;
			}
			if (configuration.correctAspectRatio && stage.stageHeight > stage.stageWidth)
			{
				if (Object(stage).hasOwnProperty('setAspectRatio'))
				{
					stage['setAspectRatio']("landscape");
				}
			}
			stage.removeEventListener(Event.ENTER_FRAME, updateView);
		}
		
		private function onResizeHandler(e:Object = null):void
		{
			updateView();
			if (Environment.isMobile)
			{
				stage.addEventListener(Event.ENTER_FRAME, updateView);
			}
		}
		
		private function onAccelerometerHandler(e:AccelerometerEvent):void
		{
			if (e.accelerationX < -0.5)
			{
				var orientation:String = stage[ORIENTATION];
				if (orientation == DEFAULT)
				{
					stage[SETORIENTATION](UPSIDE_DOWN);
				}
				else if (orientation == UPSIDE_DOWN)
				{
					stage[SETORIENTATION](DEFAULT);
				}
				else if (orientation == ROTATED_LEFT)
				{
					stage[SETORIENTATION](ROTATED_RIGHT);
				}
				else if (orientation == ROTATED_RIGHT)
				{
					stage[SETORIENTATION](ROTATED_LEFT);
				}
			}
		}
	}
}