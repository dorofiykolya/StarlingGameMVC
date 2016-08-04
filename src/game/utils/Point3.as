package game.utils
{
	import common.system.IEquatable;
	import common.system.text.StringUtil;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Point3 implements IEquatable
	{
		public var z:Number;
		public var y:Number;
		public var x:Number;
		
		public function Point3(x:Number = 0, y:Number = 0, z:Number = 0)
		{
			this.z = z;
			this.y = y;
			this.x = x;
		}
		
		public function substract(point3:Point3):Point3
		{
			return new Point3(x - point3.x, y - point3.y, z - point3.z);
		}
		
		public function add(point3:Point3):Point3
		{
			return new Point3(x + point3.x, y + point3.y, z + point3.z);
		}
		
		public function offset(offset:Point3):void
		{
			x += offset.x;
			y += offset.y;
			z += offset.z;
		}
		
		public function setTo(x:Number = 0, y:Number = 0, z:Number = 0):void
		{
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		public function copyFrom(point3:Point3):void
		{
			x = point3.x;
			y = point3.y;
			z = point3.z;
		}
		
		public function toPoint():Point
		{
			return new Point(x, y);
		}
		
		public function equals(value:Object):Boolean
		{
			var other:Point3 = value as Point3;
			if (other)
			{
				return x == other.x && y == other.y && z == other.z;
			}
			return false;
		}
		
		public function toString():String
		{
			return StringUtil.format("[Point3(x={0},y={1},z={2})]", x, y, z);
		}
	
	}

}