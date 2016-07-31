package game.modules.windows
{
	import common.context.IContext;
	import common.events.EventDispatcher;
	import game.mvc.view.ILayers;
	import game.mvc.view.ViewContext;
	import mvc.configurations.IConfigurable;
	import mvc.processors.ConfigurationProcessor;
	
	[Event(name = "windowEvent.opened", type = "game.managers.windows.WindowEvent")]
	[Event(name = "windowEvent.closed", type = "game.managers.windows.WindowEvent")]
	[Event(name = "windowEvent.closedAll", type = "game.managers.windows.WindowEvent")]
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class WindowsManager extends EventDispatcher implements IConfigurable
	{
		private var _layerMap:WindowLayerMap;
		private var _idMap:WindowIdMap;
		private var _context:WindowsContext;
		
		public function WindowsManager(context:ViewContext, layers:ILayers)
		{
			_context = new WindowsContext(context);
			_context.install(new ConfigurationProcessor());
			_context.install((_layerMap = new WindowLayerMap(_context.mediator)));
			_context.install((_idMap = new WindowIdMap()));
			_context.install(WindowsConfiguration);
		}
		
		/* INTERFACE mvc.configurations.IConfigurable */
		
		public function config(context:IContext):void
		{
			_context.initialize();
		}
		
		public function isOpen(windowId:WindowId):Boolean
		{
			for each (var item:WindowLayerController in _layerMap.collection) 
			{
				if (item.currentId == windowId)
				{
					return true;
				}
			}
			return false;
		}
		
		public function get isEmpty():Boolean
		{
			for each (var item:WindowLayerController in _layerMap.collection) 
			{
				if (!item.isEmpty)
				{
					return false;
				}
			}
			return true;
		}
		
		public function getCurrentId(windowType:WindowType):WindowId
		{
			var controller:WindowLayerController = _layerMap.getLayer(windowType);
			return controller.currentId;
		}
		
		public function getCurrentData(windowType:WindowType):WindowData
		{
			var controller:WindowLayerController = _layerMap.getLayer(windowType);
			return controller.currentData;
		}
		
		/**
		 *
		 * @param	id
		 * @param	data
		 * @param	from  WindowMediator | PathWindow | CurrentPathWindow
		 */
		public function open(id:WindowId, data:WindowData = null, from:Object = null):void
		{
			if (from is WindowMediator)
			{
				var fromWindowId:WindowId = WindowMediator(from).id;
				var fromWindowData:WindowData = WindowMediator(from).data;
				from = new PathWindow(fromWindowId, fromWindowData);
			}
			if (from is CurrentPathWindow)
			{
				from.id = getCurrentId(CurrentPathWindow(from).windowType);
				from.data = getCurrentData(CurrentPathWindow(from).windowType);
			}
			if (from && from is PathWindow && from.id == null)
			{
				from = null;
			}
			var layerController:WindowLayerController = getLayerControllerById(id);
			if (layerController != null)
			{
				layerController.addEventListener(WindowEvent.OPENED, onWindowOpenedHandler);
				layerController.addEventListener(WindowEvent.CLOSED, onWindowClosedHandler);
				layerController.addEventListener(WindowEvent.CLOSED_ALL, onWindowClosedAllHandler);
				
				if (from != null)
				{
					layerController.close(from.id, false);
				}
				var mediatorType:Class = getMediatorTypeById(id);
				layerController.open(id, mediatorType, data, PathWindow(from));
			}
		}
		
		public function getWindow(id:WindowId):WindowMediator
		{
			var layerController:WindowLayerController = getLayerControllerById(id);
			if (layerController != null)
			{
				var mediatorType:Class = _idMap.getMediatorType(id);
				return layerController.getMediator(mediatorType);
			}
			return null;
		}
		
		public function close(id:WindowId, removeFromQueue:Boolean = true):void
		{
			var windowLayerController:WindowLayerController = getLayerControllerById(id);
			windowLayerController.close(id, removeFromQueue);
		}
		
		public function back(id:WindowId):void
		{
			var windowLayerController:WindowLayerController = getLayerControllerById(id);
			windowLayerController.back();
		}
		
		public function backByType(windowType:WindowType):Boolean
		{
			var controller:WindowLayerController = _layerMap.getLayer(windowType);
			return controller.back();
		}
		
		public function hasQueue(windowType:WindowType):Boolean
		{
			var controller:WindowLayerController = _layerMap.getLayer(windowType);
			return controller.currentId != null;
		}
		
		public function closeAll(type:WindowType = null):void
		{
			var layerController:WindowLayerController;
			if (type != null)
			{
				layerController = _layerMap.getLayer(type);
				if (layerController != null)
				{
					layerController.closeAll();
				}
			}
			else
			{
				for each (layerController in _layerMap.collection)
				{
					if (layerController != null)
					{
						layerController.closeAll();
					}
				}
			}
		}
		
		private function getLayerControllerById(id:WindowId):WindowLayerController
		{
			var windowType:WindowType = _idMap.getWindowType(id);
			var controller:WindowLayerController = _layerMap.getLayer(windowType);
			return controller;
		}
		
		private function getMediatorTypeById(id:WindowId):Class
		{
			var type:Class = _idMap.getMediatorType(id);
			return type;
		}
		
		private function onWindowClosedAllHandler(e:WindowEvent):void
		{
			for each (var item:WindowLayerController in _layerMap.collection) 
			{
				if (!item.isEmpty)
				{
					return;
				}
			}
			dispatchEventAs(WindowEvent, WindowEvent.CLOSED_ALL, false, e.data);
		}
		
		private function onWindowClosedHandler(e:WindowEvent):void
		{
			dispatchEventAs(WindowEvent, WindowEvent.CLOSED, false, e.data);
			for each (var item:WindowLayerController in _layerMap.collection) 
			{
				if (!item.isEmpty)
				{
					return;
				}
			}
			dispatchEventAs(WindowEvent, WindowEvent.CLOSED_ALL, false, e.data);
		}
		
		private function onWindowOpenedHandler(e:WindowEvent):void
		{
			dispatchEventAs(WindowEvent, WindowEvent.OPENED, false, e.data);
		}
	
	}

}