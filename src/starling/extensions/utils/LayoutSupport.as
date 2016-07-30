package starling.extensions.utils
{
	import flash.geom.Rectangle;
	import starling.display.DisplayObject;
	
	public class LayoutSupport
	{
		private var _hAlign:String;
		private var _vAlign:String;
		private var _gap:Number;
		private var _valid:Boolean;
		private var _paddingLeft:Number;
		private var _paddingRight:Number;
		private var _paddingTop:Number;
		private var _paddingBottom:Number;
		
		/**
		 * Base class for set position of DisplayObject
		 */
		public function LayoutSupport(gap:Number = 0, hAlign:String = AlignLayout.LEFT, vAlign:String = AlignLayout.TOP)
		{
			_gap = gap;
			_hAlign = hAlign;
			_vAlign = vAlign;
			padding = 0;
		}
		
		public function get gap():Number
		{
			return _gap;
		}
		
		public function set gap(value:Number):void
		{
			_valid = false;
			_gap = value;
			invalidate();
		}
		
		public function get hAlign():String
		{
			return _hAlign;
		}
		
		public function set hAlign(value:String):void
		{
			_valid = false;
			_hAlign = value;
			invalidate();
		}
		
		public function get vAlign():String
		{
			return _vAlign;
		}
		
		public function set vAlign(value:String):void
		{
			_valid = false;
			_vAlign = value;
			invalidate();
		}
		
		public function get paddingLeft():Number
		{
			return _paddingLeft;
		}
		
		public function set paddingLeft(value:Number):void
		{
			_paddingLeft = value;
			invalidate();
		}
		
		public function get paddingRight():Number
		{
			return _paddingRight;
		}
		
		public function set paddingRight(value:Number):void
		{
			_paddingRight = value;
			invalidate();
		}
		
		public function get paddingTop():Number
		{
			return _paddingTop;
		}
		
		public function set paddingTop(value:Number):void
		{
			_paddingTop = value;
			invalidate();
		}
		
		public function get paddingBottom():Number
		{
			return _paddingBottom;
		}
		
		public function set paddingBottom(value:Number):void
		{
			_paddingBottom = value;
			invalidate();
		}
		
		public function set padding(value:Number):void
		{
			_paddingLeft = value;
			_paddingRight = value;
			_paddingTop = value;
			_paddingBottom = value;
			invalidate();
		}
		
		public function get valid():Boolean
		{
			return _valid;
		}
		
		public function invalidate():void
		{
			_valid = false;
		}
		
		public function validate(children:Vector.<DisplayObject>, contentWidth:Number, contentHeight:Number):void
		{
			if ((_vAlign != AlignLayout.NONE || _hAlign != AlignLayout.NONE) && (contentWidth == contentWidth || contentHeight == contentHeight))
			{
				validateAlign(children, getBounds(children), contentWidth, contentHeight);
			}
			_valid = true;
		}
		
		public function validateAlign(children:Vector.<DisplayObject>, bounds:Rectangle, contentWidth:Number, contentHeight:Number):void
		{
			var x:Number = 0.0;
			var y:Number = 0.0;
			if (contentWidth == contentWidth)
			{
				switch (_hAlign)
				{
					case AlignLayout.LEFT: 
					{
						x = _paddingLeft;
						break;
					}
					case AlignLayout.CENTER: 
					{
						if (isNaN(contentWidth))
						{
							x = (_paddingLeft - _paddingRight) / 2;
						}
						else
						{
							x = (contentWidth - bounds.width + _paddingLeft - _paddingRight) / 2;
						}
						break;
					}
					case AlignLayout.RIGHT: 
					{
						if (isNaN(contentWidth))
						{
							x = -paddingRight;
						}
						else
						{
							x = contentWidth - bounds.width - _paddingRight;
						}
						break;
					}
				}
			}
			
			if (contentHeight == contentHeight)
			{
				switch (_vAlign)
				{
					case AlignLayout.TOP: 
					{
						y = _paddingTop;
						break;
					}
					case AlignLayout.CENTER: 
					{
						if (isNaN(contentHeight))
						{
							y = (_paddingTop - _paddingBottom) / 2;
						}
						else
						{
							y = (contentHeight - bounds.height + _paddingTop - _paddingBottom) / 2;
						}
						break;
					}
					case AlignLayout.BOTTOM: 
					{
						if (isNaN(contentHeight))
						{
							y = -_paddingBottom;
						}
						else
						{
							y = contentHeight - bounds.height - _paddingBottom;
						}
						break;
					}
				}
			}
			if (x != 0.0 || y != 0.0)
			{
				for each (var child:DisplayObject in children)
				{
					child.x += x;
					child.y += y;
				}
			}
		}
		
		protected function getBounds(children:Vector.<DisplayObject>):Rectangle
		{
			var minX:Number = Number.MAX_VALUE, maxX:Number = -Number.MAX_VALUE;
			var minY:Number = Number.MAX_VALUE, maxY:Number = -Number.MAX_VALUE;
			var numChildren:int = children.length;
			var child:DisplayObject;
			var resultRect:Rectangle = new Rectangle();
			for (var i:int = 0; i < numChildren; ++i)
			{
				child = children[i];
				if (child.includeInParentBounds)
				{
					child.getBounds(child.parent, resultRect);
					minX = minX < resultRect.x ? minX : resultRect.x;
					maxX = maxX > resultRect.right ? maxX : resultRect.right;
					minY = minY < resultRect.y ? minY : resultRect.y;
					maxY = maxY > resultRect.bottom ? maxY : resultRect.bottom;
				}
			}
			
			resultRect.setTo(minX, minY, maxX - minX, maxY - minY);
			return resultRect;
		}
	}
}