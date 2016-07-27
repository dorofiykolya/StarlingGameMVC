package game.modules.preloaders 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public interface IPreloaderViewMediator 
	{
		function getView():DisplayObject;
		function setProgress(ratio:Number):void;
		function setMessage(message:String):void;
		function close():void;
		function open():void;
		function setContainer(root:DisplayObjectContainer):void;
	}
	
}