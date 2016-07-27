package game.modules.preloaders
{
	import common.events.IEventListener;
	
	[Event(name="preloaderDependencyEvent.complete", type="game.modules.preloaders.PreloaderDependencyEvent")]
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface IPreloaderDependency extends IEventListener
	{
		function get dependencyReady():Boolean;
	}

}