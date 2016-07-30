package starling.extensions.utils
{
	import flash.geom.Rectangle;
	import starling.display.DisplayObject;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class FlowLayoutSupport extends LayoutSupport
	{
		private var _itemWidth:Number;
		private var _itemHeight:Number;
		private var _lastCalculatedHeight:Number;
		private var _vGap:Number;
		private var _hGap:Number;
		
		public function FlowLayoutSupport(itemWidth:Number, itemHeight:Number, gap:Number = 0, hAlign:String = AlignLayout.LEFT, vAlign:String = AlignLayout.TOP)
		{
			super(gap, hAlign, vAlign);
			_vGap = gap;
			_hGap = gap;
			_itemHeight = itemHeight;
			_itemWidth = itemWidth;
		}
		
		public function calculateHeight(children:Vector.<DisplayObject>, contentWidth:Number):Number
		{
			var num:int = children.length;
			var x:Number = 0;
			var y:Number = 0;
			for (var i:int = 0; i < num; i++)
			{
				x += _itemWidth + _hGap;
				if (x + _itemWidth > contentWidth && i != num - 1)
				{
					x = 0;
					y += _itemHeight + _vGap;
				}
				else if (i == num - 1)
				{
					y += _itemHeight;
				}
			}
			return y;
		}
		
		override public function validate(children:Vector.<DisplayObject>, contentWidth:Number, contentHeight:Number):void
		{
			contentHeight = layoutChildren(children, contentWidth, contentHeight);
			super.validate(children, contentWidth, contentHeight);
		}
		
		private function layoutChildren(children:Vector.<DisplayObject>, contentWidth:Number, contentHeight:Number):Number
		{
			var num:int = children.length;
			var child:DisplayObject;
			var x:Number = 0;
			var y:Number = 0;
			for (var i:int = 0; i < num; i++)
			{
				child = children[i];
				child.x = x;
				child.y = y;
				x += _itemWidth + _hGap;
				if (x + _itemWidth > contentWidth && i != num - 1)
				{
					x = 0;
					y += _itemHeight + _vGap;
				}
				else if (i == num - 1)
				{
					y += _itemHeight;
				}
			}
			_lastCalculatedHeight = y;
			return y;
		}
		
		public function get lastCalculatedHeight():Number
		{
			return _lastCalculatedHeight;
		}
		
		public function get vGap():Number
		{
			return _vGap;
		}
		
		public function set vGap(value:Number):void
		{
			_vGap = value;
		}
		
		public function get hGap():Number
		{
			return _hGap;
		}
		
		public function set hGap(value:Number):void
		{
			_hGap = value;
		}
	
	}

}