package game.modules.assets
{
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.textures.TextureOptions;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface IAssetsManager
	{
		function addAsset(id:String, provider:AssetProvider):void;
		function addTextureAtlas(name:String, atlas:TextureAtlas):void;
		function addTexture(name:String, texture:Texture):void;
		function enqueue(... rawAssets):void;
		function enqueueWithName(asset:Object, name:String = null, options:TextureOptions = null):String;
		function getTexture(name:String):Texture;
		function getTextureAtlas(name:String):TextureAtlas;
		function getTextures(prefix:String = "", result:Vector.<Texture> = null):Vector.<Texture>;
		function loadQueue(onProgress:Function):void;
		function get isLoading():Boolean;
	}

}