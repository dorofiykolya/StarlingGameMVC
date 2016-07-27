package game.modules.assets
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	import common.context.links.Link;
	import game.modules.layouts.ILayoutProvider;
	import game.modules.layouts.LayoutProvider;
	import game.modules.uibuilder.IUIBuilderFactory;
	import game.modules.uibuilder.UIBuilderManager;
	import starlingbuilder.engine.IAssetMediator;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AssetExtension implements IExtension
	{
		
		public function AssetExtension()
		{
		
		}
		
		/* INTERFACE common.context.extensions.IExtension */
		
		public function extend(context:IContext):void
		{
			var assetManager:AssetsManager = new AssetsManager();
			var textureProvider:TextureProvider = new TextureProvider(assetManager);
			var assetMediator:AssetBuilderMediator = new AssetBuilderMediator(assetManager);
			
			context.install(new Link(assetManager, IAssetsManager, "assetManager"));
			context.install(new Link(assetManager, IAssetProvider, "assetProvider"));
			context.install(new Link(textureProvider, ITextureProvider, "textureProvider"));
			context.install(new Link(assetMediator, IAssetMediator, "assetMediator"));
			context.install(new Link(UIBuilderManager, IUIBuilderFactory, "layoutBuilder"));
			context.install(new Link(LayoutProvider, ILayoutProvider, "layoutProvider"));
		}
	
	}

}