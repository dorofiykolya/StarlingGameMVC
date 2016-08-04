package game.modules.animations
{
	import common.system.Assert;
	import common.system.ClassType;
	import game.modules.assets.ITextureProvider;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AnimationProvider
	{
		[Inject]
		public var layerFactory:LayerFactory;
		[Inject]
		public var textureProvider:ITextureProvider;
		
		private var _defaultAnimation:Class;
		private var _map:Object;
		private var _mapType:Object;
		
		public function AnimationProvider()
		{
			_map = {};
			_mapType = {};
		}
		
		public function map(source:String, type:Class):void
		{
			Assert.subclassOf(type, AnimationComponent);
			_map[source] = type;
		}
		
		public function mapByType(type:String, typeClass:Class):void
		{
			Assert.subclassOf(typeClass, AnimationComponent);
			_mapType[type] = typeClass;
		}
		
		public function getAnimation(source:String):Class
		{
			return _map[source];
		}
		
		public function getAnimationByType(type:String):Class
		{
			return _mapType[type];
		}
		
		public function get defaultAnimation():Class
		{
			return _defaultAnimation;
		}
		
		public function set defaultAnimation(value:Class):void
		{
			Assert.subclassOf(value, AnimationComponent);
			_defaultAnimation = value;
		}
	}
}