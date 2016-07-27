package game.modules.uifactory.factory.converter 
{
    import common.system.text.StringUtil;
	/**
     * ...
     * @author dorofiy.com
     */
    public class BooleanConverter implements IPropertyConverter 
    {
        
        public function BooleanConverter() 
        {
            
        }
        
        /* INTERFACE com.okapp.pirates.ui.core.factory.converter.IPropertyConverter */
        
        public function convert(value:Object):Object 
        {
            if (StringUtil.trim(String(value).toLowerCase()) == "true")
            {
                return true;
            }
            if (StringUtil.trim(String(value).toLowerCase()) == "false")
            {
                return false;
            }
            return Boolean(value);
        }
        
    }

}