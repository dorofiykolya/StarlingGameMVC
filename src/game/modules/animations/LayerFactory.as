package game.modules.animations
{
	import flash.utils.Dictionary;
	import game.modules.animations.descriptions.LayersDescription;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LayerFactory
	{
		private var _mapPool:Dictionary;
		private var _descriptions:Dictionary;
		
		public function LayerFactory()
		{
			_mapPool = new Dictionary();
			_descriptions = new Dictionary();
		}
		
		public function map(source:String, description:LayersDescription):void
		{
			_descriptions[source] = description;
		}
		
		public function getDescription(source:String):LayersDescription
		{
			return _descriptions[source];
		}
		
		public function getLayers(source:String):Vector.<LayerViewer>
		{
			var result:Vector.<LayerViewer> = fromPool(source);
			if (result == null)
			{
				var description:LayersDescription = getDescription(source);
				if (description)
				{
					result = description.instantiate();
				}
			}
			return result;
		}
		
		public function fromPool(source:String):Vector.<LayerViewer>
		{
			var list:Vector.<Vector.<LayerViewer>> = _mapPool[source];
			if (list != null && list.length != 0)
			{
				return list.pop();
			}
			return null;
		}
		
		public function toPool(source:String, value:Vector.<LayerViewer>):void
		{
			var list:Vector.<Vector.<LayerViewer>> = _mapPool[source];
			if (list == null)
			{
				list = new Vector.<Vector.<LayerViewer>>();
				_mapPool[source] = list;
			}
			list.push(value);
		}
	
	}

}