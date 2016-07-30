package game.modules.localizations
{
	import common.events.Event;
	import common.events.EventDispatcher;
	import common.events.IEventDispatcher;
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
		private var _textBinder:Dictionary;
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
			_textBinder = new Dictionary();
			_properties = new <String>[null, TEXT, LABEL];
			
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
		 * @param	foramtFunction example: function(value:String = "text"):String { return value + ";"};
		 */
		public function bindToolTip(instance:Object, key:String, foramtFunction:Function = null):void
		{
			var has:Boolean = TOOLTIP in instance;
			if (has)
			{
				_textBinder[instance] = {key: key, property: TOOLTIP, format: foramtFunction};
				var hasFormat:Boolean = foramtFunction != null;
				if (hasFormat)
				{
					instance[TOOLTIP] = foramtFunction(localize(key));
				}
				else
				{
					instance[TOOLTIP] = localize(key);
				}
			}
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
			var info:Object;
			_textBinder[instance] = info = {key: key, property: property, format: formatFunction, before: before, after: after};
			updateObject(info, instance, localize);
		}
		
		public function unbind(instance:Object):void
		{
			delete _textBinder[instance];
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
		
		private function updateContent():void
		{
			updateFrom(_textBinder, localize);
			dispatchEventAs(LocalizationEvent, LocalizationEvent.CHANGE);
			_eventDispatcher.dispatchEventAs(LocalizationEvent, LocalizationEvent.CHANGE);
		}
		
		private function updateFrom(dictionary:Dictionary, funcProvider:Function):void
		{
			var instance:Object;
			var current:Object;
			for (instance in dictionary)
			{
				current = dictionary[instance];
				updateObject(current, instance, funcProvider);
			}
		}
		
		private function updateObject(currentInfo:Object, instance:Object, funcProvider:Function):void
		{
			var key:Object;
			var property:String;
			var before:Function;
			var after:Function;
			var format:Function;
			
			property = currentInfo.property;
			format = currentInfo.format;
			before = currentInfo.before;
			after = currentInfo.after;
			_properties[0] = property;
			for each (property in _properties)
			{
				if (property && property in instance)
				{
					if (Boolean(before))
					{
						before(instance, currentInfo.key, property);
					}
					if (Boolean(format))
					{
						instance[property] = format(funcProvider(currentInfo.key));
					}
					else
					{
						instance[property] = funcProvider(currentInfo.key);
					}
					if (Boolean(after))
					{
						after(instance, currentInfo.key, property);
					}
					break;
				}
				else if (property)
				{
					var instanceName:String = "name" in instance ? instance.name : "";
					trace(instance + ": " + instanceName + " has not property:" + property);
				}
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