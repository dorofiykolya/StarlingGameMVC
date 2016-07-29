package game.mvc.configurations
{
	import common.context.IContext;
	import flash.display.Stage;
	import game.mvc.ContextConfiguration;
	import mvc.configurations.IConfigurable;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class StageConfiguration implements IConfigurable
	{
		[Inject]
		public var configuration:ContextConfiguration;
		[Inject]
		public var nativeStage:Stage;
		
		public function StageConfiguration()
		{
		
		}
		
		/* INTERFACE mvc.configurations.IConfigurable */
		
		public function config(context:IContext):void
		{
			nativeStage.frameRate = configuration.fps;
		}
	
	}

}