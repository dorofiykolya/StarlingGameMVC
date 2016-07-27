package game.modules.net
{
	import game.modules.logs.ILogger;
	import game.net.NetErrorPacket;
	import game.net.NetPacket;
	import game.net.errorCommands.UserCardErrorCommand;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class NetErrorListener extends NetHandler implements INetErrorHandler
	{
		[Inject]
		public var logger:ILogger;
		
		public function NetErrorListener()
		{
			add(NetErrorPacket.USE_CARD, new UserCardErrorCommand());
		}
		
		override public function invoke(key:Object, value:Object):void
		{
			logger.alert(value);
			super.invoke(key, value);
		}
	
	}

}