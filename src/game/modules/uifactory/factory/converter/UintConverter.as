package game.modules.uifactory.factory.converter 
{
    import common.system.text.StringUtil;
	/**
     * ...
     * @author dorofiy.com
     */
    public class UintConverter implements IPropertyConverter 
    {
        
        public function UintConverter() 
        {
            
        }
        
        /* INTERFACE com.okapp.pirates.ui.core.factory.converter.IPropertyConverter */
        
        public function convert(value:Object):Object 
        {
            if (value is Number)
            {
                return uint(value);
            }
            var number:String = StringUtil.trim(String(value).toLowerCase());
            if (StringUtil.startsWith(number, "0x"))
            {
                return uint(parseInt(number, 16));
            }
            else if (StringUtil.startsWith(number, "#"))
            {
                return uint(parseInt(StringUtil.removeCharsAt(number, 0, 1, "0x"), 16));
            }
            return uint(parseInt(number, 10));
        }
        
    }

}