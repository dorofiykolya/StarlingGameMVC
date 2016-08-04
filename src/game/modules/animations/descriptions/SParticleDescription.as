package game.modules.animations.descriptions
{
	import com.funkypandagame.stardustplayer.SDEConstants;
	import com.funkypandagame.stardustplayer.SimLoader;
	import com.funkypandagame.stardustplayer.SimPlayer;
	import com.funkypandagame.stardustplayer.emitter.EmitterBuilder;
	import com.funkypandagame.stardustplayer.emitter.EmitterValueObject;
	import com.funkypandagame.stardustplayer.project.ProjectValueObject;
	import game.modules.assets.IAssetProvider;
	import idv.cjcat.stardustextended.actions.Action;
	import idv.cjcat.stardustextended.actions.Spawn;
	import idv.cjcat.stardustextended.emitters.Emitter;
	import idv.cjcat.stardustextended.handlers.starling.StarlingHandler;
	import starling.display.DisplayObject;
	import starling.textures.SubTexture;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class SParticleDescription implements IDescriptionFactory
	{
		private var _properties:Vector.<PropertyValue>;
		private var _assetProvider:IAssetProvider;
		
		public var name:String;
		public var textureName:String;
		
		private var descriptorJSON:Object;
		private var rawEmitterDatas:Vector.<RawEmitterData> = new Vector.<RawEmitterData>();
		
		public function SParticleDescription(assetProvider:IAssetProvider)
		{
			_assetProvider = assetProvider;
			_properties = new Vector.<PropertyValue>();
		}
		
		public function instantiate():DisplayObject
		{
			var result:SParticleSystem = new SParticleSystem();
			if (rawEmitterDatas.length == 0)
			{
				onProjectAtlasLoaded(_assetProvider.getXml(name));
			}
			result.setProject(createProjectInstance());
			for each (var property:PropertyValue in _properties)
			{
				property.apply(result);
			}
			result.start();
			return result;
		}
		
		public function addProperty(name:String, value:String):void
		{
			MemberParser.add(_properties, SParticleSystem, name, value);
		}
		
		public function get type():DescriptionType
		{
			return DescriptionType.SPARTICLE;
		}
		
		private function onProjectAtlasLoaded(xml:XML):void
		{
			var rawData:RawEmitterData = new RawEmitterData();
			rawData.emitterID = name;
			rawData.emitterXML = xml;
			rawEmitterDatas.push(rawData);
		}
		
		public function createProjectInstance():ProjectValueObject
		{
			var project:ProjectValueObject = new ProjectValueObject(2.1);
			for each (var rawData:RawEmitterData in rawEmitterDatas)
			{
				var emitter:Emitter = EmitterBuilder.buildEmitter(rawData.emitterXML, rawData.emitterID);
				emitter.name = rawData.emitterID;
				var emitterVO:EmitterValueObject = new EmitterValueObject(emitter);
				project.emitters[rawData.emitterID] = emitterVO;
				if (rawData.snapshot)
				{
					emitterVO.emitterSnapshot = rawData.snapshot;
					emitterVO.addParticlesFromSnapshot();
				}
				var allTextures:Vector.<SubTexture> = new Vector.<SubTexture>();
				var textures:Vector.<Texture> = _assetProvider.getTextures(textureName);
				var len:uint = textures.length;
				for (var k:int = 0; k < len; k++)
				{
					allTextures.push(textures[k]);
				}
				StarlingHandler(emitterVO.emitter.particleHandler).setTextures(allTextures);
			}
			
			for each (var em:Emitter in project.emittersArr)
			{
				for each (var action:Action in em.actions)
				{
					if (action is Spawn && Spawn(action).spawnerEmitterId)
					{
						var spawnAction:Spawn = Spawn(action);
						for each (var emVO:EmitterValueObject in project.emitters)
						{
							if (spawnAction.spawnerEmitterId == emVO.id)
							{
								spawnAction.spawnerEmitter = emVO.emitter;
							}
						}
					}
				}
			}
			return project;
		}
	}
}
import flash.utils.ByteArray;

class RawEmitterData
{
	public var emitterID:String;
	public var emitterXML:XML;
	public var snapshot:ByteArray;
}