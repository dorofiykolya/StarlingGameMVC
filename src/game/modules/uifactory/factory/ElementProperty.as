package game.modules.uifactory.factory 
{
    import common.system.Type;
	/**
     * ...
     * @author dorofiy.com
     */
    public class ElementProperty 
    {
        public var parent:Element;
        public var name:String;
        public var uri:String;
        public var type:Type;
        public var classType:Class;
        public var value:*;
        
        public function ElementProperty() 
        {
            
        }
        
        public function get root():Element
        {
            return parent.root;
        }
        
    }

}