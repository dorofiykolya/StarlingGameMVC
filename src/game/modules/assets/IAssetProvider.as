package game.modules.assets
{
	import flash.media.Sound;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface IAssetProvider extends ITextureProvider
	{
		function getObject(name:String):Object;
		function getXml(name:String):XML;
		function getSound(name:String):Sound;
		function getByteArray(name:String):ByteArray;
		function get assetsPath():String;
		function get soundsPath():String;
		function getAssetsFilePath(fileName:String):String;
		function getSoundsFilePath(fileName:String):String;
	}

}