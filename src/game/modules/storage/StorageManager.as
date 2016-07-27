package game.modules.storage
{
	import common.system.DictionaryMap;
	import flash.net.SharedObject;
	import game.modules.applications.ApplicationManager;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class StorageManager
	{
		private static const STORAGE:String = "storage";
		
		private var _app:ApplicationManager;
		private var _shared:SharedObject;
		private var _storage:Storage;
		
		public function StorageManager(applicationManager:ApplicationManager)
		{
			_app = applicationManager;
			_shared = SharedObject.getLocal(_app.applicationID);
			_shared.data[STORAGE] = {};
			_storage = new Storage(_shared.data, STORAGE, _shared);
		}
		
		public function save():void
		{
			_shared.flush(_shared.size);
		}
		
		public function map(... path):Storage
		{
			return _storage.map.apply(null, path);
		}
		
		public function getValue(property:String):Object
		{
			return _shared.data[STORAGE][property];
		}
		
		public function setValue(property:String, value:Object):void
		{
			_shared.data[STORAGE][property] = value;
			save();
		}
		
		public function deleteValue(property:String):void
		{
			delete _shared.data[STORAGE][property];
			save();
		}
	
	}

}