package game.modules.layouts
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface ILayoutProvider
	{
		function getLayout(value:Object):Object;
		function map(name:String, value:Object):void;
	}

}