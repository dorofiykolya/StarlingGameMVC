package game.modules.applications
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ApplicationManager
	{
		private var _appDescription:IApplicationDescription;
		private var _nativeApplication:NativeApplicationManager;
		private var _supportNative:Boolean;
		
		public function ApplicationManager(applicationDescription:IApplicationDescription = null)
		{
			_nativeApplication = new NativeApplicationManager();
			_supportNative = _nativeApplication.support;
			if (_supportNative || applicationDescription == null)
			{
				_appDescription = _nativeApplication;
			}
			else
			{
				_appDescription = applicationDescription;
			}
		}
		
		/* DELEGATE game.modules.applications.IApplicationDescription */
		
		public function get applicationDescriptor():XML
		{
			return _appDescription.applicationDescriptor;
		}
		
		public function get applicationID():String
		{
			return _appDescription.applicationID;
		}
		
		public function get runtimeVersion():String
		{
			return _appDescription.runtimeVersion;
		}
		
		public function exit(errorCode:int = 0):void
		{
			if (_supportNative)
			{
				_nativeApplication.exit(errorCode);
			}
		}
	}
}