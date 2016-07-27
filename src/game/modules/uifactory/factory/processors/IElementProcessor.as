package game.modules.uifactory.factory.processors 
{
    import game.modules.uifactory.factory.Element;
    
    /**
     * ...
     * @author dorofiy.com
     */
    public interface IElementProcessor 
    {
        function apply(element:Element, result:Object):void;
    }
    
}