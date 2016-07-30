package game.modules.localizations
{
	import common.events.IEventListener;
	
	[Event(name = "change", type = "common.events.Event")]
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface ILocalizationProvider extends IEventListener
	{
		function getByName(value:String):Localization;
		function getByLanguage(value:String):Localization;
	}

}