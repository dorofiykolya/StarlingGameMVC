package game.modules.localizations
{
	import common.events.Event;
	import common.events.EventDispatcher;
	import common.events.IEventDispatcher;
	import common.system.DictionaryMap;
	import common.system.collection.Enumerator;
	import common.system.collection.IEnumerator;
	import common.system.collection.KeyValuePair;
	import flash.utils.Dictionary;
	
	[Event(name = "localizationEvent.change", type = "game.modules.localizations.LocalizationEvent")]
	
	public class LocalizationManager extends EventDispatcher implements ILocalizeBinder
	{
		//--------------------------------------------------------------------------
		//     
		//	PRIVATE CONSTANTS 
		//     
		//--------------------------------------------------------------------------
		
		private static const TEXT:String = "text";
		private static const LABEL:String = "label";
		private static const TOOLTIP:String = "toolTip";
		private static const TITLE:String = "title";
		
		//--------------------------------------------------------------------------
		//     
		//	PUBLIC VARIABLES 
		//     
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//     
		//	PRIVATE VARIABLES 
		//     
		//--------------------------------------------------------------------------
		
		private var _eventDispatcher:IEventDispatcher;
		private var _records:Dictionary;
		private var _localizationProvider:ILocalizationProvider;
		private var _textBinder:DictionaryMap;
		private var _properties:Vector.<String>;
		private var _name:String;
		private var _language:String;
		
		//----------------------------------
		//	CONSTRUCTOR
		//----------------------------------
		
		public function LocalizationManager(eventDispatcher:IEventDispatcher, provider:ILocalizationProvider = null)
		{
			_eventDispatcher = eventDispatcher;
			_localizationProvider = provider;
			_records = new Dictionary();
			_textBinder = new DictionaryMap();
			_properties = new <String>[null, TEXT, LABEL, TITLE, TOOLTIP];
			
			if (provider)
			{
				provider.addEventListener(Event.CHANGE, onProviderChange);
			}
		}
		
		//--------------------------------------------------------------------------
		//     
		//	PUBLIC SECTION 
		//     
		//--------------------------------------------------------------------------
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{
			updateLocalization(_localizationProvider.getByName(value));
		}
		
		public function get language():String
		{
			return _language;
		}
		
		public function set language(value:String):void
		{
			updateLocalization(_localizationProvider.getByLanguage(value));
		}
		
		public function update(map:ILocalizationProvider = null):void
		{
			if (map != null)
			{
				if (_localizationProvider != null)
				{
					_localizationProvider.removeEventListener(Event.CHANGE, onProviderChange);
				}
				_localizationProvider = map;
				_localizationProvider.addEventListener(Event.CHANGE, onProviderChange);
			}
			updateContent();
		}
		
		public function localize(key:String):String
		{
			if (key in _records)
				return _records[key];
			
			return key;
		}
		
		/**
		 *
		 * @param	instance
		 * @param	key
		 * @param	property
		 * @param	foramtFunction example: function(value:String = "text"):String { return value + ";"};
		 * @param	size - apply to instance when change
		 * @param	before - function(instance:Object, key:String, property:String):void {}
		 * @param	after - function(instance:Object, key:String, property:String):void {}
		 */
		public function bind(instance:Object, key:String, property:String = null, formatFunction:Function = null, before:Function = null, after:Function = null):void
		{
			var findedProperty:String = findProperty(instance, property);
			if (findedProperty != null)
			{
				var entry:Entry = new Entry();
				entry.key = key;
				entry.property = findedProperty;
				entry.format = formatFunction;
				entry.before = before;
				entry.after = after;
				
				_textBinder.map(instance, findedProperty).value = entry;
				updateObject(entry, instance, localize);
			}
		}
		
		public function unbind(instance:Object, property:String = null):void
		{
			if (property != null)
			{
				_textBinder.map(instance, property).value = null;
			}
			else
			{
				_textBinder.clear(instance);
			}
		}
		
		//--------------------------------------------------------------------------
		//     
		//	PRIVATE SECTION 
		//     
		//--------------------------------------------------------------------------
		
		private function onProviderChange(e:Event):void
		{
			updateContent();
		}
		
		private function findProperty(instance:Object, property:String):String
		{
			_properties[0] = property;
			for each (var item:String in _properties)
			{
				if (item && item in instance)
				{
					return item;
				}
			}
			return null;
		}
		
		private function updateContent():void
		{
			updateFrom(_textBinder, localize);
			dispatchEventAs(LocalizationEvent, LocalizationEvent.CHANGE);
			_eventDispatcher.dispatchEventAs(LocalizationEvent, LocalizationEvent.CHANGE);
		}
		
		private function updateFrom(dictionary:DictionaryMap, funcProvider:Function):void
		{
			var instance:Object;
			var current:Entry;
			
			var enumerator:IEnumerator = dictionary.getEnumerator();
			while (enumerator.moveNext())
			{
				var pair:KeyValuePair = KeyValuePair(enumerator.current);
				instance = pair.key;
				var instanceEnumarator:IEnumerator = DictionaryMap(pair.value).getEnumerator();
				while (instanceEnumarator.moveNext())
				{
					current = Entry(DictionaryMap(KeyValuePair(instanceEnumarator.current).value).value);
					updateObject(current, instance, funcProvider);
				}
			}
		}
		
		private function updateObject(entry:Entry, instance:Object, funcProvider:Function):void
		{
			if (Boolean(entry.before))
			{
				entry.before(instance, entry.key, entry.property);
			}
			if (Boolean(entry.format))
			{
				instance[entry.property] = entry.format(funcProvider(entry.key));
			}
			else
			{
				instance[entry.property] = funcProvider(entry.key);
			}
			if (Boolean(entry.after))
			{
				entry.after(instance, entry.key, entry.property);
			}
		}
		
		private function updateLocalization(record:Localization):void
		{
			_name = record.name;
			_language = record.language;
			for each (var item:LocalizationValue in record.localization)
			{
				_records[item.id] = item.value;
			}
			updateContent();
		}
	}
}

class Entry
{
	public var key:Object;
	public var property:String;
	public var format:Function;
	public var before:Function;
	public var after:Function;
}