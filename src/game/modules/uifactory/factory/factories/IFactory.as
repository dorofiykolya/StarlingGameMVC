package game.modules.uifactory.factory.factories 
{
    import game.modules.uifactory.factory.Element;
    
    /**
     * ...
     * @author dorofiy.com
     */
    public interface IFactory 
    {
        function apply(element:Element):Object;
    }
    
}