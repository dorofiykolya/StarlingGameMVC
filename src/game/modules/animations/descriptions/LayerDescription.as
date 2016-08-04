package game.modules.animations.descriptions
{
	import common.system.text.SplitFlags;
	import common.system.text.StringUtil;
	import game.modules.animations.LayerViewer;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LayerDescription
	{
		public var _properties:Vector.<PropertyValue>;
		private var _descriptions:Vector.<IDescriptionFactory>;
		private var _name:String;
		private var _flags:Vector.<String>;
		
		public function LayerDescription(name:String)
		{
			_name = name;
			_descriptions = new Vector.<IDescriptionFactory>();
			_properties = new Vector.<PropertyValue>();
		}
		
		public function addProperty(name:String, value:String):void
		{
			if (name == "flags")
			{
				if (!StringUtil.isEmpty(value))
				{
					_flags = StringUtil.split(value, ",", uint.MAX_VALUE, SplitFlags.REMOVE_EMPTY | SplitFlags.REMOVE_WHITESPACE | SplitFlags.TRIM);
				}
			}
			else
			{
				MemberParser.add(_properties, LayerViewer, name, value);
			}
		}
		
		public function add(description:IDescriptionFactory):void
		{
			_descriptions[_descriptions.length] = description;
		}
		
		public function instantiate():LayerViewer
		{
			_descriptions.fixed = true;
			var result:LayerViewer = new LayerViewer(_name);
			for each (var item:IDescriptionFactory in _descriptions)
			{
				result.add(item.type, item.instantiate());
			}
			
			for each (var property:PropertyValue in _properties)
			{
				property.apply(result);
			}
			if (_flags)
			{
				for each (var flag:String in _flags) 
				{
					result.setFlag(flag);
				}
			}
			
			return result;
		}
		
		public function get name():String
		{
			return _name;
		}
	
	}

}