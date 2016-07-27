package game.modules.states
{
	import common.system.TypeObject;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class State extends TypeObject
	{
		private var _name:String;
		
		public function State(name:String)
		{
			_name = name;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		override public function toString():String 
		{
			return super.toString() + ", name:" + _name;
		}
	
	}

}