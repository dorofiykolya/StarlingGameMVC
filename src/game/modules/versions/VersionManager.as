package game.modules.versions
{
	import common.system.text.StringUtil;
	import game.modules.applications.ApplicationManager;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class VersionManager
	{
		private var _description:ApplicationManager;
		
		public function VersionManager(description:ApplicationManager)
		{
			_description = description;
		}
		
		public function verify(version:String):Boolean
		{
			var descriptorVersion:String = _description.runtimeVersion;
			
			version = StringUtil.trim(version);
			descriptorVersion = StringUtil.trim(descriptorVersion);
			
			var majorSever:int = getMajor(version);
			var minorSever:int = getMinor(version);
			var revisionSever:int = getRevision(version);
			
			var majorClien:int = getMajor(descriptorVersion);
			var minorClien:int = getMinor(descriptorVersion);
			var revisionClien:int = getRevision(descriptorVersion);
			
			if (version != descriptorVersion)
			{
				if (majorClien < majorSever || (majorSever == majorClien) && minorClien < minorSever || (majorSever == majorClien) && (minorClien == minorSever) && revisionClien < revisionSever)
				{
					return false;
				}
			}
			return true;
		}
		
		private function getMajor(value:String):int
		{
			return parseInt(value.split(".")[0]);
		}
		
		private function getMinor(value:String):int
		{
			return parseInt(value.split(".")[1]);
		}
		
		private function getRevision(value:String):int
		{
			return parseInt(value.split(".")[2]);
		}
	
	}

}