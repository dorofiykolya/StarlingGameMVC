package game.modules.uifactory.factory.decoders
{
    import game.modules.uifactory.factory.Element;
    import game.modules.uifactory.factory.ElementProperty;
    import common.system.Assert;
    import common.system.Cache;
    import common.system.ClassType;
    import common.system.reflection.Member;
    import common.system.Type;
    
    /**
     * ...
     * @author dorofiy.com
     */
    public class XMLToElementDecoder implements IDecoder
    {
        private var _cache:Cache;
        
        public function XMLToElementDecoder()
        {
            _cache = Cache.cache.getStorage(ClassType.getQualifiedClassName(XMLToElementDecoder));
        }
        
        public function decode(value:Object):Element
        {
            var xml:XML = XML(value);
            Assert.notNull(xml);
            var element:Element = new Element();
            var name:String = String(xml.name());
            var type:Class;
            if (name in _cache)
            {
                type = _cache[name];
            }
            else
            {
                type = Class(ClassType.getClassByName(name));
                _cache[name] = type;
            }
            if (type)
            {
                element.type = ClassType.getInstanceType(type);
                element.classType = element.type.constructorClass;
            }
            element.name = name;
            element.id = String(xml.@id);
            
            var properties:Vector.<ElementProperty> = new Vector.<ElementProperty>();
            element.properties = properties;
            var propertyItem:ElementProperty;
            for each (var property:XML in xml.attributes())
            {
                propertyItem = createProperty(property, xml, element.type);
                propertyItem.parent = element;
                properties[properties.length] = propertyItem;
            }
            
            var elements:Vector.<Element> = new Vector.<Element>();
            element.elements = elements;
            var elementItem:Element;
            for each (var item:XML in xml.elements())
            {
                elementItem = decode(item);
                elementItem.parent = element;
                elements[elements.length] = elementItem;
            }
            return element;
        }
        
        /* INTERFACE com.okapp.pirates.ui.core.factory.decoders.IDecoder */
        
        public function encode(element:Element):Object 
        {
            return null;
        }
        
        protected function createProperty(property:XML, parent:XML, parentType:Type):ElementProperty
        {
            var element:ElementProperty = new ElementProperty();
            element.value = String(property);
            var name:QName = QName(property.name());
            element.name = name.localName;
            element.uri = name.uri;
            if (parentType)
            {
                var member:Member = parentType.getField(name.localName);
                if (member == null)
                {
                    member = parentType.getProperty(name.localName);
                }
                if (member)
                {
                    element.type = ClassType.getInstanceType(member.type);
                    element.classType = element.type.constructorClass;
                }
            }
            return element;
        }
    
    }

}