package game.modules.uibuilder
{
	import flash.utils.Dictionary;
	import game.modules.layouts.ILayoutProvider;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starlingbuilder.engine.IAssetMediator;
	import starlingbuilder.engine.UIBuilder;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class UIBuilderManager implements IUIBuilderFactory
	{
		[Inject]
		public var assetMediator:IAssetMediator;
		[Inject]
		public var layoutProvider:ILayoutProvider;
		
		private var _builder:UIBuilder;
		private var _mapLayout:Dictionary;
		private var _mapResult:Dictionary;
		
		public function UIBuilderManager()
		{
			_mapLayout = new Dictionary();
			_mapResult = new Dictionary();
		}
		
		/* INTERFACE game.modules.uibuilder.IUIBuilderManager */
		
		public function createByLayout(layout:Object):Sprite
		{
			if (_builder == null)
			{
				_builder = new UIBuilder(assetMediator);
			}
			
			var list:Vector.<DisplayObject> = _mapResult[layout];
			if (list != null && list.length != 0)
			{
				return Sprite(list.pop());
			}
			
			var json:Object = layoutProvider.getLayout(layout);
			var result:Sprite = _builder.create(json, false) as Sprite;
			_mapLayout[result] = layout;
			return result;
		}
		
		/* INTERFACE game.modules.uibuilder.IUIBuilderManager */
		
		public function disposeLayout(result:DisplayObject):void
		{
			if (result != null)
			{
				var layout:Object = _mapLayout[result];
				var list:Vector.<DisplayObject> = _mapResult[layout];
				if (list == null)
				{
					list = new Vector.<DisplayObject>();
					_mapResult[layout] = list;
				}
				list[list.length] = result;
				result.removeFromParent();
			}
		}
	}
}