package game.modules.animations.descriptions
{
	import common.system.Assert;
	import common.system.ClassType;
	import common.system.text.StringUtil;
	import game.modules.animations.descriptions.PropertyValue;
	import game.modules.assets.ITextureProvider;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ImageDescription implements IDescriptionFactory
	{
		public var provider:ITextureProvider;
		public var descriptions:Vector.<PropertyValue>;
		public var texture:Texture;
		public var textureName:String;
		
		public function ImageDescription(textureProvider:ITextureProvider)
		{
			provider = textureProvider;
			descriptions = new Vector.<PropertyValue>();
		}
		
		public function instantiate():DisplayObject
		{
			if (texture == null)
			{
				texture = provider.getTexture(textureName);
				Assert.notNull(texture, StringUtil.format("texture not found: {0}", textureName));
			}
			var result:Image = new Image(texture);
			for each (var item:PropertyValue in descriptions)
			{
				item.apply(result);
			}
			return result;
		}
		
		public function add(name:String, value:String):void
		{
			MemberParser.add(descriptions, Image, name, value);
		}
		
		/* INTERFACE game.locations.animations.IDescriptionFactory */
		
		public function get type():DescriptionType
		{
			return DescriptionType.IMAGE;
		}
	
	}

}