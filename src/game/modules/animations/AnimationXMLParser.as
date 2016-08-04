package game.modules.animations
{
	import game.modules.animations.descriptions.FramesDescription;
	import game.modules.animations.descriptions.ImageDescription;
	import game.modules.animations.descriptions.LayerDescription;
	import game.modules.animations.descriptions.LayersDescription;
	import game.modules.animations.descriptions.ParticleDescription;
	import game.modules.animations.descriptions.SParticleDescription;
	import game.modules.animations.descriptions.StateDescription;
	import game.modules.animations.descriptions.StatesDescription;
	import game.modules.animations.descriptions.UIDescription;
	import game.modules.assets.IAssetProvider;
	import game.modules.assets.ITextureProvider;
	import game.modules.uibuilder.IUIBuilderFactory;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AnimationXMLParser implements IAnimationParser
	{
		private var _assetProvider:IAssetProvider;
		private var _uiBuilder:IUIBuilderFactory;
		
		public function AnimationXMLParser(textureProvider:IAssetProvider, uiBuilder:IUIBuilderFactory)
		{
			_uiBuilder = uiBuilder;
			_assetProvider = textureProvider;
		}
		
		public function parse(value:Object):LayersDescription
		{
			var xml:XML;
			if (value is XML) xml = XML(value);
			else if (value is String) xml = XML(value);
			else if (value is Class) xml = XML(new value);
			
			var layers:LayersDescription = new LayersDescription();
			layers.name = String(xml.@name);
			layers.type = String(xml.@type);
			for each (var layerXML:XML in xml.layer)
			{
				var layer:LayerDescription = new LayerDescription(String(layerXML.@name));
				for each (var childXML:XML in layerXML.children())
				{
					switch (childXML.localName())
					{
						case "image": 
							layer.add(getImage(childXML));
							break;
						case "frames": 
							layer.add(getFrames(childXML));
							break;
						case "states": 
							layer.add(getStates(childXML));
							break;
						case "particle":
							layer.add(getParticle(childXML));
							break;
						case "ui":
							layer.add(getUI(childXML));
							break;
						case "sparticle":
							layer.add(getSParticle(childXML));
							break;
					}
				}
				for each (var attribute:XML in layerXML.attributes())
				{
					layer.addProperty(String(attribute.name()), String(attribute));
				}
				layers.add(layer);
			}
			return layers;
		}
		
		private function getSParticle(xml:XML):SParticleDescription 
		{
			var result:SParticleDescription = new SParticleDescription(_assetProvider);
			result.name = String(xml.@name);
			for each (var attribute:XML in xml.attributes())
			{
				result.addProperty(String(attribute.name()), String(attribute));
			}
			result.textureName = String(xml);
			return result;
		}
		
		private function getUI(xml:XML):UIDescription
		{
			var result:UIDescription = new UIDescription(_assetProvider, _uiBuilder);
			for each (var attribute:XML in xml.attributes())
			{
				result.addProperty(String(attribute.name()), String(attribute));
			}
			result.layout = String(xml);
			return result;
		}
		
		private function getParticle(xml:XML):ParticleDescription 
		{
			var result:ParticleDescription = new ParticleDescription(_assetProvider);
			result.name = String(xml.@name);
			for each (var attribute:XML in xml.attributes())
			{
				result.addProperty(String(attribute.name()), String(attribute));
			}
			result.textureName = String(xml);
			return result;
		}
		
		private function getStates(xml:XML):StatesDescription
		{
			var result:StatesDescription = new StatesDescription(_assetProvider);
			for each (var s:XML in xml.state)
			{
				var state:StateDescription = new StateDescription(_assetProvider);
				state.name = String(s.@name);
				for each (var attribute:XML in s.attributes())
				{
					state.addProperty(String(attribute.name()), String(attribute));
				}
				for each (var frames:XML in s.frames)
				{
					state.addTextures(String(frames));
				}
				for each (var frame:XML in s.frame)
				{
					state.addTexture(String(frame));
				}
				
				result.addState(state);
			}
			for each (var xmlAttribute:XML in xml.attributes())
			{
				result.addProperty(String(xmlAttribute.name()), String(xmlAttribute));
			}
			return result;
		}
		
		private function getFrames(xml:XML):FramesDescription
		{
			var result:FramesDescription = new FramesDescription(_assetProvider);
			for each (var attribute:XML in xml.attributes())
			{
				result.addProperty(String(attribute.name()), String(attribute));
			}
			for each (var frames:XML in xml.frames)
			{
				result.addTextures(String(frames));
			}
			for each (var frame:XML in xml.frame)
			{
				result.addTexture(String(frame));
			}
			return result;
		}
		
		private function getImage(xml:XML):ImageDescription
		{
			var result:ImageDescription = new ImageDescription(_assetProvider);
			for each (var attribute:XML in xml.attributes())
			{
				result.add(String(attribute.name()), String(attribute));
			}
			result.textureName = String(xml);
			return result;
		}
	
	}

}