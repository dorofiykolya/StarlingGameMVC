package game.modules.animations.descriptions
{
	import common.system.Enum;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class DescriptionType extends Enum
	{
		public static const IMAGE:DescriptionType = new DescriptionType(0);
		public static const CLIP:DescriptionType = new DescriptionType(1);
		public static const STATE:DescriptionType = new DescriptionType(2);
		public static const PARTICLE:DescriptionType = new DescriptionType(3);
		public static const UI:DescriptionType = new DescriptionType(4);
		public static const SPARTICLE:DescriptionType = new DescriptionType(5);
		
		public function DescriptionType(value:int)
		{
			super(value);
		}
	
	}

}