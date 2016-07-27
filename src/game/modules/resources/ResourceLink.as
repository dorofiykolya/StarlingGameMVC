package game.modules.resources
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ResourceLink
	{
		public var description:String;
		public var link:String;
		public var scale:Number;
		
		public function ResourceLink(link:String = null, scale:Number = 1.0, description:String = null)
		{
			this.description = description;
			this.link = link;
			this.scale = scale;
		}
	
	}

}