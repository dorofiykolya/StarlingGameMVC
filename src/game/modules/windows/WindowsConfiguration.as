package game.modules.windows
{
	import common.context.IContext;
	import common.system.Assert;
	import game.mvc.view.ILayers;
	import mvc.configurations.IConfigurable;
	import mvc.mediators.IMediatorContext;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class WindowsConfiguration implements IConfigurable
	{
		[Inject]
		public var layers:ILayers;
		[Inject]
		public var layerMap:WindowLayerMap;
		[Inject]
		public var idMap:WindowIdMap;
		[Inject]
		public var mediatorContext:IMediatorContext;
		
		public function WindowsConfiguration()
		{
		
		}
		
		public function map(mediatorClass:Class, viewClass:Class, windowId:WindowId, windowType:WindowType):void
		{
			Assert.subclassOf(mediatorClass, WindowMediator);
			Assert.subclassOf(viewClass, IWindowView);
			
			idMap.map(mediatorClass, windowId, windowType);
			mediatorContext.map(mediatorClass).asSingleton().target(viewClass, new WindowViewProvider(windowType, viewClass));
		}
		
		public function config(context:IContext):void
		{
			// CONFIG LAYERS
			//layerMap.map(WindowType.WINDOWS, layers.getLayer(LayerIndex.WINDOWS), idMap);
			//layerMap.map(WindowType.POPUP, layers.getLayer(LayerIndex.POPUPS), idMap);
			
			//CONFIG WINDOWS
			//map(AchieveWindowMediator, AchieveWindowView, WindowId.ACHIEVE, WindowType.WINDOWS);

			
			//CONFIG POPUPS
			//map(ConnectionLostWindowMediator, ConnectionLostWindowView, WindowId.CONNECTION_LOST, WindowType.POPUP);
		}
	}
}