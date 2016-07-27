package game.utils
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Math2
	{
		
		//[Inline]
		public static function clamp(input:Number, left:Number, right:Number):Number
		{
			if (input < left) return left;
			if (input > right) return right;
			return input;
		}
		
		//[Inline]
		public static function interpolate(left:Number, right:Number, amount:Number):Number
		{
			return left * (1 - amount) + right * amount;
		}
		
		//[Inline]
		public static function radiansPoint(from:Point, to:Point):Number
		{
			return Math.atan2(-(to.y - from.y), (to.x - from.x));
		}
		
		//[Inline]
		public static function degreesPoint(from:Point, to:Point):Number
		{
			return degrees(from.x, from.y, to.x, to.y);
		}
		
		//[Inline]
		public static function degrees(fromx:Number, fromy:Number, tox:Number, toy:Number):Number
		{
			var result:Number = rad2deg(Math.atan2(-(toy - fromy), (tox - fromx)));
			if (result < 0.0)
			{
				result = 360.0 - (-result);
			}
			else if (result > 360.0)
			{
				var count:Number = result / 360.0;
				result = result - (int(count) * 360.0);
			}
			return result;
		}
		
		public static function fixDegrees(deg:Number):Number
		{
			var result:Number = deg;
			if (result < 0.0)
			{
				result = 360.0 - (-result);
			}
			else if (result > 360.0)
			{
				var count:Number = result / 360.0;
				result = result - (int(count) * 360.0);
			}
			if (result == 360.0)
			{
				result = 0;
			}
			return result;
		}
		
		//[Inline]
		public static function deg2rad(deg:Number):Number
		{
			return deg / 180.0 * Math.PI;
		}
		
		//[Inline]
		public static function rad2deg(rad:Number):Number
		{
			return rad / Math.PI * 180.0;
		}
		
		public static function polarDeg(len:Number, angleDeg:Number, result:Point = null):Point
		{
			if (result == null)
			{
				result = new Point();
			}
			result.x = Math.round(len * Math.cos(angleDeg * Math.PI / 180));
			result.y = Math.round(len * Math.sin(angleDeg * Math.PI / 180));
			
			return result;
		}
		
		public static function polarRad(len:Number, angleRad:Number, result:Point = null):Point
		{
			if (result == null)
			{
				result = new Point();
			}
			
			result.x = Math.round(len * Math.cos(angleRad));
			result.y = Math.round(len * Math.sin(angleRad));
			
			return result;
		}
		
		public static function polarFromDeg(startPoint:Point, len:Number, angleDeg:Number, result:Point = null):Point
		{
			var x:Number = startPoint.x;
			var y:Number = startPoint.y;
			result = polarDeg(len, angleDeg, result);
			result.offset(x, y);
			return result;
		}
		
		public static function polarFromRad(startPoint:Point, len:Number, angleRad:Number, result:Point = null):Point
		{
			var x:Number = startPoint.x;
			var y:Number = startPoint.y;
			result = polarRad(len, angleRad, result);
			result.offset(x, y);
			return result;
		}
		
		public function Math2()
		{
		
		}
	
	}

}