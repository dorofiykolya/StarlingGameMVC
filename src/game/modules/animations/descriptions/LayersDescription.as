package game.modules.animations.descriptions
{
	import flash.utils.Dictionary;
	import game.modules.animations.LayerViewer;
	import game.modules.animations.descriptions.LayerDescription;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LayersDescription
	{
		private var _map:Dictionary;
		private var _list:Vector.<LayerDescription>;
		
		public var name:String;
		public var type:String;
		
		public function LayersDescription()
		{
			_map = new Dictionary();
			_list = new Vector.<LayerDescription>();
		}
		
		public function add(layer:LayerDescription):void
		{
			_map[layer.name] = layer;
			_list.push(layer);
		}
		
		public function instantiate():Vector.<LayerViewer>
		{
			var result:Vector.<LayerViewer> = new Vector.<LayerViewer>(_list.length);
			var index:int = 0;
			for each (var layer:LayerDescription in _list)
			{
				result[index] = layer.instantiate();
				index++;
			}
			return result;
		}
		
		public function getLayer(name:String):LayerDescription
		{
			return _map[name];
		}
		
		public function get layers():Vector.<LayerDescription>
		{
			return _list;
		}
	
	}

}