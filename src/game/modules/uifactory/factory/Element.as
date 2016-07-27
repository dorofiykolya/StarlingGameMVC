package game.modules.uifactory.factory 
{
    import common.system.Type;
	/**
     * ...
     * @author dorofiy.com
     */
    public class Element 
    {
        public var id:String;
        public var name:String;
        public var type:Type;
        public var classType:Class;
        public var ctor:Array;
        
        public var properties:Vector.<ElementProperty>;
        public var elements:Vector.<Element>;
        
        public var parent:Element;
        
        public function Element() 
        {
            
        }
        
        public function get root():Element
        {
            var target:Element = this;
            while (target.parent)
            {
                target = target.parent;
            }
            return target;
        }
        
        public function getProperty(name:String):ElementProperty
        {
            for each (var item:ElementProperty in properties) 
            {
                if (item.name == name)
                {
                    return item;
                }
            }
            return null;
        }
        
    }

}