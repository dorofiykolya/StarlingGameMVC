package game.modules.animations.descriptions
{
	import game.modules.animations.StateImageClip;
	import game.modules.animations.descriptions.StateDescription;
	import game.modules.assets.ITextureProvider;
	import starling.display.DisplayObject;
	import starling.display.MovieClip;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class StatesDescription implements IDescriptionFactory
	{
		private var _textureProvider:ITextureProvider;
		private var _properties:Vector.<PropertyValue>;
		public var states:Vector.<StateDescription>;
		
		public function StatesDescription(textureProvider:ITextureProvider)
		{
			_textureProvider = textureProvider;
			_properties = new Vector.<PropertyValue>();
			states = new Vector.<StateDescription>();
		}
		
		public function instantiate():DisplayObject
		{
			var result:StateImageClip = new StateImageClip();
			for each (var item:StateDescription in states)
			{
				result.map(item.name, MovieClip(item.instantiate()));
			}
			for each (var property:PropertyValue in _properties)
			{
				property.apply(result);
			}
			return result;
		}
		
		public function addState(state:StateDescription):void
		{
			states[states.length] = state;
		}
		
		public function addProperty(name:String, value:String):void
		{
			MemberParser.add(_properties, StateImageClip, name, value);
		}
		
		/* INTERFACE game.locations.animations.IDescriptionFactory */
		
		public function get type():DescriptionType
		{
			return DescriptionType.STATE;
		}
	
	}

}