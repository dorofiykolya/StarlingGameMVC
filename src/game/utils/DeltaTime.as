package game.utils 
{
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class DeltaTime 
	{
		private var _startTime:Number;
		
		public function DeltaTime() 
		{
			reset();
		}
		
		public function reset():void
		{
			_startTime = getTimer() / 1000.0;
		}
		
		public function getTime(scale:Number = 1):Number
		{
			var now:Number = getTimer() / 1000.0;
			var delta:Number = now - _startTime;
			return delta * scale;
		}
		
	}

}