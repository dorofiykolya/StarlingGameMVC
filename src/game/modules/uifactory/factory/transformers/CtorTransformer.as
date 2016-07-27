package game.modules.uifactory.factory.transformers 
{
    import game.modules.uifactory.factory.converter.IPropertyConverter;
    import game.modules.uifactory.factory.converter.PropertyConverterManager;
    import game.modules.uifactory.factory.ElementProperty;
    import common.system.ClassType;
    import common.system.reflection.Constructor;
    import common.system.reflection.Parameter;
    import common.system.text.StringUtil;
    import common.system.Type;
	/**
     * ...
     * @author dorofiy.com
     */
    public class CtorTransformer implements IPropertyTransformer 
    {
        [Inject]
        public var converters:PropertyConverterManager;
        
        public function CtorTransformer() 
        {
            
        }
        
        /* INTERFACE com.okapp.pirates.ui.core.factory.transformers.IPropertyTransformer */
        
        public function apply(item:ElementProperty):void 
        {
            var value:String = item.value;
            if (StringUtil.isNotEmpty(value))
            {
                var params:Array = value.split(",");
                var ctorType:Type = item.parent.type;
                var constructorInfo:Constructor = ctorType.constructorInfo;
                var ctorParams:Vector.<Parameter> = constructorInfo.parameters;
                var ctorLength:int = ctorParams.length;
                var length:int = params.length;
                if (length > ctorLength)
                {
                    length = ctorLength;
                    params.length = ctorLength;
                }
                var currentCtorParam:Parameter;
                var currentValue:Object;
                for (var i:int = 0; i < length; ++i) 
                {
                    currentValue = params[i];
                    currentCtorParam = ctorParams[i];
                    var converter:IPropertyConverter = converters.getConverter(currentCtorParam.type);
                    if (converter)
                    {
                        currentValue = converter.convert(currentValue);
                    }
                    else if(ClassType.getInstanceType(currentCtorParam.type).isPrimitive)
                    {
                        currentValue = currentCtorParam.type(currentValue);
                    }
                    params[i] = currentValue;
                }
                item.parent.ctor = params;
            }
        }
        
    }

}