package game.modules.animations.descriptions
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class PropertyValue
	{
		public var name:String;
		public var value:Object;
		
		public function PropertyValue(name:String, value:Object)
		{
			this.name = name;
			this.value = value;
		}
		
		public function apply(target:Object):void
		{
			if (name in target)
			{
				target[name] = value;
			}
		}
	
	}

}