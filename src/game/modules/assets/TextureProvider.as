package game.modules.assets
{
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class TextureProvider implements ITextureProvider
	{
		private var _assetManager:AssetsManager;
		
		public function TextureProvider(assetManager:AssetsManager)
		{
			_assetManager = assetManager;
		}
		
		/* INTERFACE game.modules.assets.ITextureProvider */
		
		public function getTexture(textureName:String):Texture
		{
			return _assetManager.getTexture(textureName);
		}
		
		public function getTextures(prefix:String = "", result:Vector.<Texture> = null):Vector.<Texture>
		{
			return _assetManager.getTextures(prefix, result);
		}
	
	}

}