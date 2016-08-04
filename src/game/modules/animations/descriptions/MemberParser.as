package game.modules.animations.descriptions
{
	import common.system.ClassType;
	import common.system.reflection.Member;
	import common.system.reflection.MemberType;
	import common.system.reflection.Method;
	import common.system.reflection.Parameter;
	import game.modules.animations.descriptions.PropertyValue;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class MemberParser
	{
		
		public function MemberParser()
		{
		
		}
		
		public static function add(toList:Vector.<PropertyValue>, type:Class, memberName:String, value:String):PropertyValue
		{
			var member:Member = ClassType.getInstanceType(type).getMember(memberName);
			var property:PropertyValue = null;
			if (member.memberType == MemberType.METHOD)
			{
				var result:Array = null;
				if (value.length != 0)
				{
					result = [];
					var params:Array = value.split(",");
					var method:Method = Method(member);
					var parameters:Vector.<Parameter> = method.parameters;
					var num:int = Math.min(params.length, parameters.length);
					for (var i:int = 0; i < num; i++)
					{
						var paramType:Class = parameters[i].type;
						result[i] = convertType(paramType, params[i]);
					}
				}
				toList[toList.length] = property = new FunctionValue(memberName, result);
			}
			else
			{
				var memeberType:Class = member.type;
				toList[toList.length] = property = new PropertyValue(memberName, convertType(memeberType, value));
			}
			return property;
		}
		
		private static function convertType(type:Class, value:Object):Object
		{
			return ClassType.cast(value, type);
		}
	
	}

}