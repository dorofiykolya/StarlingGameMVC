package game.modules.states
{
	import common.system.IEquatable;
	import common.system.TypeObject;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class State extends TypeObject implements IEquatable
	{
		private var _name:String;
		private var _parent:State;
		
		public function State(name:String, parent:State = null)
		{
			_parent = parent;
			_name = name;
			
			var current:State = parent;
			while (current)
			{
				if (current == this)
				{
					throw new ArgumentError();
				}
				current = current._parent;
			}
		}
		
		/**
		 * state name
		 */
		public function get name():String
		{
			return _name;
		}
		
		/**
		 *
		 */
		public function get parent():State
		{
			return _parent;
		}
		
		/**
		 * state and its ancestors are arguments
		 * @param	state
		 * @return
		 */
		public function isState(state:State):Boolean
		{
			var current:State = this;
			while (current)
			{
				if (current == state) return true;
				current = current._parent;
			}
			return false;
		}
		
		/**
		 * return type, name:stateName
		 * @return
		 */
		override public function toString():String
		{
			return super.toString() + ", name:" + _name;
		}
		
		
		/**
		 * equals by values
		 * @param	value
		 * @return
		 */
		public function equals(value:Object):Boolean 
		{
			if (value == null) return false;
			if (!(value is State)) return false;
			return this._name == State(value)._name;
		}
	
	}

}