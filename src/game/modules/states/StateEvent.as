package game.modules.states 
{
	import common.events.Event;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class StateEvent extends Event 
	{
		public static const ENTER:String = "enter";
		public static const EXIT:String = "exit";
		
		public var previous:State;
		public var current:State;
		public var next:State;
		
		public function StateEvent(type:Object) 
		{
			super(type);
		}
		
		override protected function initializeEvent(args:Array):Event 
		{
			previous = args[0];
			current = args[1];
			next = args[2];
			return this;
		}
		
	}

}