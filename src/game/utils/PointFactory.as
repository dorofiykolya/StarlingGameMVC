package game.utils
{
    import common.system.Cache;
    import flash.geom.Point;
    
    /**
     * ...
     * @author dorofiy.com
     */
    public class PointFactory
    {
        private static const POOL:Vector.<Point> = new Vector.<Point>();
        private static var _week:Point = new Point();
        private static var _current:Point;
        
        public function PointFactory()
        {
        
        }
        
        public static function weak(x:Number = 0, y:Number = 0):Point
        {
            _week.x = x;
            _week.y = y;
            return _week;
        }
        
        public static function clone(point:Point):Point
        {
            return create(point.x, point.y);
        }
        
        public static function create(x:Number = 0, y:Number = 0):Point
        {
            if (POOL.length != 0)
            {
                _current = POOL.pop();
                _current.x = x;
                _current.y = y;
                return _current;
            }
            return new Point(x, y);
        }
        
        public static function disposeCollection(collection:Vector.<Point>):void
        {
            for (var i:int = 0; i < collection.length; i++) 
            {
                POOL[POOL.length] = collection[i];
            }
            collection.length = 0;
        }
        
        public static function dispose(point:Point):void
        {
            if (point)
            {
                POOL[POOL.length] = point;
            }
        }
    }
}