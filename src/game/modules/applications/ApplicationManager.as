package game.modules.applications
{
	import common.system.Environment;
	import flash.display.Stage;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import game.configurations.Configuration;
	import game.modules.alert.AlertManager;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ApplicationManager
	{
		private var _appDescription:IApplicationDescription;
		private var _nativeApplication:NativeApplicationManager;
		private var _supportNative:Boolean;
		private var _alertManager:AlertManager;
		private var _configuration:Configuration;
		
		public function ApplicationManager(alertManager:AlertManager, configuration:Configuration, applicationDescription:IApplicationDescription = null)
		{
			_configuration = configuration;
			_alertManager = alertManager;
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
		
		public function openUpdate():void
		{
			_alertManager.alert("Update", "Update is available!\nA new version of the game is available.", "DOWNLOAD", onClickDownload);
		}
		
		private function onClickDownload():void 
		{
			if (Environment.isAndroid)
			{
				navigateToURL(new URLRequest(_configuration.ANDROID_APP_LINK));
			}
			else if (Environment.isIOS)
			{
				navigateToURL(new URLRequest(_configuration.IOS_APP_LINK));
			}
		}
	}
}