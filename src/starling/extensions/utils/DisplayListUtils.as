package starling.extensions.utils
{
	import feathers.controls.LayoutGroup;
	import feathers.controls.ScrollContainer;
	import feathers.display.Scale9Image;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.ImageBox;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.display.SpriteBox;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class DisplayListUtils
	{
		public function DisplayListUtils()
		{
		
		}
		
		public static function getByName(container:DisplayObjectContainer, ... names):DisplayObject
		{
			return getByNamePath(container, names);
		}
		
		public static function getByNamePath(container:DisplayObjectContainer, names:Array):DisplayObject
		{
			var result:DisplayObject;
			var current:DisplayObjectContainer = container;
			for each (var name:String in names)
			{
				result = current.getChildByName(name);
				current = result as DisplayObjectContainer;
			}
			return result;
		}
		
		public static function getTextField(container:DisplayObjectContainer, ... names):TextField
		{
			return TextField(getByNamePath(container, names));
		}
		
		public static function getImage(container:DisplayObjectContainer, ... names):Image
		{
			return Image(getByNamePath(container, names));
		}
		
		public static function getImageBox(container:DisplayObjectContainer, ... names):ImageBox
		{
			return ImageBox(getByNamePath(container, names));
		}
		
		public static function getSprite(container:DisplayObjectContainer, ... names):Sprite
		{
			return Sprite(getByNamePath(container, names));
		}
		
		public static function getSpriteBox(container:DisplayObjectContainer, ... names):SpriteBox
		{
			return SpriteBox(getByNamePath(container, names));
		}
		
		public static function getLayoutGroup(container:DisplayObjectContainer, ... names):LayoutGroup
		{
			return LayoutGroup(getByNamePath(container, names));
		}
		
		public static function getScrollContainer(container:DisplayObjectContainer, ... names):ScrollContainer
		{
			return ScrollContainer(getByNamePath(container, names));
		}
		
		public static function getMovieClip(container:DisplayObjectContainer, ... names):MovieClip
		{
			return MovieClip(getByNamePath(container, names));
		}
		
		public static function getScale9Image(container:DisplayObjectContainer, ... names):Scale9Image
		{
			return Scale9Image(getByNamePath(container, names));
		}
	}

}