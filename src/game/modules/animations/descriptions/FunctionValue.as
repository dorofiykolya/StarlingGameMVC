package game.modules.animations.descriptions 
{
	import game.modules.animations.descriptions.PropertyValue;
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class FunctionValue extends PropertyValue 
	{
		public function FunctionValue(name:String, value:Object) 
		{
			super(name, value);
		}
		
		override public function apply(target:Object):void 
		{
			if (name in target)
			{
				var func:Function = target[name] as Function;
				func.apply(null, value);
			}
		}
		
	}

}