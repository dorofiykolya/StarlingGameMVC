package game.modules.localizations
{
	import common.events.IEventListener;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface ILocalizeBinder extends ILocalizeProvider, IEventListener
	{
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
		function bind(instance:Object, key:String, property:String = null, formatFunction:Function = null, before:Function = null, after:Function = null):void;
		function unbind(instance:Object, property:String = null):void
	}

}