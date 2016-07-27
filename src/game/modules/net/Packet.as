package game.modules.net 
{
	/**
	 * ...
	 * @author ...
	 */
	public class Packet 
	{
		private var _name:String;
		
		public function Packet(name:String) 
		{
			_name = name;
		}
		
		public function get name():String
		{
			return _name;
		}
		
	}

}