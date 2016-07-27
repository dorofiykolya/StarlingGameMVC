package starling.extensions.fonts 
{
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import starling.text.BitmapChar;
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BinaryBitmapFont extends BitmapFont 
	{
		
		public function BinaryBitmapFont(texture:Texture, font:ByteArray) 
		{
			super(texture, null);
			parse(font);
		}
		
		// is binary texture font atlas
		public static function isBinaryBitmapFont(bytes:ByteArray):Boolean
		{
			if (bytes.length >= 3)
			{
				var signature:String = String.fromCharCode(bytes[0], bytes[1], bytes[2]);
				return "BFA" == signature;
			}
			return false;
		}
		
		public static function getTexturePath(bytes:ByteArray):String
		{
			var lastPosition:int = bytes.position;
			bytes.position = 3; // skip signature
			var result:String = readString(bytes);
			bytes.position = lastPosition;
			return result;
		}
		
		public static function getFontName(bytes:ByteArray):String
		{
			var lastPosition:int = bytes.position;
			bytes.position = 3; // skip signature
			var textureName:String = readString(bytes); // skip texture name
			var result:String = readString(bytes);
			bytes.position = lastPosition;
			return result;
		}
		
		protected function parse(font:ByteArray):void 
		{
			var scale:Number = mTexture.scale;
            var frame:Rectangle = mTexture.frame;
            var frameX:Number = frame ? frame.x : 0;
            var frameY:Number = frame ? frame.y : 0;
			
			font.position = 3; // skip signature
			var textureName:String = readString(font); // skip TextureName
            
            mName = readString(font);//cleanMasterString(fontXml.info.@face);
            mSize = font.readFloat();// / scale ;//parseFloat(fontXml.info.@size)// / scale;
            mLineHeight = font.readFloat();// / scale;//parseFloat(fontXml.common.@lineHeight)// / scale;
            mBaseline = font.readFloat();// / scale;//parseFloat(fontXml.common.@base)// / scale;
            
            if (font.readByte() == 0)
                smoothing = TextureSmoothing.NONE;
            
            if (mSize <= 0)
            {
                trace("[Starling] Warning: invalid font size in '" + mName + "' font.");
                mSize = (mSize == 0.0 ? 16.0 : mSize * -1.0);
            }
			
			var count:int = font.readInt();
            var i:int;
			
            for (i = 0; i < count; i++)
            {
                var id:int = font.readInt();//parseInt(charElement.@id);
                
                var region:Rectangle = new Rectangle();
                region.x = font.readFloat() / scale + frameX;//parseFloat(charElement.@x) / scale + frameX;
                region.y = font.readFloat() / scale + frameY;//parseFloat(charElement.@y) / scale + frameY;
                region.width  = font.readFloat() / scale;// parseFloat(charElement.@width)  / scale;
                region.height = font.readFloat() / scale;// parseFloat(charElement.@height) / scale;
				
				var xOffset:Number  = font.readFloat() / scale; //parseFloat(charElement.@xoffset)  / scale;
                var yOffset:Number  = font.readFloat() / scale;//parseFloat(charElement.@yoffset)  / scale;
                var xAdvance:Number = font.readFloat() / scale;//parseFloat(charElement.@xadvance) / scale;
                
                var texture:Texture = Texture.fromTexture(mTexture, region);
                var bitmapChar:BitmapChar = new BitmapChar(id, texture, xOffset, yOffset, xAdvance); 
                addChar(id, bitmapChar);
            }
            
			count = font.readInt();
			
            for (i = 0; i < count; i++)
            {
                var first:int  = font.readInt();//parseInt(kerningElement.@first);
                var second:int = font.readInt();// parseInt(kerningElement.@second);
                var amount:Number = font.readFloat() / scale;// parseFloat(kerningElement.@amount) / scale;
                if (second in mChars) getChar(second).addKerning(first, amount);
            }
		}
		
		private static function readString(bytes:ByteArray):String
		{
			var len:int = bytes.readInt();
			return bytes.readUTFBytes(len);
		}
		
	}

}