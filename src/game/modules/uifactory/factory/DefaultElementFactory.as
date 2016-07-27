package game.modules.uifactory.factory
{
	import common.context.IContext;
    import game.modules.uifactory.factory.converter.ArrayConverter;
    import game.modules.uifactory.factory.converter.BooleanConverter;
    import game.modules.uifactory.factory.converter.IntConverter;
    import game.modules.uifactory.factory.converter.NumberConverter;
    import game.modules.uifactory.factory.converter.UintConverter;
    import game.modules.uifactory.factory.decoders.XMLToElementDecoder;
    import game.modules.uifactory.factory.factories.ImageFactory;
    import game.modules.uifactory.factory.handlers.FlattenHandler;
    import game.modules.uifactory.factory.handlers.UnFlattenHandler;
	import game.modules.uifactory.processors.ClickProcessor;
    import game.modules.uifactory.processors.IdProcessor;
    import game.modules.uifactory.factory.transformers.ColorTransformer;
    import game.modules.uifactory.factory.transformers.CtorTransformer;
    import game.modules.uifactory.factory.transformers.ParamsTransformer;
    import starling.display.Image;
    
    /**
     * ...
     * @author dorofiy.com
     */
    public class DefaultElementFactory extends ElementFactory
    {
        
        public function DefaultElementFactory(context:IContext, parent:ElementFactory = null)
        {
            super(context, parent);
            
            decoders.map(XML, new XMLToElementDecoder());
            
            converters.map(Boolean, new BooleanConverter());
            converters.map(Number, new NumberConverter());
            converters.map(int, new IntConverter());
            converters.map(uint, new UintConverter());
            converters.map(Array, new ArrayConverter());
            
            transformers.map("color", new ColorTransformer());
            transformers.map("params", new ParamsTransformer());
            transformers.map("ctor", new CtorTransformer());
            
            factories.map(Image, new ImageFactory());
            
            handlers.map("flatten", new FlattenHandler());
            handlers.map("unflatten", new UnFlattenHandler());
        }
    
    }

}