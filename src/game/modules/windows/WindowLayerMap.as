package game.modules.windows
{
	import flash.utils.Dictionary;
	import game.mvc.view.ILayer;
	import mvc.mediators.IMediatorContext;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class WindowLayerMap
	{
		private var _controllers:Dictionary;
		private var _mediatorContext:IMediatorContext;
		
		public function WindowLayerMap(mediator:IMediatorContext)
		{
			_mediatorContext = mediator;
			_controllers = new Dictionary();
		}
		
		public function getLayer(windowType:WindowType):WindowLayerController
		{
			var result:WindowLayerController = _controllers[windowType];
			return result;
		}
		
		public function get collection():Vector.<WindowLayerController>
		{
			var result:Vector.<WindowLayerController> = new Vector.<WindowLayerController>();
			for each (var item:WindowLayerController in _controllers)
			{
				result.push(item);
			}
			return result;
		}
		
		public function map(windowType:WindowType, layer:ILayer, idMap:WindowIdMap):void
		{
			_controllers[windowType] = new WindowLayerController(layer, _mediatorContext, idMap, windowType);
		}
	}
}