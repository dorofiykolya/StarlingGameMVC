package game.modules.storage
{
	import flash.net.SharedObject;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Storage
	{
		private var _value:*;
		private var _property:Object;
		private var _target:Object;
		private var _shared:SharedObject;
		
		public function Storage(target:Object, property:String, shared:SharedObject)
		{
			_shared = shared;
			_target = target;
			_property = property;
		}
		
		public function deleteValue():void
		{
			delete _target[_property];
			_shared.flush(_shared.size);
		}
		
		/**
		 *
		 * @param	... keys:Array[string]
		 * @return
		 */
		public function map(... path):Storage
		{
			if (path.length == 0)
			{
				throw new ArgumentError();
			}
			var current:Storage = this;
			for each (var key:String in path)
			{
				current = current.getDictionary(key);
			}
			return current;
		}
		
		public function get value():*
		{
			return _target[_property];
		}
		
		public function set value(target:*):void
		{
			_target[_property] = target;
			_shared.flush(_shared.size);
		}
		
		private function getDictionary(property:String):Storage
		{
			var newTarget:Object = _target[property];
			if (newTarget == null)
			{
				newTarget = {};
				_target[property] = newTarget;
			}
			return new Storage(newTarget, property, _shared);
		}
	}
}