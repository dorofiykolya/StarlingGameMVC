package starling.extensions.utils
{
	import starling.animation.Transitions;

	/**
	 * @author Evgeniy on 5/19/2016.
	 */
	public class TransitionsUtils
	{

		public static var ANIMATION_STAR_X:String = "starAnimX";
		public static var ANIMATION_STAR_Y:String = "starAnimY";

		public static function registerAll():void
		{
			Transitions.register(ANIMATION_STAR_X, function (ratio:Number):Number
			{
				return bezierX(ratio);
			});

			Transitions.register(ANIMATION_STAR_Y, function (ratio:Number):Number
			{
				return bezierY(ratio);
			});
		}

		protected static function bezierX(t:Number):Number
		{
			var p0:Number = 0;
			var p1:Number = -1.14 * 6;
			var p2:Number = 0.5 * 5;
			var p3:Number = 1;
			return (1 - t) * ((1 - t) * ((1 - t) * p0 + t * p1) + t * ((1 - t) * p1 + t * p2)) + t * ((1 - t) * ((1 - t) * p1 + t * p2) + t * ((1 - t) * p2 + t * p3));
		}

		protected static function bezierY(t:Number):Number
		{
			var p0:Number = 0;
			var p1:Number = 0.3;
			var p2:Number = 0.7;
			var p3:Number = 1;
			return (1 - t) * ((1 - t) * ((1 - t) * p0 + t * p1) + t * ((1 - t) * p1 + t * p2)) + t * ((1 - t) * ((1 - t) * p1 + t * p2) + t * ((1 - t) * p2 + t * p3));
		}
	}
}
