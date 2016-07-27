package game.modules.formats
{
	import game.managers.localizations.ILocalizeProvider;
	
	/**
	 * ...
	 * @author dorofiy
	 */
	public class TimeFormat
	{
		private var _localize:ILocalizeProvider;
		
		public function TimeFormat(localize:ILocalizeProvider)
		{
			_localize = localize;
		}
		
		public function formatWith(timeInSeconds:Number, isDynamic:Boolean = true, withNull:Boolean = true, withSeconds:Boolean = true, withChars:Boolean = true):String
		{
			if (timeInSeconds < 0 || isNaN(timeInSeconds))
			{
				if (isDynamic)
					return "00:00";
				else
					return "";
			}
			
			var nRemainder:Number;
			
			var nDays:Number = timeInSeconds / (60 * 60 * 24);
			nRemainder = nDays - (nDays | 0);
			nDays = nDays | 0;
			
			var nHours:Number = nRemainder * 24;
			nRemainder = nHours - (nHours | 0);
			nHours = nHours | 0;
			
			var nMinutes:Number = nRemainder * 60;
			nRemainder = nMinutes - (nMinutes | 0);
			nMinutes = nMinutes | 0;
			
			var nSeconds:Number = nRemainder * 60;
			
			if (nDays == 0 && nHours == 0 && nMinutes == 0)
			{
				nRemainder = timeInSeconds | 0;
				nSeconds = timeInSeconds | 0;
			}
			else
			{
				nRemainder = nSeconds - (nSeconds | 0);
				nSeconds = nSeconds | 0;
			}
			
			if (withSeconds == false)
				nSeconds = 0;
			
			var d:String = withChars ? _localize.localize("d") : "";
			var h:String = withChars ? _localize.localize("h") : "";
			var m:String = withChars ? _localize.localize("m") : "";
			var s:String = withChars ? _localize.localize("s") : "";
			
			var dString:String = nDays.toString();
			var hString:String = (nHours < 10 && withNull) ? "0" + nHours : "" + nHours;
			var mString:String = (nMinutes < 10 && withNull) ? "0" + nMinutes : "" + nMinutes;
			var sString:String = (nSeconds < 10 && withNull) ? "0" + nSeconds : "" + nSeconds;
			
			var counter:uint = 0;
			
			if (isDynamic)
			{
				if (withSeconds)
				{
					if (nDays == 0 && nHours == 0 && nMinutes == 0)
						return sString + s;
					if (nDays == 0 && nHours == 0)
						return mString + m + " " + sString + s;
					if (nDays == 0)
						return hString + h + " " + mString + m;
					return dString + d + " " + hString + h;
				}
				else
				{
					if (nDays == 0 && nHours == 0 && nMinutes == 0)
						return '0';
					if (nDays == 0 && nHours == 0)
						return mString + m;
					if (nDays == 0)
						return hString + h + " " + mString + m;
					return dString + d + " " + hString + h;
				}
				
			}
			else
			{
				var str:String = "";
				if (nDays != 0)
				{
					str += nDays + d + " ";
					counter++;
				}
				if (nHours != 0)
				{
					str += nHours + h + " ";
					counter++;
					if (counter == 2)
						return str;
				}
				if (nMinutes != 0)
				{
					str += nMinutes + m + " ";
					counter++;
					if (counter == 2)
						return str;
				}
				if (nSeconds != 0)
				{
					str += nSeconds + s;
					counter++;
					if (counter == 2)
						return str;
				}
				return str;
			}
		}
		
		public function format(timeInSeconds:Number):String
		{
			if (timeInSeconds < 0 || isNaN(timeInSeconds))
			{
				return "00:00";
			}
			
			var nRemainder:Number;
			
			var nDays:Number = timeInSeconds / (60 * 60 * 24);
			nRemainder = nDays - (nDays | 0);
			nDays = nDays | 0;
			
			var nHours:Number = nRemainder * 24;
			nRemainder = nHours - (nHours | 0);
			nHours = nHours | 0;
			
			var nMinutes:Number = nRemainder * 60;
			nRemainder = nMinutes - (nMinutes | 0);
			nMinutes = nMinutes | 0;
			
			var nSeconds:Number = nRemainder * 60;
			nRemainder = nSeconds - (nSeconds | 0);
			nSeconds = nSeconds | 0;
			
			var dString:String = nDays.toString();
			var hString:String = (nHours < 10) ? "0" + nHours : "" + nHours;
			var mString:String = (nMinutes < 10) ? "0" + nMinutes : "" + nMinutes;
			var sString:String = (nSeconds < 10) ? "0" + nSeconds : "" + nSeconds;
			
			return dString + ":" + hString + ":" + mString + ":" + sString;
		}
		
		// формат "d HH:MM:SS"
		public function formatFullTime(timeInSeconds:Number, dayLabel1:String = "день", dayLabel234:String = "дня", dayLabel567890:String = "дней"):String
		{
			var nRemainder:Number;
			
			var nDays:Number = timeInSeconds / (60 * 60 * 24);
			nRemainder = nDays - (nDays | 0);
			nDays = nDays | 0;
			
			var nHours:Number = nRemainder * 24;
			nRemainder = nHours - (nHours | 0);
			nHours = nHours | 0;
			
			var nMinutes:Number = nRemainder * 60;
			nRemainder = nMinutes - (nMinutes | 0);
			nMinutes = nMinutes | 0;
			
			var nSeconds:Number = nRemainder * 60;
			nRemainder = nSeconds - (nSeconds | 0);
			nSeconds = nSeconds | 0;
			
			var hString:String = nHours < 10 ? "0" + nHours : "" + nHours;
			var mString:String = nMinutes < 10 ? "0" + nMinutes : "" + nMinutes;
			var sString:String = nSeconds < 10 ? "0" + nSeconds : "" + nSeconds;
			
			if (timeInSeconds < 0 || isNaN(timeInSeconds))
				return "00:00:00";
			if (nDays > 0)
			{
				var day:String = "";
				var nd:String = String(int(nDays));
				var daySufix:int = int(nd.charAt(nd.length - 1));
				if (daySufix == 1)
				{
					day = nDays + " " + dayLabel1;
				}
				else if (daySufix >= 2 && daySufix <= 4)
				{
					day = nDays + " " + dayLabel234;
				}
				else
				{
					day = nDays + " " + dayLabel567890;
				}
				return day + " " + hString + ":" + mString + ":" + sString;
			}
			else if (nHours > 0)
			{
				return hString + ":" + mString + ":" + sString;
			}
			return mString + ":" + sString;
		}
		
		// формат "XXd XXh" или "XXh XXm"
		public function formatShortTime(timeInSeconds:Number, dayLabel:String, hourLabel:String, minuteLabel:String, secondLabel:String):String
		{
			var nRemainder:Number;
			
			var nDays:Number = timeInSeconds / (60 * 60 * 24);
			nRemainder = nDays - (nDays | 0);
			nDays = nDays | 0;
			
			var nHours:Number = nRemainder * 24;
			nRemainder = nHours - (nHours | 0);
			nHours = nHours | 0;
			
			var nMinutes:Number = nRemainder * 60;
			nRemainder = nMinutes - (nMinutes | 0);
			nMinutes = nMinutes | 0;
			
			var nSeconds:Number = nRemainder * 60;
			nRemainder = nSeconds - (nSeconds | 0);
			nSeconds = nSeconds | 0;
			
			var hString:String = nHours < 10 ? "0" + nHours : "" + nHours;
			var mString:String = nMinutes < 10 ? "0" + nMinutes : "" + nMinutes;
			var sString:String = nSeconds < 10 ? "0" + nSeconds : "" + nSeconds;
			
			if (timeInSeconds < 0 || isNaN(timeInSeconds))
				return "00:00:00";
			if (nDays > 0)
			{
				return nDays + dayLabel + " " + hString + hourLabel;
			}
			else if (nHours > 0)
			{
				return hString + hourLabel + " " + mString + minuteLabel;
			}
			return mString + minuteLabel + " " + sString + secondLabel;
		}
		
		// формат "N дня, N дней"
		public function formatDays(timeInSeconds:Number, dayLabel1:String = "день", dayLabel234:String = "дня", dayLabel567890:String = "дней"):String
		{
			var nRemainder:Number;
			var day:String = "";
			var nDays:Number = timeInSeconds / (60 * 60 * 24);
			nRemainder = nDays - (nDays | 0);
			nDays = nDays | 0;
			
			if (timeInSeconds < 0 || isNaN(timeInSeconds))
				return "00:00:00";
			if (nDays > 0)
			{
				var nd:String = String(int(nDays));
				var daySufix:int = int(nd.charAt(nd.length - 1));
				if (daySufix == 1)
				{
					day = nDays + " " + dayLabel1;
				}
				else if (daySufix >= 2 && daySufix <= 4)
				{
					day = nDays + " " + dayLabel234;
				}
				else
				{
					day = nDays + " " + dayLabel567890;
				}
				
			}
			return day;
		}
	
	}

}