package game.modules.uifactory.processors
{
    import game.modules.uifactory.ElementManager;
    import game.modules.uifactory.factory.ElementProperty;
    import game.modules.uifactory.factory.processors.IPropertyProcessor;
    
    /**
     * ...
     * @author dorofiy.com
     */
    public class IdProcessor implements IPropertyProcessor
    {
		private var _elements:ElementManager;
		
        public function IdProcessor(elements:ElementManager)
        {
			_elements = elements;
        }
        
        /* INTERFACE com.okapp.pirates.ui.core.factory.processors.IPropertyProcessor */
        
        public function apply(property:ElementProperty, target:Object):void
        {
            _elements.add(property.value, target, true);
        }
    
    }

}