package game.modules.uifactory.factory.processors 
{
    import game.modules.uifactory.factory.ElementProperty;
	/**
     * ...
     * @author dorofiy.com
     */
    public interface IPropertyProcessor 
    {
        function apply(property:ElementProperty, target:Object):void;
    }

}