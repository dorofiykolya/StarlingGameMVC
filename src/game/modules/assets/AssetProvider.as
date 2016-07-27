package game.modules.assets
{
	import starling.textures.TextureOptions;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AssetProvider
	{
		private var _path:AssetPath;
		private var _value:Object;
		private var _options:TextureOptions;
		
		public function AssetProvider(options:TextureOptions, value:Object = null, path:AssetPath = null)
		{
			_options = options;
			_value = value;
			_path = path;
		}
		
		public function setValue(value:Object):AssetProvider
		{
			_value = value;
			return this;
		}
		
		public function setPath(path:AssetPath):AssetProvider
		{
			_path = path;
			return this;
		}
		
		public function getOptions():TextureOptions
		{
			return _options;
		}
		
		public function getValue():Object
		{
			if (_value != null)
			{
				return _value;
			}
			return _path.path;
		}
	
	}

}