package game.modules.animations
{
	import common.composite.Component;
	import common.system.errors.NotImplementedError;
	import game.modules.assets.ITextureProvider;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AnimationComponent extends Component
	{
		
		public function AnimationComponent()
		{
			super();
		}
		
		public function get layers():Vector.<LayerViewer>
		{
			throw new NotImplementedError();
			return null;
		}
		
		public function get state():String
		{
			throw new NotImplementedError();
			return null;
		}
		
		public function setState(newState:String, startOver:Boolean = false, timeScale:Number = 1):void
		{
			throw new NotImplementedError();
		}
		
		public function get timeScale():Number
		{
			throw new NotImplementedError();
			return 0;
		}
		
		public function set timeScale(value:Number):void
		{
			throw new NotImplementedError();
		}
		
		public function get alpha():Number
		{
			throw new NotImplementedError();
			return 0;
		}
		
		public function set alpha(value:Number):void
		{
			throw new NotImplementedError();
		}
	}

}