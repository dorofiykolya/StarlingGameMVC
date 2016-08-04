package game.modules.animations.descriptions
{
	import game.modules.assets.ITextureProvider;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class StateDescription extends FramesDescription
	{
		public var name:String;
		
		public function StateDescription(textureProvider:ITextureProvider)
		{
			super(textureProvider);
		}
	}

}