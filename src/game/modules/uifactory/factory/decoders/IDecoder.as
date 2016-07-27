package game.modules.uifactory.factory.decoders
{
    import game.modules.uifactory.factory.Element;
    
    /**
     * ...
     * @author dorofiy.com
     */
    public interface IDecoder
    {
        function decode(value:Object):Element;
        function encode(element:Element):Object;
    }

}