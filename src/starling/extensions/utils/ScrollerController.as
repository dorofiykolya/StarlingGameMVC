package starling.extensions.utils
{
	import feathers.controls.Scroller;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ScrollerController
	{
		private var _container:Scroller;
		private var _enabled:Boolean;
		private var _itemWidth:int;
		private var _itemHeight:int;
		private var _isVertical:Boolean;
		private var _isHorizontal:Boolean;
		private var _isDynamicSize:Boolean;
		
		private var _len:int;
		private var _list:Vector.<DisplayObject>;
		private var _current:DisplayObject;
		private var _i:int;
		private var _scroll:Number;
		private var _containerSize:Number;
		private var _pos:Number;
		private var _threshold:Number;
		private var _customChildren:Vector.<DisplayObject>;
		private var _visibles:int;
		
		public function ScrollerController(scroller:Scroller, horizontal:Boolean = true)
		{
			_container = scroller;
			_threshold = 0;
			_container.addEventListener("scroll", onScroll);
			isHorizontal = horizontal;
			updateSizeByScrollerPage();
		}
		
		private function onScroll(e:Event):void
		{
			if (_enabled)
			{
				validate();
			}
		}
		
		public function validate():void
		{
			_list = _customChildren || DisplayObjectContainer(_container.viewPort).children;
			_len = _list.length;
			_visibles = 0;
			
			if (_isHorizontal)
			{
				_scroll = _container.horizontalScrollPosition;
				_containerSize = _container.width;// / _container.scaleX;
				for (_i = 0; _i < _len; _i++)
				{
					_current = _list[_i];
					_pos = _current.x;// / _container.scaleX;
					if (_isDynamicSize)
					{
						_itemWidth = _current.width;
					}
					_current.visible = _pos + _threshold + _itemWidth >= _scroll && _pos <= _scroll + _containerSize - _threshold;
					if (_current.visible)
					{
						_visibles++;
					}
				}
			}
			else
			{
				_scroll = _container.verticalScrollPosition;
				_containerSize = _container.height / _container.scaleY;
				for (_i = 0; _i < _len; _i++)
				{
					_current = _list[_i];
					_pos = _current.y;
					if (_isDynamicSize)
					{
						_itemHeight = _current.height;
					}
					_current.visible = _pos + _threshold + _itemHeight >= _scroll && _pos <= _scroll + _containerSize - _threshold;
					if (_current.visible)
					{
						_visibles++;
					}
				}
			}
		}
		
		public function updateSizeByScrollerPage():void
		{
			_enabled = _container.snapToPages;
			_itemWidth = _container.pageWidth;
			_itemHeight = _container.height;
		}
		
		public function setItemSize(width:Number, height:Number):void
		{
			_itemWidth = width;
			_itemHeight = height;
		}
		
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
		}
		
		public function get itemWidth():int
		{
			return _itemWidth;
		}
		
		public function set itemWidth(value:int):void
		{
			_itemWidth = value;
		}
		
		public function get itemHeight():int
		{
			return _itemHeight;
		}
		
		public function set itemHeight(value:int):void
		{
			_itemHeight = value;
		}
		
		public function get isVertical():Boolean
		{
			return _isVertical;
		}
		
		public function set isVertical(value:Boolean):void
		{
			_isVertical = value;
			_isHorizontal = !value;
		}
		
		public function get isHorizontal():Boolean
		{
			return _isHorizontal;
		}
		
		public function set isHorizontal(value:Boolean):void
		{
			_isHorizontal = value;
			_isVertical = !value;
		}
		
		public function get isDynamicSize():Boolean
		{
			return _isDynamicSize;
		}
		
		public function set isDynamicSize(value:Boolean):void
		{
			_isDynamicSize = value;
		}
		
		public function get itemsCount():int
		{
			if (!_container || !_container.children)
			{
				return 0;
			}
			return _container.children.length;
		}
		
		public function get threshold():Number 
		{
			return _threshold;
		}
		
		public function set threshold(value:Number):void 
		{
			_threshold = value;
		}
		
		public function get customChildren():Vector.<DisplayObject> 
		{
			return _customChildren;
		}
		
		public function set customChildren(value:Vector.<DisplayObject>):void 
		{
			_customChildren = value;
		}
		
		public function get visibles():int 
		{
			return _visibles;
		}
		
		public function get elements():int 
		{
			return _len;
		}
	
	}

}