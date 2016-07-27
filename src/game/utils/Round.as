package game.utils 
{
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Round 
	{
		
		public function Round() 
		{
			
		}
		
		public static function round(x:Number):int
		{
			if (Math.abs(Math.abs(x - Math.round(x)) - 0.5) > 0.0000001)
				return Math.round(x)
			else
				return Math.round(x + 0.1);
		}
		
	}

}