package game.utils
{
	import starling.display.DisplayObject;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class SortHelper
	{
		
		public function SortHelper()
		{
		
		}
		
		public static function quickSortDisplayObject(collection:Vector.<DisplayObject>):void
		{
			if (collection && collection.length > 1)
			{
				sortDisplayObject(collection, 0, collection.length - 1);
			}
		}
		
		public static function sortDisplayObjectFunction(child1:DisplayObject, child2:DisplayObject):int
		{
			return child1.y > child2.y ? 1 : -1;
		}
		
		private static function sortDisplayObject(array:Vector.<DisplayObject>, left:int, right:int, reverse:Boolean = false):void
		{
			var i:int = left;
			var j:int = right;
			var x:DisplayObject = array[int((left + right) >> 1)];
			do
			{
				if (reverse)
				{
					while (array[i].y > x.y)
						i++;
					while (array[j].y < x.y)
						j--;
				}
				else
				{
					while (array[i].y < x.y)
						i++;
					while (array[j].y > x.y)
						j--;
				}
				
				if (i <= j)
				{
					var temp:DisplayObject = array[i];
					array[i] = array[j];
					array[j] = temp;
					i++;
					j--;
				}
			} while (i < j);
			if (left < j)
				sortDisplayObject(array, left, j, reverse);
			if (i < right)
				sortDisplayObject(array, i, right, reverse);
		}
	}
}