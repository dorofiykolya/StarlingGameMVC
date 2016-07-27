package game.modules.consoles
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.junkbyte.console.Cc;
	import common.context.IContext;
	import common.system.Enum;
	import flash.display.Stage;
	import game.locations.ILocationModel;
	import game.locations.fights.LocationFightManager;
	import game.locations.managers.LocationDebugManager;
	import game.managers.auth.AuthManager;
	import game.managers.items.ItemManager;
	import game.managers.navigations.NavigationManager;
	import game.managers.screens.ScreenManager;
	import game.managers.windows.WindowId;
	import game.managers.windows.WindowsManager;
	import game.modules.debugs.DebugManager;
	import game.modules.net.ISocketConnection;
	import game.modules.net.UINetLoggerManager;
	import game.net.ServerRequest;
	import mvc.configurations.IConfigurable;
	import starling.display.Stage;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class ConsoleCommandsConfiguration implements IConfigurable
	{
		[Inject]
		public var socket:ISocketConnection;
		[Inject]
		public var context:IContext;
		[Inject]
		public var nativeStage:flash.display.Stage;
		[Inject]
		public var starlingStage:starling.display.Stage;
		[Inject]
		public var windowsManager:WindowsManager;
		[Inject]
		public var locationModel:ILocationModel;
		[Inject]
		public var serverRequest:ServerRequest;
		[Inject]
		public var screenManager:ScreenManager;
		[Inject]
		public var itemManager:ItemManager;
		[Inject]
		public var authManager:AuthManager;
		[Inject]
		public var debugManager:DebugManager;
		[Inject]
		public var navigationManager:NavigationManager;
		[Inject]
		public var uiNetLoggerManager:UINetLoggerManager;
		[Inject]
		public var consoleManager:ConsoleManager;
		
		public function ConsoleCommandsConfiguration()
		{
		
		}
		
		private function map(name:String, callBack:Function, description:String = ""):void
		{
			Cc.addSlashCommand(name, callBack, description);
		}
		
		/* INTERFACE mvc.configurations.IConfigurable */
		
		public function config(context:IContext):void
		{
			map("reboot", function(...p):void
			{
				serverRequest.reboot();
			}, "reboot server");
			
			map("debugger", function(... p):void
			{
				MonsterDebugger.initialize(context.getObject(starling.display.Stage));
			}, "initialize monster debugger");
			
			map("socket", function(... p):void
			{
				Cc.inspect(socket.socket, true);
			}, "inspect socket connection");
			
			map("context", function(... p):void
			{
				Cc.inspect(context, true);
			}, "inspect context");
			
			map("stage_native", function(... p):void
			{
				Cc.inspect(nativeStage, true);
			}, "inspect native stage");
			
			map("stage_starling", function(... p):void
			{
				Cc.inspect(starlingStage, true);
			}, "inspect starling stage");
			
			map("windows", function(... p):void
			{
				Cc.inspect(windowsManager);
			}, "windows manager");
			
			map("connect", function(... p):void
			{
				var hstPort:Array = String(p[0]).split(":");
				if (socket.connected)
				{
					socket.close();
				}
				socket.connect(hstPort[0], int(hstPort[1]));
			}, "connect to host:port, example 127.0.0.1:80");
			
			map("fight_scale", function(... p):void
			{
				if (locationModel.loaded)
				{
					locationModel.location.timeScale = parseFloat(p[0]);
				}
				else
				{
					Cc.error("location not loaded");
				}
			}, "scale time in fight");
			map("fight", function(... p):void
			{
				serverRequest.startTrainingFight();
			
			}, "start fight");
			
			map("geodata", function(... p):void
			{
				LocationDebugManager(locationModel.location.managers.getComponent(LocationDebugManager)).toggleGeodata();
			}, "toggle building geodata");
			
			map("radius", function(... p):void
			{
				LocationDebugManager(locationModel.location.managers.getComponent(LocationDebugManager)).toggleRadius();
			}, "show fight radius");
			
			map("health", function(... p):void
			{
				LocationDebugManager(locationModel.location.managers.getComponent(LocationDebugManager)).toggleHealth();
			}, "show fight health");
			
			map("fight_stop", function(... p):void
			{
				serverRequest.stopFight();
			}, "fight stop");
			
			map("screen", function(... p):void
			{
				if (p.length != 0)
				{
					if (screenManager.getScreen(p[0]))
					{
						screenManager.showScreen(p[0]);
					}
					else
					{
						Cc.error("screen not found:" + p[0]);
					}
				}
			}, "navigate to scene");
			
			map("fight_pause", function(... p):void
			{
				if (locationModel.loaded)
				{
					locationModel.location.pause();
				}
				else
				{
					Cc.error("location is not loaded");
				}
			}, "fight pause");
			
			map("fight_resume", function(... p):void
			{
				if (locationModel.loaded)
				{
					locationModel.location.resume();
				}
				else
				{
					Cc.error("location is not loaded");
				}
			}, "fight pause");
			
			map("fight_step", function(... p):void
			{
				if (locationModel.loaded)
				{
					LocationFightManager(locationModel.location.managers.getComponent(LocationFightManager)).nextStep();
				}
				else
				{
					Cc.error("location is not loaded");
				}
			}, "fight next step");
			
			map("path", function(... p):void
			{
				if (locationModel.loaded && p.length == 1)
				{
					LocationDebugManager(locationModel.location.managers.getComponent(LocationDebugManager)).drawPath(int(p[0]));
				}
				else
				{
					Cc.error("location is not loaded or argument length != 1");
				}
			}, "draw path objectId");
			
			map("map_geodata", function(... p):void
			{
				if (locationModel.loaded)
				{
					LocationDebugManager(locationModel.location.managers.getComponent(LocationDebugManager)).toggleMapGeodata();
				}
				else
				{
					Cc.error("location is not loaded");
				}
			}, "map geodate");
			
			map("item", function(... p):void
			{
				var itemParams:Array = String(p[0]).split(" ");
				itemManager.setItemValue(int(itemParams[0]), int(itemParams[1]));
			}, "set item count, example: /item 1 10");
			
			map("reauth", function(... p):void
			{
				authManager.reAuth();
			}, "clear auth");
			
			map("start", function(... p):void
			{
				debugManager.openStartWindow();
			}, "open start window");
			
			map("send", function(...p):void
			{
				serverRequest.send(p[0]);
			}, "send to server");
			
			map("fight_info", function(...p):void
			{
				if (locationModel.loaded)
				{
					Cc.inspect(locationModel.location.info);
				}
				else
				{
					Cc.error("location is not loaded");
				}
			}, "fight info");
			
			map("object_id", function(...p):void
			{
				if (locationModel.loaded)
				{
					LocationDebugManager(locationModel.location.managers.getComponent(LocationDebugManager)).toggleObjectId();
				}
				else
				{
					Cc.error("location is not loaded");
				}
			}, "toggle object id");
			
			map("user_auth", function(...p):void
			{
				var authArr:Array = String(p[0]).split(" ");
				serverRequest.userAuth(int(authArr[0]), int(authArr[1]), String(authArr[2]), String(authArr[3]));
			}, "user userAuth(userKey:int, authTS:int, authKey:String, isBrowser:Boolean)");
			
			map("get_auth", function(...p):void
			{
				Cc.log(authManager.authData);
			}, "log auth data");
			
			map("log_at_mouse", function(...p):void
			{
				debugManager.toggleLogAtMouse();
			}, "log ");
			
			map("navigate_back", function(...p):void
			{
				navigationManager.navigate();
			}, "back");
			
			map("net_logs", function(...p):void
			{
				if (uiNetLoggerManager.opened)
				{
					uiNetLoggerManager.close();
				}
				else
				{
					uiNetLoggerManager.open();
				}
			}, "net logs");
			
			map("open", function(...p):void
			{
				windowsManager.open(WindowId(Enum.getEnum(WindowId, String(p[0]))));
			}, "open window");
			
			map("close", function(...p):void
			{
				if (consoleManager.opened)
				{
					consoleManager.close();
				}
				else
				{
					consoleManager.open();
				}
			}, "close console");
		}
	
	}

}