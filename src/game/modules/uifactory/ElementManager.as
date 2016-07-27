package game.modules.uifactory 
{
    import common.system.IDisposable;
    import flash.utils.Dictionary;
	import game.modules.uifactory.IUIProvider;
	/**
     * ...
     * @author dorofiy.com
     */
    public class ElementManager implements IUIProvider, IDisposable
    {
        private var _elements:Dictionary;
        
        public function ElementManager() 
        {
            _elements = new Dictionary();
        }
        
        public function add(id:Object, element:Object, overrideExist:Boolean = false):void
        {
            if (!(id in _elements) || overrideExist)
            {
                _elements[id] = element;
            }
        }
        
        public function remove(id:Object):Boolean
        {
            var has:Boolean = id in _elements;
            delete _elements[id];
            return has;
        }
        
        public function getElement(id:Object):Object
        {
            return _elements[id];
        }
        
        public function dispose():void
        {
            for (var name:Object in _elements) 
            {
                delete _elements[name];
            }
        }
        
    }

}