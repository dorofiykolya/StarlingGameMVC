package game.modules.uifactory.factory.handlers 
{
    import game.modules.uifactory.factory.Element;
    
    /**
     * ...
     * @author dorofiy.com
     */
    public interface IHandler 
    {
        function apply(element:Element, target:Object):void;
    }
    
}