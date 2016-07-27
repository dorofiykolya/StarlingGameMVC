package game.modules.uifactory 
{
	import common.context.IContext;
	import game.modules.uifactory.factory.DefaultElementFactory;
	import game.modules.uifactory.factory.ElementFactory;
    import game.modules.uifactory.processors.ClickCloseWindowProcessor;
    import game.modules.uifactory.processors.ClickOpenWindowProcessor;
    import game.modules.uifactory.processors.ClickProcessor;
    import game.modules.uifactory.processors.IdProcessor;
	
	/**
     * ...
     * @author dorofiy.com
     */
    public class UIElementFactory extends DefaultElementFactory implements IUIProvider
    {
		private var _elements:ElementManager;
		
        public function UIElementFactory(context:IContext = null) 
        {
            super(context);
            
            propertyProcessors.map("click", new ClickProcessor());
            propertyProcessors.map("id", new IdProcessor(_elements));
            propertyProcessors.map("onClickOpen", new ClickOpenWindowProcessor());
            propertyProcessors.map("onClickClose", new ClickCloseWindowProcessor());
        }
		
		public function getElement(id:String):Object
		{
			return _elements.getElement(id);
		}
    }
}