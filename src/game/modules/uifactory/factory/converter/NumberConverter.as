package game.modules.uifactory.factory.converter 
{
    import common.system.text.StringUtil;
	/**
     * ...
     * @author dorofiy.com
     */
    public class NumberConverter implements IPropertyConverter 
    {
        
        public function NumberConverter() 
        {
            
        }
        
        /* INTERFACE com.okapp.pirates.ui.core.factory.converter.IPropertyConverter */
        
        public function convert(value:Object):Object 
        {
            if (value is Number)
            {
                return Number(value);
            }
            return parseFloat(StringUtil.trim(String(value)));
        }
        
    }

}