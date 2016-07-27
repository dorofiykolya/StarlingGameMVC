package game.modules.uifactory.factory.transformers 
{
    import game.modules.uifactory.factory.Element;
    import game.modules.uifactory.factory.ElementProperty;
    import common.system.reflection.Method;
    import common.system.text.StringUtil;
	/**
     * ...
     * @author dorofiy.com
     */
    public class ParamsTransformer implements IPropertyTransformer 
    {
        
        public function ParamsTransformer() 
        {
            
        }
        
        /* INTERFACE com.okapp.pirates.ui.core.factory.transformers.IPropertyTransformer */
        
        public function apply(item:ElementProperty):void 
        {
            if (item.parent.classType == null)
            {
                var target:Element = item.parent.parent;
                if (target.type)
                {
                    var method:Method = target.type.getMethod(item.parent.name);
                    if (method)
                    {
                        var result:Object = JSON.parse(StringUtil.trim(String(item.value)));
                        if (result is Array)
                        {
                            item.value = result;
                        }
                        else
                        {
                            item.value = String(item.value).split(",");
                        }
                    }
                }
            }
        }
        
    }

}