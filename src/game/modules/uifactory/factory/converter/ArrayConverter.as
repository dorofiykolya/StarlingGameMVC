package game.modules.uifactory.factory.converter 
{
    import common.system.text.StringUtil;
	/**
     * ...
     * @author dorofiy.com
     */
    public class ArrayConverter implements IPropertyConverter 
    {
        
        public function ArrayConverter() 
        {
            
        }
        
        /* INTERFACE com.okapp.pirates.ui.core.factory.converter.IPropertyConverter */
        
        public function convert(value:Object):Object 
        {
            if (value is Array)
            {
                return value;
            }
            if (value is String)
            {
                var array:String = String(value);
                var trimed:String = StringUtil.trim(array);
                if (StringUtil.startsWith(trimed, "[") && StringUtil.endsWith(trimed, "]"))
                {
                    return JSON.parse(trimed);
                }
                else
                {
                    return array.split(",");
                }
            }
            return value;
        }
        
    }

}