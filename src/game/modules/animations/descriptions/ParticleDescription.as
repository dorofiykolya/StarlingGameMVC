package game.modules.animations.descriptions
{
	import common.system.Assert;
	import common.system.text.StringUtil;
	import game.modules.assets.IAssetProvider;
	import starling.display.DisplayObject;
	import starling.extensions.particles.GPDParticleSystem;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ParticleDescription implements IDescriptionFactory
	{
		private var _properties:Vector.<PropertyValue>;
		private var _assetProvider:IAssetProvider;
		
		public var name:String;
		public var textureName:String;
		
		public function ParticleDescription(asseProvider:IAssetProvider)
		{
			_properties = new Vector.<PropertyValue>();
			_assetProvider = asseProvider;
		}
		
		public function instantiate():DisplayObject
		{
			var xml:XML = _assetProvider.getXml(name);
			var texture:Texture = _assetProvider.getTexture(textureName);
			Assert.notNull(texture, StringUtil.format("texture not found: {0}", textureName));
			var result:GPDParticleSystem = new GPDParticleSystem(xml, _assetProvider.getTexture(textureName));
			for each (var property:PropertyValue in _properties)
			{
				property.apply(result);
			}
			result.start();
			return result;
		}
		
		public function addProperty(name:String, value:String):void
		{
			MemberParser.add(_properties, GPDParticleSystem, name, value);
		}
		
		public function get type():DescriptionType
		{
			return DescriptionType.PARTICLE;
		}
	
	}

}