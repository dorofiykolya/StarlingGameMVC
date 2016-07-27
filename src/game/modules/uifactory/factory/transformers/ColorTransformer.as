package game.modules.uifactory.factory.transformers
{
    import game.modules.uifactory.factory.ElementProperty;
    import common.system.text.StringUtil;
    import flash.utils.Dictionary;
    
    /**
     * ...
     * @author dorofiy.com
     */
    public class ColorTransformer implements IPropertyTransformer
    {
        private var _colors:Object;
        
        public function ColorTransformer()
        {
            _colors = {
                "red":    0xff0000,
                "green":  0x00ff00,
                "blue":   0x0000ff,
                "black":  0x000000,
                "yellow": 0xffff00,
                "dark-yellow": 0xeeee00,
                "magenta":0xff00ff,
                "rose":   0xff00cc,
                "grape":  0xcc00ff,
                "cyan":   0x00ffff,
                "violet": 0x990099,
                "brown":  0xcc9900,
                "white":  0xffffff,
                "orange": 0xffa500,
                "dark-orange": 0xff7f00,
                "dark-orange-2": 0x8b4500,
                "dark-salmon": 0xe9967a,
                "orange-red": 0xff2400,
                "pink":   0xffc0cb,
                "hot-pink": 0xff69b4,
                "deep-pink": 0xff1493,
                "light-pink": 0xffb6c1,
                "coral": 0xff7f50,
                "gray":   0x888888,
                "dark-gray": 0x444444,
                "light-gray": 0xbbbbbb
            };
        }
        
        /* INTERFACE com.okapp.pirates.ui.core.factory.transformers.IPropertyTransformer */
        
        public function apply(item:ElementProperty):void
        {
            var color:String = StringUtil.trim(String(item.value).toLowerCase());
            if (StringUtil.startsWith(color, "0x"))
            {
                item.value = parseInt(item.value, 16);
            }
            else if (StringUtil.startsWith(color, "#"))
            {
                item.value = parseInt(StringUtil.removeCharsAt(color, 0, 1, "0x"), 16);
            }
            else
            {
                if (item.value in _colors)
                {
                    item.value = _colors[item.value];
                }
                else
                {
                    item.value = parseInt(item.value, 10);
                }
            }
        }
    }

}