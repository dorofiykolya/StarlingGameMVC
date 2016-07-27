package game.mvc.view.starling
{
	import common.system.Assert;
	import game.mvc.view.ILayer;
	import game.mvc.view.ILayers;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class StarlingLayers implements ILayers
	{
		private var _starling:Starling;
		private var _root:Sprite;
		private var _tempList:Vector.<StarlingLayer>;
		private var _touchable:Boolean = true;
		
		public function StarlingLayers(starling:Starling)
		{
			_starling = starling;
			if (_starling.root != null)
			{
				_root = Sprite(_starling.root);
			}
			else
			{
				_tempList = new Vector.<StarlingLayer>();
				_starling.addEventListener(Event.ROOT_CREATED, onRootCreated);
			}
		}
		
		private function onRootCreated(e:Event):void
		{
			_starling.removeEventListener(Event.ROOT_CREATED, onRootCreated);
			_root = Sprite(_starling.root);
			for each (var item:StarlingLayer in _tempList)
			{
				_root.addChild(item);
			}
			updateTouchable();
			_tempList = null;
		}
		
		/* INTERFACE game.view.ILayers */
		
		public function getLayer(index:int):ILayer
		{
			Assert.isTrue(index >= 0 && index < 10);
			
			while (index >= numChildren)
			{
				addChild(new StarlingLayer());
			}
			return getChildAt(index) as StarlingLayer;
		}
		
		private function get numChildren():int 
		{
			if (_tempList != null) return _tempList.length;
			return _root.numChildren;
		}
		
		/* INTERFACE game.view.ILayers */
		
		public function get touchable():Boolean 
		{
			return _touchable;
		}
		
		public function set touchable(value:Boolean):void 
		{
			_touchable = value;
			updateTouchable();
		}
		
		private function updateTouchable():void
		{
			if (_root != null)
			{
				_root.touchable = _touchable;
			}
		}
		
		private function addChild(value:DisplayObject):void
		{
			if (_tempList != null)
			{
				_tempList.push(value);
			}
			else
			{
				_root.addChild(value);
			}
		}
		
		private function getChildAt(index:int):DisplayObject
		{
			if (_tempList != null)
			{
				return _tempList[index];
			}
			return _root.getChildAt(index);
		}
	
	}

}