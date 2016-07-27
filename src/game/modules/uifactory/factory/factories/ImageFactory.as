package game.modules.uifactory.factory.factories 
{
	import game.modules.assets.ITextureProvider;
    import game.modules.uifactory.factory.Element;
    import starling.display.Image;
    import starling.textures.Texture;
	/**
     * ...
     * @author dorofiy.com
     */
    public class ImageFactory implements IFactory 
    {
        [Inject]
        public var textureProvider:ITextureProvider;
        
        public function ImageFactory() 
        {
            
        }
        
        /* INTERFACE com.okapp.pirates.ui.core.factory.factories.IFactory */
        
        public function apply(element:Element):Object 
        {
            var textureName:String = element.ctor[0];
            var texture:Texture = textureProvider.getTexture(textureName);
            return new Image(texture);
        }
        
    }

}