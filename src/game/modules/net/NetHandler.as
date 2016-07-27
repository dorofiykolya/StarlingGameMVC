package game.modules.net
{
	import common.injection.IInjector;
	import common.system.DictionaryMap;
	import common.system.utils.ObjectUtils;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author ...
	 */
	public class NetHandler implements INetHandler
	{
		[Inject]
		public var injector:IInjector;
		
		private var _keys:Dictionary;
		
		public function NetHandler()
		{
			_keys = new Dictionary();
		}
		
		public function add(packet:Packet, command:NetCommand):void
		{
			var list:Vector.<NetCommand> = (_keys[packet.name] ||= new Vector.<NetCommand>());
			list.push(command);
		}
		
		public function remove(packet:Packet, command:NetCommand):void
		{
			var list:Vector.<NetCommand> = _keys[packet.name];
			if (list != null)
			{
				var index:int = list.indexOf(command);
				if (index != -1)
				{
					list.splice(index, 1);
				}
			}
		}
		
		public function invoke(key:Object, value:Object):void
		{
			var list:Vector.<NetCommand> = _keys[key];
			if (list != null)
			{
				for each (var item:NetCommand in list.slice())
				{
					var data:Object = value;
					if (item.dataType != null)
					{
						data = ObjectUtils.toType(value, item.dataType);
					}
					injector.inject(item);
					item.execute(data);
				}
			}
		}
	}

}