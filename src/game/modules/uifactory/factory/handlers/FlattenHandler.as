package game.modules.uifactory.factory.handlers 
{
    import game.modules.uifactory.factory.Element;
    import starling.display.Sprite;
	/**
     * ...
     * @author dorofiy.com
     */
    public class FlattenHandler implements IHandler 
    {
        
        public function FlattenHandler() 
        {
            
        }
        
        /* INTERFACE com.okapp.pirates.ui.core.factory.handlers.IHandler */
        
        public function apply(element:Element, target:Object):void 
        {
            var sprite:Sprite = target as Sprite;
            if (sprite)
            {
                sprite.flatten(false, false);
            }
        }
        
    }

}