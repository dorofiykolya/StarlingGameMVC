package game.modules.animations.descriptions
{
	import common.system.Assert;
	import common.system.ClassType;
	import common.system.text.StringUtil;
	import game.modules.animations.descriptions.IDescriptionFactory;
	import game.modules.animations.descriptions.MemberParser;
	import game.modules.animations.descriptions.PropertyValue;
	import game.modules.assets.ITextureProvider;
	import starling.display.DisplayObject;
	import starling.display.ImageClip;
	import starling.display.MovieClip;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class FramesDescription implements IDescriptionFactory
	{
		private static const HELP_LIST:Vector.<Texture> = new Vector.<Texture>();
		private static const FPS_PROPERTY:String = "fps";
		
		private var _textureProvider:ITextureProvider;
		private var _texturesNames:Vector.<String>;
		private var _prefixTextures:Vector.<String>;
		private var _fps:Number;
		
		public var descriptions:Vector.<PropertyValue>;
		public var textures:Vector.<Texture>;
		
		public function FramesDescription(textureProvider:ITextureProvider)
		{
			descriptions = new Vector.<PropertyValue>();
			_textureProvider = textureProvider;
			_texturesNames = new Vector.<String>();
			_prefixTextures = new Vector.<String>();
		}
		
		public function addProperty(name:String, value:String):void
		{
			var result:PropertyValue = MemberParser.add(descriptions, MovieClip, name, value);
			if (result.name == FPS_PROPERTY)
			{
				_fps = Number(result.value);
			}
		}
		
		/* INTERFACE game.locations.animations.IDescriptionFactory */
		
		public function instantiate():DisplayObject
		{
			if (textures == null)
			{
				textures = new Vector.<Texture>(_texturesNames.length);
				var index:int = 0;
				var textureResult:Texture;
				
				for each (var prefix:String in _prefixTextures)
				{
					HELP_LIST.length = 0;
					_textureProvider.getTextures(prefix, HELP_LIST);
					index = fillTextures(index, textures, HELP_LIST);
				}
				
				for each (var texture:String in _texturesNames)
				{
					textures[index] = textureResult = _textureProvider.getTexture(texture);
					Assert.notNull(textureResult, StringUtil.format("texture not found: {0}", texture));
					index++;
				}
			}
			
			var fps:Number = !isNaN(_fps) && _fps > 0? _fps : 12;
			var imageClip:MovieClip = new MovieClip(textures, fps);
			for each (var item:PropertyValue in descriptions)
			{
				if (item.name != FPS_PROPERTY)
				{
					item.apply(imageClip);
				}
			}
			return imageClip;
		}
		
		private function fillTextures(index:int, result:Vector.<Texture>, add:Vector.<Texture>):int
		{
			for each (var texture:Texture in add) 
			{
				Assert.notNull(texture);
				result[result.length] = texture;
				index++;
			}
			return index;
		}
		
		public function addTexture(texture:String):void
		{
			_texturesNames[_texturesNames.length] = texture;
		}
		
		public function addTextures(prefix:String):void 
		{
			_prefixTextures[_prefixTextures.length] = prefix;
		}
		
		
		/* INTERFACE game.locations.animations.IDescriptionFactory */
		
		public function get type():DescriptionType 
		{
			return DescriptionType.CLIP;
		}
	
	}

}