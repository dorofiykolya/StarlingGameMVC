package starling.extensions.textures
{
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class BinaryTextureAtlas extends TextureAtlas
	{
		
		public function BinaryTextureAtlas(texture:Texture, atlas:ByteArray)
		{
			super(texture, null);
			parse(atlas);
		}
		
		// is binary texture atlas
		public static function isBinaryTextureAtlas(bytes:ByteArray):Boolean
		{
			if (bytes.length >= 3)
			{
				var signature:String = String.fromCharCode(bytes[0], bytes[1], bytes[2]);
				return "BTA" == signature;
			}
			return false;
		}
		
		public static function getTexturePath(bytes:ByteArray):String
		{
			if (isBinaryTextureAtlas(bytes))
			{
				var lastPosition:int = bytes.position;
				bytes.position = 3;
				var result:String = readString(bytes);
				bytes.position = lastPosition;
				return result;
			}
			throw new ArgumentError();
			return null;
		}
		
		protected function parse(bytes:ByteArray):void
		{
			if (!isBinaryTextureAtlas(bytes))
			{
				throw new ArgumentError();
			}
			
			var scale:Number = texture.scale;
			
			bytes.position = 3;
			var imagePath:String = readString(bytes); // skip <TextureAtlas imagePath>
			
			var count:int = bytes.readInt();
			var region:Rectangle = new Rectangle();
            var frame:Rectangle  = new Rectangle();
			
			for (var i:int = 0; i < count; i++) 
			{
				var name:String			= readString(bytes);
                var x:Number   			= bytes.readFloat() / scale;
                var y:Number   			= bytes.readFloat() / scale;
                var width:Number		= bytes.readFloat() / scale;
                var height:Number		= bytes.readFloat() / scale;
                var frameX:Number		= bytes.readFloat() / scale;
                var frameY:Number		= bytes.readFloat() / scale;
                var frameWidth:Number  	= bytes.readFloat() / scale;
                var frameHeight:Number 	= bytes.readFloat() / scale;
				var rotated:Boolean     = bytes.readBoolean();
				
                region.setTo(x, y, width, height);
                frame.setTo(frameX, frameY, frameWidth, frameHeight);

                if (frameWidth > 0 && frameHeight > 0)
                    addRegion(name, region, frame, rotated);
                else
                    addRegion(name, region, null,  rotated);
			}
		}
		
		private static function readString(bytes:ByteArray):String
		{
			var len:int = bytes.readInt();
			return bytes.readUTFBytes(len);
		}
	
	}

}