package game.modules.uifactory.factory.transformers 
{
    import game.modules.uifactory.factory.ElementProperty;
	/**
     * ...
     * @author dorofiy.com
     */
    public interface IPropertyTransformer 
    {
        function apply(item:ElementProperty):void;
    }

}