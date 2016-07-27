package game.modules.uifactory.factory.factories 
{
    import game.modules.uifactory.factory.Element;
    import common.injection.IInjector;
    import common.injection.Injector;
    import common.injection.providers.IProvider;
    import common.system.ClassType;
    import common.system.Type;
    import starling.display.Sprite;
	/**
     * ...
     * @author dorofiy.com
     */
    public class DefaultFactory implements IFactory 
    {
        private var _injector:IInjector;
        
        public function DefaultFactory(injector:IInjector) 
        {
            _injector = injector;
        }
        
        /* INTERFACE com.okapp.pirates.ui.core.factory.factories.IFactory */
        
        public function apply(element:Element):Object 
        {
            if (element.type == null)
            {
                return new Sprite();
            }
            var provider:IProvider = _injector.getProvider(element.classType);
            if (provider == null)
            {
                _injector.map(element.classType).toFactory(element.classType);
                provider = _injector.getProvider(element.classType);
            }
            return provider.apply(_injector, element.classType);
        }
        
    }

}