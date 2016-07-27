package game.modules.assets 
{
	/**
	 * ...
	 * @author ...
	 */
	public class AssetPath 
	{
		private var _path:String;
		private var _alternative:Vector.<Path>;
		
		public function AssetPath(path:String) 
		{
			_path = path;
			_alternative = new Vector.<Path>();
		}
		
		public function addPath(path:String, validation:Function, priority:int = 0):AssetPath
		{
			_alternative.push(new Path(path, validation, priority));
			_alternative.sort(sort);
			return this;
		}
		
		public function get path():String
		{
			for each (var item:Path in _alternative) 
			{
				if (item != null)
				{
					if (item.validation())
					{
						return item.path;
					}
				}
			}
			return _path;
		}
		
		private function sort(d1:Path, d2:Path):int
		{
			if (d1.priority < d2.priority) 1;
			if (d1.priority > d2.priority) -1;
			return 0;
		}
		
	}

}

class Path
{
	public var path:String;
	public var validation:Function;
	public var priority:int;
	
	public function Path(path:String, validation:Function, priority:int)
	{
		this.path = path;
		this.validation = validation;
		this.priority = priority;
	}
}