package game.modules.animations.descriptions
{
	import common.system.Assert;
	import game.modules.uibuilder.IUIBuilderFactory;
	import game.modules.assets.IAssetProvider;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UIDescription implements IDescriptionFactory
	{
		public var layout:String;
		
		private var _properties:Vector.<PropertyValue>;
		private var _assetProvider:IAssetProvider;
		private var _uiBuilder:IUIBuilderFactory;
		
		public function UIDescription(assetProvider:IAssetProvider, uiBuilder:IUIBuilderFactory)
		{
			_uiBuilder = uiBuilder;
			_assetProvider = assetProvider;
			_properties = new Vector.<PropertyValue>();
		}
		
		/* INTERFACE game.locations.animations.descriptions.IDescriptionFactory */
		
		public function instantiate():DisplayObject
		{
			var result:Sprite = _uiBuilder.createByLayout(layout);
			Assert.notNull(result, "layout not found: " + layout);
			for each (var property:PropertyValue in _properties)
			{
				property.apply(result);
			}
			return result;
		}
		
		public function addProperty(name:String, value:String):void
		{
			MemberParser.add(_properties, Sprite, name, value);
		}
		
		public function get type():DescriptionType
		{
			return DescriptionType.UI;
		}
	
	}

}