package game.modules.animations
{
	import starling.animation.IAnimatable;
	import starling.core.RenderSupport;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.filters.FragmentFilter;
	
	[Event(name = "complete", type = "starling.events.Event")]
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class StateImageClip extends DisplayObjectContainer implements IAnimatable
	{
		private var _map:Object;
		private var _previous:String;
		private var _state:String;
		private var _current:MovieClip;
		
		public function StateImageClip()
		{
			_map = {};
		}
		
		public function map(stateName:String, clip:MovieClip):void
		{
			_map[stateName] = clip;
			insert(clip);
			if (_current == null)
			{
				setState(stateName);
			}
		}
		
		public function get states():Vector.<String>
		{
			var result:Vector.<String> = new Vector.<String>();
			for (var item:String in _map)
			{
				result[result.length] = item;
			}
			return result;
		}
		
		public function get previous():String
		{
			return _previous;
		}
		
		public function get state():String
		{
			return _state;
		}
		
		public function setState(value:String, startOver:Boolean = false):void
		{
			if (_state != value)
			{
				_previous = _state;
				_state = value;
				updateState(_state, startOver);
			}
		}
		
		override public function render(support:RenderSupport, parentAlpha:Number):void
		{
			if (_current == null) return;
			
			var alpha:Number = parentAlpha * this.alpha;
			var blendMode:String = support.blendMode;
			var saturation:Boolean = support.saturated;
			var thisSaturated:Boolean = saturated;
			
			if (thisSaturated == false) support.saturated = false;
			
			var child:DisplayObject = _current;
			
			if (child.hasVisibleArea)
			{
				var filter:FragmentFilter = child.filter;
				var mask:DisplayObject = child.mask;
				
				support.pushMatrix();
				support.transformMatrix(child);
				support.blendMode = child.blendMode;
				if (child.saturated == false) support.saturated = false;
				if (mask) support.pushMask(mask);
				if (filter) filter.render(child, support, alpha);
				else child.render(support, alpha);
				
				if (mask) support.popMask();
				
				support.saturated = thisSaturated && saturation;
				
				support.blendMode = blendMode;
				support.popMatrix();
			}
			support.saturated = saturation;
		}
		
		/* INTERFACE starling.animation.IAnimatable */
		
		public function advanceTime(time:Number):void
		{
			if (_current != null)
			{
				_current.advanceTime(time);
			}
		}
		
		/* DELEGATE starling.display.ImageClip */
		
		public function get fps():Number
		{
			return _current.fps;
		}
		
		public function set fps(value:Number):void
		{
			_current.fps = value;
		}
		
		public function pause():void
		{
			_current.pause();
		}
		
		public function play():void
		{
			_current.play();
		}
		
		public function stop():void
		{
			_current.stop();
		}
		
		private function updateState(state:String, startOver:Boolean):void
		{
			var previousFrame:int;
			if (_current != null)
			{
				previousFrame = _current.currentFrame;
				//_current.cutFromParent();
				_current.removeEventListener(Event.COMPLETE, onAnimationComplete);
			}
			var clip:MovieClip = _map[state];
			if (clip != null)
			{
				_current = clip;
				if (!_current.loop)
				{
					if (_current.currentFrame == _current.numFrames - 1)
					{
						_current.currentFrame = 0;
					}
					_current.addEventListener(Event.COMPLETE, onAnimationComplete);
				}
				else if (startOver)
				{
					_current.currentFrame = 0;
				}
				else if (_current.numFrames > previousFrame)
				{
					_current.currentFrame = previousFrame;
				}
				
					//insert(clip);
			}
		}
		
		private function onAnimationComplete(e:Event):void
		{
			_current.currentFrame = 0;
			dispatchEventWith(Event.COMPLETE);
		}
	
	}

}