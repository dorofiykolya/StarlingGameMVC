package game.utils
{
	import common.system.text.StringUtil;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Point3 extends Point
	{
		private static const _week:Point3 = new Point3();
		
		public static function week(x:Number = 0, y:Number = 0, z:Number = 0):Point3
		{
			_week.setTo3(x, y, z);
			return _week;
		}
		
		public var z:Number;
		
		public function Point3(x:Number = 0, y:Number = 0, z:Number = 0)
		{
			this.z = z;
			this.y = y;
			this.x = x;
		}
		
		public override function subtract(point:Point):flash.geom.Point
		{
			var point3:Point3 = point as Point3;
			if (point3)
			{
				return new Point3(x - point3.x, y - point3.y, z - point3.z);
			}
			return new Point3(x - point.x, y - point.y, z);
			super.subtract
		}
		
		public override function add(point:Point):Point
		{
			var point3:Point3 = point as Point3;
			if (point3)
			{
				return new Point3(x + point3.x, y + point3.y, z + point3.z);
			}
			return new Point3(x + point.x, y + point.y, z);
		}
		
		public function offset3(offset:Point3):void
		{
			x += offset.x;
			y += offset.y;
			z += offset.z;
		}
		
		public function setTo3(x:Number = 0, y:Number = 0, z:Number = 0):void
		{
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		public override function copyFrom(point:Point):void
		{
			x = point.x;
			y = point.y;
			if (point is Point3)
			{
				z = Point3(point).z;
			}
		}
		
		public override function equals(toCompare:Point):Boolean
		{
			var other:Point3 = toCompare as Point3;
			if (other)
			{
				return x == other.x && y == other.y && z == other.z;
			}
			return super.equals(toCompare);
		}
		
		public override function toString():String
		{
			return StringUtil.format("[Point3(x={0},y={1},z={2})]", x, y, z);
		}
	
	}

}