package game.modules.layouts
{
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LayoutProvider implements ILayoutProvider
	{
		private var _cache:Dictionary;
		private var _map:Dictionary;
		
		public function LayoutProvider()
		{
			_cache = new Dictionary();
			_map = new Dictionary();
		}
		
		public function map(name:String, value:Object):void
		{
			_map[name] = value;
		}
		
		/* INTERFACE game.modules.layouts.ILayoutProvider */
		
		public function getLayout(value:Object):Object
		{
			var result:Object = null;
			if (value is Class)
			{
				result = _cache[value];
				if (result == null)
				{
					var cls:Class = Class(value);
					result = new cls;
					result = JSON.parse(String(result));
				}
				_cache[value] = result;
			}
			else if (value is String)
			{
				if (value in _map)
				{
					result = getLayout(_map[value]);
				}
				else
				{
					result = JSON.parse(String(value));
				}
			}
			return result;
		}
	
	}

}