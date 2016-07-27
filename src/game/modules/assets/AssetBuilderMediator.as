package game.modules.assets
{
	import starling.textures.Texture;
	import starlingbuilder.engine.IAssetMediator;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AssetBuilderMediator implements IAssetMediator
	{
		private var _assetProvider:IAssetProvider;
		
		public function AssetBuilderMediator(assetProvider:IAssetProvider)
		{
			_assetProvider = assetProvider;
		}
		
		/* INTERFACE starlingbuilder.engine.IAssetMediator */
		
		public function getTexture(name:String):Texture
		{
			return _assetProvider.getTexture(name);
		}
		
		public function getTextures(prefix:String = "", result:Vector.<Texture> = null):Vector.<Texture>
		{
			return _assetProvider.getTextures(prefix, result);
		}
		
		public function getExternalData(name:String):Object
		{
			return null;
		}
		
		public function getXml(name:String):XML
		{
			return _assetProvider.getXml(name);
		}
		
		public function getObject(name:String):Object
		{
			return _assetProvider.getObject(name);
		}
	
	}

}