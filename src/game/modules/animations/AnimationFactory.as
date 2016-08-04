package game.modules.animations
{
	import common.composite.Component;
	import game.modules.animations.descriptions.LayersDescription;
	import game.modules.assets.ITextureProvider;
	import starling.animation.Juggler;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AnimationFactory
	{
		private var _animationProvider:AnimationProvider;
		
		public var layerFactory:LayerFactory;
		public var juggler:Juggler;
		public var textureProvider:ITextureProvider;
		
		public function AnimationFactory(animationProvider:AnimationProvider, juggler:Juggler)
		{
			this._animationProvider = animationProvider;
			this.juggler = juggler;
			this.textureProvider = animationProvider.textureProvider;
			this.layerFactory = animationProvider.layerFactory;
		}
		
		public function instantiate(source:String):AnimationComponent
		{
			var type:Class = _animationProvider.getAnimation(source);
			if (type == null) 
			{
				var descr:LayersDescription = layerFactory.getDescription(source);
				if (descr)
				{
					type = _animationProvider.getAnimationByType(descr.type);
				}
			}
			if (type == null)
			{
				type = _animationProvider.defaultAnimation;
			}
			
			var animation:AnimationComponent = AnimationComponent(Component.instantiate(Class(type)));
			return animation;
		}
	}
}