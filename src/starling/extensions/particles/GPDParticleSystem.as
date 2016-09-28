package starling.extensions.particles
{
	import common.system.color.Color;
	import common.system.utils.ObjectUtils;
	import starling.extensions.PDParticleSystem;
	import starling.extensions.Particle;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class GPDParticleSystem extends PDParticleSystem
	{
		private var _colors:Vector.<Number>;
		private var _colorsRatios:Vector.<Number>;
		private var _alphas:Vector.<Number>;
		
		private var _sizes:Vector.<Number>;
		private var _sizeRatios:Vector.<Number>;
		
		public function GPDParticleSystem(config:XML, texture:Texture)
		{
			super(config, texture);
			parseConfig(config);
		}
		
		private function parseConfig(config:XML):void
		{
			if (config.hasOwnProperty("colors"))
			{
				parseColors(config);
			}
			
			if (config.hasOwnProperty("sizes"))
			{
				parseSizes(config);
			}
		}
		
		private function parseColors(config:XML):void
		{
			var colors:String = String(config.colors.@colors);
			var ratios:String = String(config.colors.@ratios);
			var alphas:String = String(config.colors.@alphas);
			
			_colors = Vector.<Number>(ObjectUtils.toType(colors.split(","), Class(Vector.<Number>)));
			_colorsRatios = Vector.<Number>(ObjectUtils.toType(ratios.split(","), Class(Vector.<Number>)));
			_alphas = Vector.<Number>(ObjectUtils.toType(alphas.split(","), Class(Vector.<Number>)));
			
			if (_colors.length != _colorsRatios.length || _colors.length != _alphas.length || _colorsRatios.length != _alphas.length)
			{
				throw new ArgumentError();
			}
		}
		
		private function parseSizes(config:XML):void
		{
			var sizes:String = String(config.sizes.@sizes);
			var ratios:String = String(config.sizes.@ratios);
			
			_sizes = Vector.<Number>(ObjectUtils.toType(sizes.split(","), Class(Vector.<Number>)));
			_sizeRatios = Vector.<Number>(ObjectUtils.toType(ratios.split(","), Class(Vector.<Number>)));
			
			if (_sizes.length != _sizeRatios.length)
			{
				throw new ArgumentError();
			}
		}
		
		override protected function createParticle():Particle
		{
			return new GPDParticle();
		}
		
		override protected function advanceParticle(aParticle:Particle, passedTime:Number):void
		{
			super.advanceParticle(aParticle, passedTime);
			if (_colors)
			{
				updateColors(aParticle);
			}
			if (_sizes)
			{
				updateSize(aParticle);
			}
		}
		
		private function updateSize(aParticle:Particle):void 
		{
			var particle:GPDParticle = aParticle as GPDParticle;
			var ratio:Number = particle.currentTime / particle.totalTime;
			ratio = Math.min(1, ratio);
			ratio = Math.max(0, ratio);
			
			var index:int = (_sizes.length - 1) * ratio;
			var left:int = index;
			var right:int = index + 1 >= _sizes.length ? index : index + 1;
			var leftValue:Number = _sizeRatios[left];
			var rightValue:Number = _sizeRatios[right];
			
			var localTotal:Number = rightValue - leftValue;
			var localRatio:Number = (ratio - leftValue) / localTotal;
			
			var newSize:Number = interpolate(_sizes[left], _sizes[right], localRatio);
			particle.scale = newSize;
		}
		
		private function updateColors(aParticle:Particle):void
		{
			var particle:GPDParticle = aParticle as GPDParticle;
			var ratio:Number = particle.currentTime / particle.totalTime;
			ratio = Math.min(1, ratio);
			ratio = Math.max(0, ratio);
			
			var index:int = (_colorsRatios.length - 1) * ratio;
			var left:int = index;
			var right:int = index + 1 >= _colorsRatios.length ? index : index + 1;
			var leftValue:Number = _colorsRatios[left];
			var rightValue:Number = _colorsRatios[right];
			
			var localTotal:Number = rightValue - leftValue;
			var localRatio:Number = (ratio - leftValue) / localTotal;
			
			var newColor:Number = Color.interpolateColorsRgb(_colors[left], _colors[right], localRatio);
			var newAlpha:Number = interpolate(_alphas[left], _alphas[right], localRatio);
			
			particle.color = newColor;
			particle.alpha = newAlpha;
		}
		
		private function interpolate(left:Number, right:Number, ratio:Number):Number
		{
			return left * (1.0 - ratio) + right * ratio;
		}
	
	}

}