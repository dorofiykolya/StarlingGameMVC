package game.modules.assets
{
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface ITextureProvider
	{
		function getTexture(textureName:String):Texture;
		function getTextures(prefix:String = "", result:Vector.<Texture> = null):Vector.<Texture>;
	}

}