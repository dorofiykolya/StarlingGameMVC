package starling.extensions.utils
{
	import starling.display.DisplayObject;
	
	public class HorizontalLayoutSupport extends LayoutSupport
	{
		private var _maxHeight:int;
		
		public function HorizontalLayoutSupport(gap:Number = 0, hAlign:String = AlignLayout.LEFT, vAlign:String = AlignLayout.TOP)
		{
			super(gap, hAlign, vAlign);
		}
		
		override public function validate(list:Vector.<DisplayObject>, contentWidth:Number, contentHeight:Number):void
		{
			var length:int = list.length;
			var position:int = 0;
			var displayObject:DisplayObject;
			for (var i:int = 0; i < length; i++)
			{
				displayObject = list[i];
				displayObject.x = position;
				position += displayObject.width + gap;
			}
			
			if (vAlign == AlignLayout.TOP || vAlign == AlignLayout.CENTER || vAlign == AlignLayout.BOTTOM)
			{
				updateHeight(list);
			}
			super.validate(list, contentWidth, contentHeight);
		}
		
		private function updateHeight(list:Vector.<DisplayObject>):void
		{
			var length:int = list.length;
			var displayObject:DisplayObject;
			_maxHeight = 0;
			for (var i:int = 0; i < length; i++)
			{
				displayObject = list[i];
				if (displayObject.height > _maxHeight)
				{
					_maxHeight = displayObject.height;
				}
			}
			validateVertical(list);
		}
		
		private function validateVertical(list:Vector.<DisplayObject>):void
		{
			switch (vAlign)
			{
				case AlignLayout.TOP: 
				{
					validateVerticalTop(list);
					break;
				}
				case AlignLayout.CENTER: 
				{
					validateVerticalCenter(list);
					break;
				}
				case AlignLayout.BOTTOM: 
				{
					validateVerticalBottom(list);
					break;
				}
			}
		}
		
		private function validateVerticalTop(list:Vector.<DisplayObject>):void
		{
			var length:int = list.length;
			
			for (var i:int = 0; i < length; i++)
			{
				list[i].y = 0;
			}
		}
		
		private function validateVerticalCenter(list:Vector.<DisplayObject>):void
		{
			var length:int = list.length;
			var displayObject:DisplayObject;
			
			for (var i:int = 0; i < length; i++)
			{
				displayObject = list[i];
				displayObject.y = (_maxHeight - displayObject.height) / 2;
			}
		}
		
		private function validateVerticalBottom(list:Vector.<DisplayObject>):void
		{
			var length:int = list.length;
			var displayObject:DisplayObject;
			
			for (var i:int = 0; i < length; i++)
			{
				displayObject = list[i];
				displayObject.y = _maxHeight - displayObject.height;
			}
		}
	}
}
