package game.modules.applications
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class NativeApplicationManager implements IApplicationDescription, IEventDispatcher
	{
		private var _nativeAppClass:Object;
		private var _nativeApp:Object;
		private var _support:Boolean;
		
		public function NativeApplicationManager()
		{
			try
			{
				_nativeAppClass = getDefinitionByName("flash.desktop.NativeApplication");
				_support = true;
			}
			catch (e:Error)
			{
				
			}
			if (_nativeAppClass == null)
			{
				_nativeAppClass = {};
				_nativeAppClass.supportsDefaultApplication = false;
				_nativeAppClass.supportsDockIcon = false;
				_nativeAppClass.supportsMenu = false;
				_nativeAppClass.supportsStartAtLogin = false;
				_nativeAppClass.supportsSystemTrayIcon = false;
			}
			
			_nativeApp = "nativeApplication" in _nativeAppClass ? _nativeAppClass["nativeApplication"] : null;
			if (_nativeApp == null)
			{
				_nativeApp = {};
				_nativeApp.activate = function(... p):void
				{
				};
				_nativeApp.activeWindow = function(... p):void
				{
				};
				_nativeApp.exit = function(code:int):void {};
				_nativeApp.applicationDescriptor = null;
				_nativeApp.applicationID = null;
				_nativeApp.autoExit = false;
				_nativeApp.publisherID = null;
				_nativeApp.runtimePatchLevel = 0;
				_nativeApp.runtimeVersion = null;
				_nativeApp.systemIdleMode = null;
				_nativeApp.timeSinceLastUserInput = 0;
				_nativeApp.executeInBackground = false;
			}
		
			//NativeApplication.nativeApplication.activate
			//NativeApplication.nativeApplication.activeWindow
			//NativeApplication.nativeApplication.applicationDescriptor
			//NativeApplication.nativeApplication.applicationID
			//NativeApplication.nativeApplication.autoExit
			//NativeApplication.nativeApplication.exit
			//NativeApplication.nativeApplication.publisherID
			//NativeApplication.nativeApplication.runtimePatchLevel
			//NativeApplication.nativeApplication.runtimeVersion
			//NativeApplication.nativeApplication.systemIdleMode
			//NativeApplication.nativeApplication.timeSinceLastUserInput
		
			//NativeApplication.nativeApplication.addEventListener
			//NativeApplication.nativeApplication.clear
			//NativeApplication.nativeApplication.copy
			//NativeApplication.nativeApplication.cut
			//NativeApplication.nativeApplication.dispatchEvent
			//NativeApplication.nativeApplication.executeInBackground
			//NativeApplication.nativeApplication.getDefaultApplication
			//NativeApplication.nativeApplication.hasEventListener
			//NativeApplication.nativeApplication.hasOwnProperty
			//NativeApplication.nativeApplication.icon
			//NativeApplication.nativeApplication.idleThreshold
			//NativeApplication.nativeApplication.isPrototypeOf
			//NativeApplication.nativeApplication.isSetAsDefaultApplication
			//NativeApplication.nativeApplication.menu
			//NativeApplication.nativeApplication.openedWindows
			//NativeApplication.nativeApplication.paste
			//NativeApplication.nativeApplication.propertyIsEnumerable
			//NativeApplication.nativeApplication.prototype
			//NativeApplication.nativeApplication.removeAsDefaultApplication
			//NativeApplication.nativeApplication.removeEventListener
			//NativeApplication.nativeApplication.selectAll
			//NativeApplication.nativeApplication.setAsDefaultApplication
			//NativeApplication.nativeApplication.startAtLogin
			//NativeApplication.nativeApplication.toString
			//NativeApplication.nativeApplication.willTrigger
		}
		
		public function get support():Boolean
		{
			return _support;
		}
		
		public function get supportsDefaultApplication():Boolean
		{
			return _nativeAppClass.supportsDefaultApplication;
		}
		
		public function get supportsDockIcon():Boolean
		{
			return _nativeAppClass.supportsDockIcon;
		}
		
		public function get supportsMenu():Boolean
		{
			return _nativeAppClass.supportsMenu;
		}
		
		public function get supportsStartAtLogin():Boolean
		{
			return _nativeAppClass.supportsStartAtLogin;
		}
		
		public function get supportsSystemTrayIcon():Boolean
		{
			return _nativeAppClass.supportsSystemTrayIcon;
		}
		
		public function exit(errorCode:int = 0):void
		{
			_nativeApp.exit(errorCode);
		}
		
		public function activate(nativeWindow:Object = null):void
		{
			_nativeApp.activate(nativeWindow);
		}
		
		public function get applicationDescriptor():XML
		{
			return _nativeApp.applicationDescriptor;
		}
		
		public function get descriptorVersion():String
		{
			var result:XML = _nativeApp.applicationDescriptor;
			if (result)
			{
				var children:XMLList = result.children();
				var name:QName;
				for (var i:int = 0; i < children.length(); i++)
				{
					name = children[i].name() as QName;
					if (name && name.localName == "versionNumber")
					{
						return String(children[i].text());
					}
				}
			}
			return null;
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			_nativeApp.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return _nativeApp.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return _nativeApp.hasEventListener(type);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			_nativeApp.removeEventListener(type, listener, useCapture);
		}
		
		public function willTrigger(type:String):Boolean
		{
			return _nativeApp.willTrigger(type);
		}
		
		public function get applicationID():String
		{
			return _nativeApp.applicationID;
		}
		
		public function get autoExit():Boolean
		{
			return _nativeApp.autoExit;
		}
		
		public function set autoExit(value:Boolean):void
		{
			_nativeApp.autoExit = value;
		}
		
		public function get publisherID():String
		{
			return _nativeApp.publisherID;
		}
		
		public function get runtimePatchLevel():uint
		{
			return _nativeApp.runtimePatchLevel;
		}
		
		public function get runtimeVersion():String
		{
			return _nativeApp.runtimeVersion;
		}
		
		public function get systemIdleMode():String
		{
			return _nativeApp.systemIdleMode;
		}
		
		public function set systemIdleMode(value:String):void
		{
			_nativeApp.systemIdleMode = value;
		}
		
		public function get timeSinceLastUserInput():int
		{
			return _nativeApp.timeSinceLastUserInput;
		}
		
		public function get executeInBackground():Boolean
		{
			return _nativeApp.executeInBackground;
		}
		
		public function set executeInBackground(value:Boolean):void
		{
			_nativeApp.executeInBackground = value;
		}
	}
}