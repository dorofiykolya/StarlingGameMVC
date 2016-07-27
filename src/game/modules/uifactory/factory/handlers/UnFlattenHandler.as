package game.modules.uifactory.factory.handlers 
{
    import starling.display.DisplayObject;
    import game.modules.uifactory.factory.Element;
    import starling.display.Sprite;
	/**
     * ...
     * @author dorofiy.com
     */
    public class UnFlattenHandler implements IHandler 
    {
        
        public function UnFlattenHandler() 
        {
            
        }
        
        /* INTERFACE com.okapp.pirates.ui.core.factory.handlers.IHandler */
        
        public function apply(element:Element, target:Object):void 
        {
            var sprite:Sprite = target as Sprite;
            if (sprite)
            {
                sprite.unflatten();
            }
        }
        
    }

}