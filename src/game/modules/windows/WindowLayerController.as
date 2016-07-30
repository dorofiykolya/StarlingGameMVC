package game.modules.windows
{
	import common.events.EventDispatcher;
	import game.mvc.view.ILayer;
	import mvc.mediators.IMediatorContext;
	
	[Event(name="windowEvent.opened", type="game.managers.windows.WindowEvent")]
	[Event(name="windowEvent.closed", type="game.managers.windows.WindowEvent")]
	[Event(name="windowEvent.closedAll", type="game.managers.windows.WindowEvent")]
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class WindowLayerController extends EventDispatcher
	{
		private var _layer:ILayer;
		private var _mediator:IMediatorContext;
		private var _idMap:WindowIdMap;
		private var _queue:WindowQueue;
		private var _currentWindow:WindowMediator;
		private var _windowType:WindowType;
		
		public function WindowLayerController(layer:ILayer, mediator:IMediatorContext, idMap:WindowIdMap, windowType:WindowType)
		{
			_windowType = windowType;
			_idMap = idMap;
			_mediator = mediator;
			_layer = layer;
			_queue = new WindowQueue();
		}
		
		public function open(id:WindowId, mediatorType:Class, data:WindowData, from:PathWindow):void
		{
			if (_currentWindow == null || _currentWindow.closed)
			{
				if (_currentWindow != null)
				{
					close(_currentWindow.id, true);
				}
				var mediator:WindowMediator = getMediator(mediatorType);
				if (mediator != null)
				{
					_currentWindow = mediator;
					mediator.initialization(id, _layer, data, _windowType);
					mediator.openView();
					dispatchEventAs(WindowEvent, WindowEvent.OPENED, false, id);
				}
				
				if (from != null)
				{
					if (_queue.isEmpty)
					{
						_queue.enqueue(new PathStack());
					}
					
					_queue.peek().enqueue(from);
				}
				else
				{
					if (!_queue.isEmpty)
					{
						_queue.dequeue();
					}
				}
			}
			else
			{
				if (from != null)
				{
					if (_queue.isEmpty)
					{
						_queue.enqueue(new PathStack());
					}
					
					_queue.peek().enqueue(from);
				}
				else
				{
					var queue:PathStack = new PathStack();
					queue.enqueue(new PathWindow(id, data));
					_queue.enqueue(queue);
				}
			}
		}
		
		public function close(id:WindowId, removeFromQueue:Boolean):void
		{
			var mediatorType:Class = _idMap.getMediatorType(id);
			var mediator:WindowMediator = getMediator(mediatorType);
			mediator.closeView();
			dispatchEventAs(WindowEvent, WindowEvent.CLOSED, false, id);
			
			if (removeFromQueue && !_queue.isEmpty)
			{
				if (mediator == _currentWindow)
				{
					_queue.dequeue();
					cheakQueue();
				}
			}
			if(mediator == _currentWindow)
			{
				_currentWindow = null;
			}
			if (isEmpty)
			{
				dispatchEventAs(WindowEvent, WindowEvent.CLOSED_ALL, false);
			}
		}
		
		public function get currentId():WindowId
		{
			if (_currentWindow)
			{
				return _currentWindow.id;
			}
			return null;
		}
		
		public function get currentData():WindowData 
		{
			if (_currentWindow)
			{
				return _currentWindow.data;
			}
			return null;
		}
		
		public function get windowType():WindowType 
		{
			return _windowType;
		}
		
		public function back():Boolean
		{
			if (_currentWindow)
			{
				_currentWindow.closeView();
				dispatchEventAs(WindowEvent, WindowEvent.CLOSED, false, _currentWindow.id);
				_currentWindow = null;
			}
			cheakQueue();
			if (isEmpty)
			{
				dispatchEventAs(WindowEvent, WindowEvent.CLOSED_ALL, false);
			}
			return _currentWindow != null;
		}
		
		public function closeAll():void
		{
			if (_currentWindow)
			{
				_currentWindow.closeView();
				_currentWindow = null;
			}
			_queue.clear();
			dispatchEventAs(WindowEvent, WindowEvent.CLOSED_ALL);
		}
		
		public function get isEmpty():Boolean
		{
			return _currentWindow == null && _queue.count == 0;
		}
		
		private function cheakQueue():void
		{
			if (!_queue.isEmpty)
			{
				var windowFromChain:PathWindow = null;
				var windowsChain:PathStack = _queue.peek();
				
				if (windowsChain.isEmpty)
				{
					_queue.dequeue();
					return;
				}
				
				windowFromChain = windowsChain.pop();
				
				var chainNeedToRemove:Boolean = windowsChain.count <= 0;
				if (chainNeedToRemove)
				{
					_queue.dequeue();
				}
				
				if (windowFromChain == null)
				{
					return;
				}
				
				openFromQueue(windowFromChain.id, _idMap.getMediatorType(windowFromChain.id), windowFromChain.data);
			}
		}
		
		private function openFromQueue(id:WindowId, mediatorType:Class, data:WindowData):void
		{
			if (_currentWindow == null)
			{
				var mediator:WindowMediator = getMediator(mediatorType);
				if (mediator != null)
				{
					_currentWindow = mediator;
					mediator.initialization(id, _layer, data, _windowType);
					mediator.openView();
				}
			}
		}
		
		internal function getMediator(mediatorType:Class):WindowMediator
		{
			return WindowMediator(_mediator.getObject(mediatorType));
		}
	
	}

}