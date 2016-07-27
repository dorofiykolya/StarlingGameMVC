package game.mvc 
{
	import common.context.IContext;
	import common.context.links.Link;
	import flash.display.Stage;
	import game.mvc.configurations.OrientationConfiguration;
	import game.mvc.extensions.StarlingExtension;
	import game.mvc.view.ILayers;
	import game.mvc.view.starling.StarlingLayers;
	import mvc.MVCContext;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class GameContext extends MVCContext 
	{
		
		public function GameContext(stage:Stage, starlingRootClass:Class, configuration:ContextConfiguration = null) 
		{
			super(parent);
			
			install(configuration || new ContextConfiguration());
			install(new StarlingExtension(stage, starlingRootClass));
			install(new Link(StarlingLayers, ILayers));
			install(OrientationConfiguration);
		}
		
	}

}