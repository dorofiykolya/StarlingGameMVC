package game.modules.applications
{
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface IApplicationDescription
	{
		function get applicationDescriptor():XML;
		function get applicationID():String;
		function get runtimeVersion():String;
	}

}