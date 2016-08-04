package game.modules.animations
{
	import game.modules.animations.descriptions.DescriptionType;
	import game.modules.animations.descriptions.SParticleSystem;
	import starling.animation.IAnimatable;
	import starling.display.DisplayObject;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.ParticleSystem;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LayerViewer extends Sprite implements IAnimatable
	{
		private var _moveZ:Boolean;
		private var _id:String;
		private var _z:Number;
		private var _states:Vector.<StateImageClip>;
		private var _clips:Vector.<MovieClip>;
		private var _particles:Vector.<ParticleSystem>;
		private var _sparticles:Vector.<SParticleSystem>;
		private var _state:String;
		private var _previous:String;
		private var _timeScale:Number;
		private var _name:String;
		private var _container:Sprite;
		private var _customY:Number;
		private var _keys:Vector.<String>;
		private var _customProperties:Object;
		
		public function LayerViewer(layerName:String)
		{
			_container = new Sprite();
			insert(_container);
			_name = layerName;
			_states = new Vector.<StateImageClip>();
			_clips = new Vector.<MovieClip>();
			_particles = new Vector.<ParticleSystem>();
			_sparticles = new Vector.<SParticleSystem>();
			_timeScale = 1.0;
			_z = 0.0;
			_moveZ = true;
			_keys = new Vector.<String>();
			name = layerName;
		}
		
		public function get customProperties():Object
		{
			return _customProperties || (_customProperties = {});
		}
		
		public function get clips():Vector.<MovieClip>
		{
			return _clips;
		}
		
		public function get states():Vector.<StateImageClip>
		{
			return _states;
		}
		
		public function setFlag(key:String):void
		{
			if (!isFlag(key))
			{
				_keys.push(key);
			}
		}
		
		public function isFlag(key:String):Boolean
		{
			return _keys.indexOf(key) != -1;
		}
		
		public function removeFlag(key:String):void
		{
			var index:int = _keys.indexOf(key);
			if (index != -1)
			{
				_keys.splice(index, 1);
			}
		}
		
		public function getElement(name:String):DisplayObject
		{
			return _container.getChildByName(name);
		}
		
		public function get layerName():String
		{
			return _name;
		}
		
		public function play():void
		{
			for each (var clip:MovieClip in _clips)
			{
				clip.play();
			}
			
			for each (var stateClip:StateImageClip in _states)
			{
				stateClip.play();
			}
			
			for each (var particle:ParticleSystem in _particles)
			{
				particle.start();
			}
			
			for each (var sparticle:SParticleSystem in _sparticles)
			{
				sparticle.play();
			}
		}
		
		public function pause():void
		{
			for each (var clip:MovieClip in _clips)
			{
				clip.pause();
			}
			
			for each (var stateClip:StateImageClip in _states)
			{
				stateClip.pause();
			}
			
			for each (var particle:ParticleSystem in _particles)
			{
				particle.stop();
			}
			
			for each (var sparticle:SParticleSystem in _sparticles)
			{
				sparticle.pause();
			}
		}
		
		public function stop():void
		{
			for each (var clip:MovieClip in _clips)
			{
				clip.stop();
			}
			
			for each (var stateClip:StateImageClip in _states)
			{
				stateClip.stop();
			}
			
			for each (var particle:ParticleSystem in _particles)
			{
				particle.stop(true);
			}
			
			for each (var sparticle:SParticleSystem in _sparticles)
			{
				sparticle.stop();
			}
		}
		
		public function add(type:DescriptionType, value:DisplayObject):void
		{
			if (type == DescriptionType.IMAGE)
			{
				_container.insert(value);
			}
			else if (type == DescriptionType.CLIP)
			{
				_clips[_clips.length] = MovieClip(value);
				_container.insert(value);
			}
			else if (type == DescriptionType.STATE)
			{
				_states[_states.length] = StateImageClip(value);
				_container.insert(value);
			}
			else if (type == DescriptionType.PARTICLE)
			{
				_particles[_particles.length] = ParticleSystem(value);
				_container.insert(value);
			}
			else if (type == DescriptionType.SPARTICLE)
			{
				_sparticles[_sparticles.length] = SParticleSystem(value);
				_container.insert(value);
			}
			else if (type == DescriptionType.UI)
			{
				_container.insert(value);
			}
			else
			{
				_container.insert(value);
			}
		}
		
		public function advanceTime(time:Number):void
		{
			var scaledTime:Number = time * _timeScale;
			for each (var clip:IAnimatable in _clips)
			{
				clip.advanceTime(scaledTime);
			}
			
			for each (var stateClip:IAnimatable in _states)
			{
				stateClip.advanceTime(scaledTime);
			}
			
			for each (var particle:IAnimatable in _particles)
			{
				particle.advanceTime(scaledTime);
			}
			
			for each (var sparticle:IAnimatable in _sparticles)
			{
				sparticle.advanceTime(scaledTime);
			}
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
				updateState(startOver);
			}
		}
		
		public function getElements():Vector.<DisplayObject> 
		{
			return _container.getChildren();
		}
		
		public function get previous():String
		{
			return _previous;
		}
		
		public function get timeScale():Number
		{
			return _timeScale;
		}
		
		public function set timeScale(value:Number):void
		{
			_timeScale = value;
		}
		
		public function get z():Number
		{
			return _z;
		}
		
		public function set z(value:Number):void
		{
			_z = value;
			if (_moveZ)
			{
				_container.y = -z;
			}
		}
		
		public function get moveZ():Boolean
		{
			return _moveZ;
		}
		
		public function set moveZ(value:Boolean):void
		{
			_moveZ = value;
		}
		
		override public function get y():Number
		{
			if (_customY == _customY) return _customY;
			return super.y;
		}
		
		public function get customY():Number
		{
			return _customY;
		}
		
		public function set customY(value:Number):void
		{
			_customY = value;
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function set id(value:String):void
		{
			_id = value;
		}
		
		private function updateState(startOver:Boolean):void
		{
			for each (var clip:StateImageClip in _states)
			{
				clip.setState(_state, startOver);
				clip.addEventListener(Event.COMPLETE, onComplete);
			}
		}
		
		private function onComplete(e:Event):void
		{
			dispatchEventWith(Event.COMPLETE);
		}
	
	}

}