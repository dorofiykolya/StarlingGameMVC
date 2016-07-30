package game.mvc.view.controllers
{
	import common.system.Environment;
	import common.system.IDisposable;
	import common.system.utils.ObjectUtils;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.utils.getTimer;
	import starling.animation.IAnimatable;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.EventDispatcher;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	[Event(name = "click", type = "game.mvc.view.controllers.TouchControllerEvent")]
	[Event(name = "down", type = "game.mvc.view.controllers.TouchControllerEvent")]
	[Event(name = "up", type = "game.mvc.view.controllers.TouchControllerEvent")]
	[Event(name = "over", type = "game.mvc.view.controllers.TouchControllerEvent")]
	[Event(name = "out", type = "game.mvc.view.controllers.TouchControllerEvent")]
	[Event(name = "clickWithoutDrag", type = "game.mvc.view.controllers.TouchControllerEvent")]
	[Event(name = "swipe", type = "game.mvc.view.controllers.TouchControllerEvent")]
	[Event(name = "upWithoutDrag", type = "game.mvc.view.controllers.TouchControllerEvent")]
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class TouchController extends EventDispatcher implements IDisposable 
	{
		public static const GESTURE_SWIPE_DIRECTION_X:String = "gestureSwipeDirectionX";
		public static const GESTURE_SWIPE_DIRECTION_Y:String = "gestureSwipeDirectionY";
		
		private static const DEFAULT_REPEAT_DELAY:Number = 0.1;
		
		public static var defaultClickSound:Sound;
		public static var defaultClickSoundUrl:String;
		public static var defaultClickSoundСondition:Function;
		
		protected var _isMobile:Boolean;
		protected var _downHandlerInvoked:Boolean;
		protected var _disposed:Boolean;
		protected var _instance:DisplayObject;
		protected var _enabled:Boolean;
		protected var _isDown:Boolean;
		protected var _isOver:Boolean;
		protected var _scaleWhenDownX:Number;
		protected var _scaleWhenDownY:Number;
		protected var _scaleWhenUpX:Number;
		protected var _scaleWhenUpY:Number;
		protected var _upPosition:Point;
		protected var _useHandCursor:Boolean;
		protected var _useScale:Boolean;
		protected var _useOver:Boolean;
		protected var _autoRepeat:Boolean;
		protected var _startAutoRepeat:Boolean;
		protected var _isDrag:Boolean;
		protected var _useSoundClick:Boolean;
		protected var _soundUrl:String;
		protected var _sound:flash.media.Sound;
		protected var _soundСondition:Function;
		protected var _lastClickTime:Number;
		protected var _clickDelay:Number;
		protected var _gestureSwipe:Boolean;
		protected var _gestureRect:Rectangle;
		protected var _gestureSwipeDirection:Point;
		protected var _autoRepeatDelay:Number;
		protected var _noiseRect:Rectangle;
		protected var _startPosition:Point;
		protected var _endPosition:Point;
        protected var _exclude:Array;
		protected var _thresholdX:Number;
		protected var _thresholdY:Number;
		protected var _useScaleOffet:Boolean;
		protected var _useTween:Boolean;
		protected var _upTweenTime:Number;
		protected var _downTweenTime:Number;
		
		private var _timer:TimerTouchController;
		private var _autoRepeatEvent:TouchControllerEvent
		private var _isUpTween:Boolean;
		private var _upTween:Tween;
		private var _isDownTween:Boolean;
		private var _downTween:Tween;
		
		public function TouchController(instance:DisplayObject, useScale:Boolean = false, properties:Object = null)
		{
			_instance = instance;
			_useScale = useScale;
			_isDown = false;
			_isDrag = false;
			_isOver = false;
			_scaleWhenDownX = 0.9;
			_scaleWhenDownY = 0.9;
			_useHandCursor = false;
			_thresholdX = 0;
			_thresholdY = 0;
			_lastClickTime = 0;
			_enabled = true;
			_upPosition = new Point();
			_useOver = true;
			_useScaleOffet = true;
			_useSoundClick = true;
			//_clickDelay = clickDelay;
			_gestureRect = new Rectangle(0, 0, 300, 300);
			_gestureSwipeDirection = new Point(NaN, NaN);
			_autoRepeatDelay = DEFAULT_REPEAT_DELAY;
			_noiseRect = new Rectangle(0, 0, 25, 25);
			_startPosition = new Point();
			_endPosition = new Point();
			_upTweenTime = .4;
			_downTweenTime = .05;
			_upTween = new Tween(_instance, _upTweenTime);
			_downTween = new Tween(_instance, _downTweenTime);
			_useTween = true;
			
			if (defaultClickSound)
			{
				_sound = defaultClickSound;
			}
			else if (defaultClickSoundUrl)
			{
				_sound = new flash.media.Sound(new URLRequest(defaultClickSoundUrl), new SoundLoaderContext(1000, true));
			}
			_soundСondition = defaultClickSoundСondition;
			
			_isMobile = Environment.isMobile;
			_instance.addEventListener(TouchEvent.TOUCH, touchHandler);
			stopAutoRepeat();
			
			if (properties)
			{
				for each (var propertyName:String in ObjectUtils.getNamesOfMembers(properties, ObjectUtils.CONSTANT_FLAG | ObjectUtils.DYNAMIC_FLAG | ObjectUtils.FIELD_FLAG | ObjectUtils.PROPERTY_READ_FLAG)) 
				{
					if (propertyName in this)
					{
						this[propertyName] = properties[propertyName];
					}
				}
			}
		}
		
		public function get target():DisplayObject
		{
			return _instance;
		}
		
		public function set clickDelay(value:Number):void
		{
			if (isNaN(value))
			{
				return;
			}
			if (value < 0)
			{
				value = 0;
			}
			_clickDelay = value;
		}
		
		/**
		 * click delay in seconds
		 */
		public function get clickDelay():Number
		{
			return _clickDelay;
		}
		
		public function get thresholdX():Number
		{
			return _thresholdX;
		}
		
		public function get thresholdY():Number
		{
			return _thresholdY;
		}
		
		public function set thresholdX(value:Number):void
		{
			if (value != value)
			{
				value = 0;
			}
			_thresholdX = value;
		}
		
		public function set thresholdY(value:Number):void
		{
			if (value != value)
			{
				value = 0;
			}
			_thresholdY = value;
		}
		
		private function touchHandler(e:TouchEvent):void
		{
            if (_exclude && _exclude.indexOf(e.target) != -1) 
            {
                return;
            }
			if (_enabled == false)
			{
				if (_isMobile == false)
				{
					if (_useHandCursor)
					{
						Mouse.cursor = MouseCursor.AUTO;
					}
				}
				stopAutoRepeat();
				return;
			}
			var touch:Touch = e.getTouch(_instance);
			if (touch == null)
			{
				if (_isMobile == false)
				{
					if (_isOver)
					{
						_isOver = false;
						outState(e);
					}
					if (_useHandCursor)
					{
						Mouse.cursor = MouseCursor.AUTO;
					}
				}
				stopAutoRepeat();
				return;
			}
			if (_isMobile == false && _useHandCursor)
			{
				var mouseCursorEnabled:Boolean = true;
				var isInteractsWith:Boolean;
				if ("enabled" in _instance)
				{
					mouseCursorEnabled = Object(_instance).enabled;
				}
				else if ("isEnabled" in _instance)
				{
					mouseCursorEnabled = Object(_instance).isEnabled;
				}
				if (mouseCursorEnabled == false)
				{
					if (_useHandCursor)
					{
						Mouse.cursor = MouseCursor.AUTO;
					}
				}
				else if (_useHandCursor)
				{
					isInteractsWith = e.interactsWith(_instance);
					if (mouseCursorEnabled && isInteractsWith)
					{
						Mouse.cursor = MouseCursor.BUTTON;
					}
					else
					{
						Mouse.cursor = MouseCursor.AUTO;
					}
				}
			}
			if (touch.phase == TouchPhase.BEGAN && !_isDown)
			{
				_isDown = true;
				_startPosition.x = touch.globalX;
				_startPosition.y = touch.globalY;
				_gestureSwipeDirection.x = NaN;
				_gestureSwipeDirection.y = NaN;
				startAutoRepeat(e);
				
				downHandler(e);
			}
			else if (touch.phase == TouchPhase.MOVED && _isDown)
			{
				var buttonRect:Rectangle = _instance.getBounds(_instance.stage);
				
				if (touch.globalX + _thresholdX < buttonRect.x || touch.globalY + _thresholdY < buttonRect.y || touch.globalX > buttonRect.x + buttonRect.width + _thresholdX || touch.globalY > buttonRect.y + buttonRect.height + _thresholdY)
				{
					_isDown = false;
					stopAutoRepeat();
					if (_isOver && _isMobile == false)
					{
						_isOver = false;
						outState(e);
					}
					if (_useScale || _downHandlerInvoked)
					{
						upHandler(e);
					}
				}
			}
			else if (touch.phase == TouchPhase.ENDED && _isDown)
			{
				_isDown = false;
				_endPosition.x = touch.globalX;
				_endPosition.y = touch.globalY;
				
				if (!_noiseRect.contains(Math.abs(_startPosition.x - _endPosition.x), Math.abs(_startPosition.y - _endPosition.y)))
				{
					_isDrag = true;
				}
				
				if (_gestureSwipe)
				{
					if (!_gestureRect.contains(Math.abs(_startPosition.x - _endPosition.x), Math.abs(_startPosition.y - _endPosition.y)))
					{
						if (equalsNumberThreshould(_startPosition.x, _endPosition.x, 20))
						{
							_gestureSwipeDirection.x = 0;
						}
						else if(_startPosition.x > _endPosition.x)
						{
							_gestureSwipeDirection.x = -1;
						}
						else if(_startPosition.x < _endPosition.x)
						{
							_gestureSwipeDirection.x = 1;
						}
						
						if (equalsNumberThreshould(_startPosition.y, _endPosition.y, 20))
						{
							_gestureSwipeDirection.y = 0;
						}
						else if(_startPosition.y > _endPosition.y)
						{
							_gestureSwipeDirection.y = -1;
						}
						else if(_startPosition.y < _endPosition.y)
						{
							_gestureSwipeDirection.y = 1;
						}
						
						swipeHandler(e);
					}
					else
					{
						_gestureSwipeDirection.x = NaN;
						_gestureSwipeDirection.y = NaN;
					}
				}
				
				stopAutoRepeat();
				if (_useScale || _downHandlerInvoked)
				{
					upHandler(e);
				}
				clickHandler(e);
			}
		}
		
		private function equalsNumberThreshould(v1:Number, v2:Number, threshould:Number = 10):Boolean
		{
			return Math.abs(v1 - v2) <= threshould;
		}
		
		private function swipeHandler(e:TouchEvent):void 
		{
			if (hasEventListener(TouchControllerEvent.SWIPE))
			{
				dispatchEvent(new TouchControllerEvent(TouchControllerEvent.SWIPE, e.touches, e.shiftKey, e.ctrlKey, e.bubbles, false, e.target));
			}
		}
		
		protected function overState(e:TouchEvent):void
		{
			stopAutoRepeat();
			if (hasEventListener(TouchControllerEvent.OVER))
			{
				dispatchEvent(new TouchControllerEvent(TouchControllerEvent.OVER, e.touches, e.shiftKey, e.ctrlKey, e.bubbles, false, e.target));
			}
		}
		
		protected function outState(e:TouchEvent):void
		{
			stopAutoRepeat();
			if (hasEventListener(TouchControllerEvent.OUT))
			{
				dispatchEvent(new TouchControllerEvent(TouchControllerEvent.OUT, e.touches, e.shiftKey, e.ctrlKey, e.bubbles, false, target));
			}
		}
		
		protected function validateOverState(e:TouchEvent):void
		{
			if (_isOver)
			{
				if (hasEventListener(TouchControllerEvent.OVER))
				{
					dispatchEvent(new TouchControllerEvent(TouchControllerEvent.OVER, e.touches, e.shiftKey, e.ctrlKey, e.bubbles, false, target));
				}
			}
			else
			{
				if (hasEventListener(TouchControllerEvent.OUT))
				{
					dispatchEvent(new TouchControllerEvent(TouchControllerEvent.OUT, e.touches, e.shiftKey, e.ctrlKey, e.bubbles, false, target));
				}
			}
		}
		
		protected function clickHandler(e:TouchEvent):void
		{
			if (_useSoundClick)
			{
				var result:* = true;
				if (_soundСondition as Function)
				{
					result = _soundСondition.apply(null, null);
					if (result == undefined)
					{
						result = true;
					}
				}
				if (_sound && result)
				{
					_sound.play();
				}
			}
			var now:Number = getTimer() / 1000;
			if (now - _lastClickTime <= _clickDelay)
			{
				return;
			}
			_lastClickTime = now;
			if (hasEventListener(TouchControllerEvent.CLICK))
			{
				dispatchEvent(new TouchControllerEvent(TouchControllerEvent.CLICK, e.touches, e.shiftKey, e.ctrlKey, e.bubbles, false, target));
			}
			
			if (_isDrag == false)
			{
				if (hasEventListener(TouchControllerEvent.CLICK_WITHOUT_DRAG))
				{
					dispatchEvent(new TouchControllerEvent(TouchControllerEvent.CLICK_WITHOUT_DRAG, e.touches, e.shiftKey, e.ctrlKey, e.bubbles, false, target));
				}
			}
			
			_isDrag = false;
		}
		
		protected function downHandler(e:TouchEvent):void
		{
			_downHandlerInvoked = true;
			if (_useScale)
			{
				if (!_isDownTween && !_isUpTween)
				{
					_upPosition.x = _instance.x;
					_upPosition.y = _instance.y;
					
					_scaleWhenUpX = _instance.scaleX;
					_scaleWhenUpY = _instance.scaleY;
				
					_scaleWhenDownX = _scaleWhenUpX * 0.9;
					_scaleWhenDownY = _scaleWhenUpY * 0.9;
					
					if (isNaN(_scaleWhenDownX))
					{
						_scaleWhenDownX = 1;
						_scaleWhenUpX = 1;
					}
					
					if (isNaN(_scaleWhenDownY))
					{
						_scaleWhenDownY = 1;
						_scaleWhenUpY = 1;
					}
				}
				
				var calcXOffset:Number = (_instance.width - _instance.width * 0.9) / 2;
				var calcYOffset:Number = (_instance.height - _instance.height * 0.9) / 2;
				
				if (_useTween)
				{
					removeUpTween();
					_downTween.reset(_instance, _downTweenTime, Transitions.LINEAR);
					_downTween.scaleToXY(_scaleWhenDownX, _scaleWhenDownY);
					if (_useScaleOffet)
					{
						_downTween.moveTo(_instance.x + calcXOffset, _instance.y + calcYOffset);
					}
					Starling.juggler.add(_downTween);
				}
				else
				{
					if (_useScaleOffet)
					{
						_instance.x += calcXOffset;
						_instance.y += calcYOffset;
					}
					_instance.scaleX = _scaleWhenDownX
					_instance.scaleY = _scaleWhenDownY;
				}
			}
			if (hasEventListener(TouchControllerEvent.DOWN))
			{
				dispatchEvent(new TouchControllerEvent(TouchControllerEvent.DOWN, e.touches, e.shiftKey, e.ctrlKey, e.bubbles, false, target));
			}
		}
		
		protected function startAutoRepeat(e:TouchEvent):void
		{
			if (_autoRepeat)
			{
				_startAutoRepeat = true;
				if (_timer != null)
				{
					_timer.stop();
				}
				_timer = new TimerTouchController(Starling.current, _autoRepeatDelay, onAutoRepeat);
				_timer.start();
				_autoRepeatEvent = new TouchControllerEvent(TouchControllerEvent.CLICK, e.touches, e.shiftKey, e.ctrlKey, e.bubbles, true, e.target);
			}
		}
		
		protected function stopAutoRepeat():void
		{
			_startAutoRepeat = false;
			if (_timer != null)
			{
				_timer.stop();
				_timer = null;
			}
		}
		
		protected function onAutoRepeat():void
		{
			if (hasEventListener(TouchControllerEvent.CLICK))
			{
				dispatchEvent(_autoRepeatEvent);
			}
		}
		
		protected function upHandler(e:TouchEvent):void
		{
			_downHandlerInvoked = false;
			if (_useScale)
			{
				if (_scaleWhenUpX == _scaleWhenUpX && _scaleWhenUpY == _scaleWhenUpY)
				{
					if (_useTween)
					{
						removeDownTween();
						_upTween.reset(_instance, _upTweenTime, Transitions.EASE_OUT_ELASTIC);
						_upTween.scaleToXY(_scaleWhenUpX, _scaleWhenUpY);
						if (_useScaleOffet)
						{
							_upTween.moveTo(_upPosition.x, _upPosition.y);
						}
						Starling.juggler.add(_upTween);
						_isUpTween = true;
					}
					else
					{
						_instance.scaleX = _scaleWhenUpX
						_instance.scaleY = _scaleWhenUpY;
						if (_useScaleOffet)
						{
							_instance.x = _upPosition.x;
							_instance.y = _upPosition.y;
						}
					}
				}
			}
			if (_isDrag == false)
			{
				if (hasEventListener(TouchControllerEvent.UP_WITHOUT_DRAG))
				{
					dispatchEvent(new TouchControllerEvent(TouchControllerEvent.UP_WITHOUT_DRAG, e.touches, e.shiftKey, e.ctrlKey, e.bubbles, false, target));
				}
			}
			if (hasEventListener(TouchControllerEvent.UP))
			{
				dispatchEvent(new TouchControllerEvent(TouchControllerEvent.UP, e.touches, e.shiftKey, e.ctrlKey, e.bubbles, false, target));
			}
		}
		
		protected function removeDownTween():void
		{
			if (_isDownTween)
			{
				Starling.juggler.remove(_downTween);
				_isDownTween = false;
			}
		}
		
		protected function removeUpTween():void
		{
			if (_isUpTween)
			{
				Starling.juggler.remove(_upTween);
				_isUpTween = false;
			}
		}
		
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
			if (value == false)
			{
				stopAutoRepeat();
			}
		}
		
		public function get useHandCursor():Boolean
		{
			return _useHandCursor;
		}
		
		public function set useHandCursor(value:Boolean):void
		{
			_useHandCursor = value;
		}
		
		public function get useScale():Boolean
		{
			return _useScale;
		}
		
		public function set useScale(value:Boolean):void
		{
			_useScale = value;
		}
		
		public function get isOver():Boolean
		{
			return _isOver;
		}
		
		public function get isDown():Boolean
		{
			return _isDown;
		}
		
		public function get autoRepeat():Boolean
		{
			return _autoRepeat;
		}
		
		public function set autoRepeat(value:Boolean):void
		{
			_autoRepeat = value;
			if (!_autoRepeat)
			{
				if (_timer != null)
				{
					_timer.stop();
					_timer = null;
				}
			}
		}
		
		public function set autoRepeatDelay(value:Number):void
		{
			if (value <= 0.02) 
			{
				value = DEFAULT_REPEAT_DELAY;
			}
			_autoRepeatDelay = value;
			if (_timer != null)
			{
				_timer.delay = _autoRepeatDelay;
			}
		}
		
		public function get autoRepeatDelay():Number
		{
			return _autoRepeatDelay;
		}
		
		public function get gestureSwipeOffsetX():Number
		{
			return _gestureRect.width;
		}
		
		public function set gestureSwipeOffsetX(value:Number):void
		{
			_gestureRect.width = value;
		}
		
		public function get gestureSwipeOffsetY():Number
		{
			return _gestureRect.height;
		}
		
		public function set gestureSwipeOffsetY(value:Number):void
		{
			_gestureRect.height = value;
		}
		
		public function get gestureSwipeDirection():Point
		{
			return _gestureSwipeDirection;
		}
		
		public function set gestureSwipe(value:Boolean):void
		{
			_gestureSwipe = value;
		}
		
		public function get gestureSwipe():Boolean
		{
			return _gestureSwipe;
		}
		
		public function get useSoundClick():Boolean
		{
			return _useSoundClick;
		}
		
		public function set useSoundClick(value:Boolean):void
		{
			_useSoundClick = value;
		}
		
		public function get sound():flash.media.Sound
		{
			return _sound;
		}
		
		public function set sound(value:flash.media.Sound):void
		{
			_sound = value;
		}
		
		public function get soundUrl():String
		{
			return _soundUrl;
		}
		
		public function set soundUrl(value:String):void
		{
			_soundUrl = value;
			if (value)
			{
				_sound = new flash.media.Sound(new URLRequest(value), new SoundLoaderContext(1000, true));
			}
		}
		/**
		 * must return Boolean (true or false)
		 */
		public function get soundСondition():Function
		{
			return _soundСondition;
		}
		
		public function set soundСondition(value:Function/*():Boolean*/):void
		{
			_soundСondition = value;
		}
        
        public function get exclude():Array 
        {
            return _exclude;
        }
        
        public function set exclude(value:Array):void 
        {
            _exclude = value;
        }
		
		public function get useScaleOffet():Boolean 
		{
			return _useScaleOffet;
		}
		
		public function set useScaleOffet(value:Boolean):void 
		{
			_useScaleOffet = value;
		}
		
		public function get useTween():Boolean 
		{
			return _useTween;
		}
		
		public function set useTween(value:Boolean):void 
		{
			_useTween = value;
		}
		
		public function get tweenTime():Number 
		{
			return _upTweenTime;
		}
		
		public function set tweenTime(value:Number):void 
		{
			_upTweenTime = value;
		}
		
		public function get downTweenTime():Number 
		{
			return _downTweenTime;
		}
		
		public function set downTweenTime(value:Number):void 
		{
			_downTweenTime = value;
		}
		
		public function reset():void
		{
            _exclude = null;
			stopAutoRepeat();
			removeEventListeners();
		}
		
		public function dispose():void
		{
			if (_disposed)
			{
				return;
			}
			_disposed = false;
			_autoRepeat = false;
            _exclude = null;
			stopAutoRepeat();
			if (_instance)
			{
				_instance.removeEventListener(TouchEvent.TOUCH, touchHandler);
				_instance = null;
			}
			super.removeEventListeners();
		}
	}
}
import starling.animation.IAnimatable;
import starling.animation.Juggler;
import starling.core.Starling;

class TimerTouchController implements IAnimatable
{
	private var _started:Boolean;
	private var _delay:Number;
	private var _elapsedTime:Number;
	private var _autoRepeat:Function;
	private var _juggler:Juggler;
	
	public function TimerTouchController(starling:Starling, delay:Number, autoRepeat:Function)
	{
		_juggler = starling.juggler;
		_delay = delay;
		_elapsedTime = 0.0;
		_autoRepeat = autoRepeat;
	}
	
	public function start():void
	{
		_started = true;
		_juggler.add(this);
	}
	
	public function stop():void
	{
		_started = false;
		_juggler.remove(this);
	}
	
	public function advanceTime(time:Number):void
	{
		if (_autoRepeat != null)
		{
			_elapsedTime += time;
			if (_elapsedTime >= _delay)
			{
				_elapsedTime = 0.0;
				_autoRepeat();
			}
		}
	}
	
	public function set delay(value:Number):void 
	{
		_elapsedTime = 0.0;
		_delay = value;
	}
	
	public function get delay():Number
	{
		return _delay;
	}
}