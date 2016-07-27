package game.modules.formats
{
	import common.context.IContext;
	import common.context.extensions.IExtension;
	import flash.globalization.NumberFormatter;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class FormatsExtension implements IExtension
	{
		
		public function FormatsExtension()
		{
		
		}
		
		/* INTERFACE common.context.extensions.IExtension */
		
		public function extend(context:IContext):void
		{
			context.install(TimeFormat);
			context.install(NumberFormat);
		}
	
	}

}