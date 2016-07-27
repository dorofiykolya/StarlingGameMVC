package game.modules.initialize 
{
	import common.injection.IInjector;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class InitializeManager 
	{
		private var _injector:IInjector;
		
		public function InitializeManager(injector:IInjector) 
		{
			_injector = injector;
		}
		
		public function initialize(value:IInitialize):void
		{
			_injector.inject(value);
			value.initialize();
		}
		
	}

}