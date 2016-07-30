package starling.extensions.utils
{
	import starling.display.DisplayObject;
	
	public class VerticalLayoutSupport extends LayoutSupport
	{
		private var _maxWidth:int;
		private var _lastCalculatedHeight:Number;
		
		public function VerticalLayoutSupport(gap:Number = 0, hAlign:String = AlignLayout.LEFT, vAlign:String = AlignLayout.TOP)
		{
			super(gap, hAlign, vAlign);
		}
		
		override public function validate(list:Vector.<DisplayObject>, contentWidth:Number, contentHeight:Number):void
		{
			var length:int = list.length;
			var position:int = 0;
			var displayObject:DisplayObject;
			var yGap:Number = gap;
			for (var i:int = 0; i < length; i++)
			{
				displayObject = list[i];
				displayObject.y = position;
				if (i == length -1) 
				{
					yGap = 0;
				}
				position += (displayObject.height + yGap);
				
			}
			_lastCalculatedHeight = position;
			
			if (hAlign == AlignLayout.LEFT || hAlign == AlignLayout.CENTER || hAlign == AlignLayout.RIGHT)
			{
				updateWidth(list);
			}
			super.validate(list, contentWidth, contentHeight);
		}
		
		private function updateWidth(list:Vector.<DisplayObject>):void
		{
			var length:int = list.length;
			var displayObject:DisplayObject;
			
			_maxWidth = 0;
			
			for (var i:int = 0; i < length; i++)
			{
				displayObject = list[i];
				if (displayObject.width > _maxWidth)
				{
					_maxWidth = displayObject.width;
				}
			}
			
			validateHorizontal(list);
		
		}
		
		private function validateHorizontal(list:Vector.<DisplayObject>):void
		{
			switch (hAlign)
			{
				case AlignLayout.LEFT: 
				{
					validateHorizontalLeft(list);
					break;
				}
				case AlignLayout.CENTER: 
				{
					validateHorizontalCenter(list);
					break;
				}
				case AlignLayout.RIGHT: 
				{
					validateHorizontalRight(list);
					break;
				}
			}
		}
		
		private function validateHorizontalLeft(list:Vector.<DisplayObject>):void
		{
			var length:int = list.length;
			
			for (var i:int = 0; i < length; i++)
			{
				list[i].x = 0;
			}
		}
		
		private function validateHorizontalCenter(list:Vector.<DisplayObject>):void
		{
			var length:int = list.length;
			var displayObject:DisplayObject;
			
			for (var i:int = 0; i < length; i++)
			{
				displayObject = list[i];
				displayObject.x = (_maxWidth - displayObject.width) / 2;
			}
		}
		
		private function validateHorizontalRight(list:Vector.<DisplayObject>):void
		{
			var length:int = list.length;
			var displayObject:DisplayObject;
			
			for (var i:int = 0; i < length; i++)
			{
				displayObject = list[i];
				displayObject.x = _maxWidth - displayObject.width;
			}
		}
		
		public function get lastCalculatedHeight():Number
		{
			return _lastCalculatedHeight;
		}
	}
}
