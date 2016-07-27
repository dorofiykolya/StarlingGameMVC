package game.modules.preloaders
{
	import common.events.Event;
	import common.events.EventDispatcher;
	import flash.display.DisplayObjectContainer;
	
	[Event(name = "close", type = "common.system.Event")]
	[Event(name = "open", type = "common.system.Event")]
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class PreloaderManager extends EventDispatcher
	{
		private var _root:DisplayObjectContainer;
		private var _view:IPreloaderViewMediator;
		private var _progress:Number;
		private var _dependency:Vector.<IPreloaderDependency>;
		private var _opened:Boolean;
		
		public function PreloaderManager(root:DisplayObjectContainer, preloaderViewMediator:IPreloaderViewMediator)
		{
			_root = root;
			_view = preloaderViewMediator;
			
			_opened = false;
			
			_dependency = new Vector.<IPreloaderDependency>();
			
			_view.setContainer(_root);
			show();
		}
		
		public function addCloseDependency(dependency:IPreloaderDependency):void
		{
			_dependency.push(dependency);
		}
		
		public function setProgress(ratio:Number):void
		{
			_progress = ratio;
			_view.setProgress(ratio);
		}
		
		public function close():void
		{
			if (dependencyAvailable)
			{
				_opened = false;
				stopListenDependency();
				_view.close();
				dispatchEventWith(Event.CLOSE);
			}
			else
			{
				startListenDependency();
			}
		}
		
		public function show():void
		{
			if (!_opened)
			{
				_opened = true;
				_view.open();
				dispatchEventWith(Event.OPEN);
			}
		}
		
		public function get progress():Number
		{
			return _progress;
		}
		
		private function get dependencyAvailable():Boolean
		{
			for each (var item:IPreloaderDependency in _dependency)
			{
				if (!item.dependencyReady)
				{
					return false;
				}
			}
			return true;
		}
		
		public function get opened():Boolean
		{
			return _opened;
		}
		
		private function startListenDependency():void
		{
			for each (var item:IPreloaderDependency in _dependency)
			{
				item.addEventListener(PreloaderDependencyEvent.COMPLETE, onDependepcyHandler);
			}
		}
		
		private function onDependepcyHandler(e:Object = null):void
		{
			close();
		}
		
		private function stopListenDependency():void
		{
			for each (var item:IPreloaderDependency in _dependency)
			{
				item.removeEventListener(PreloaderDependencyEvent.COMPLETE, onDependepcyHandler);
			}
		}
	
	}

}