package game.modules.states 
{
	import common.events.Event;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ChangeStateEvent extends Event 
	{
		public static const CHANGE:String = "change";
		
		public var previous:State;
		public var current:State;
		
		public function ChangeStateEvent(type:Object) 
		{
			super(type);
		}
		
		override protected function initializeEvent(args:Array):Event 
		{
			previous = args[0];
			current = args[1];
			return this;
		}
		
	}

}