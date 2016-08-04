package game.modules.animations.descriptions
{
	import com.funkypandagame.stardustplayer.SimPlayer;
	import com.funkypandagame.stardustplayer.project.ProjectValueObject;
	import idv.cjcat.stardustextended.emitters.Emitter;
	import idv.cjcat.stardustextended.initializers.Initializer;
	import idv.cjcat.stardustextended.initializers.PositionAnimated;
	import idv.cjcat.stardustextended.zones.Zone;
	import starling.animation.IAnimatable;
	import starling.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class SParticleSystem extends DisplayObjectContainer implements IAnimatable
	{
		private var _simulation:SimPlayer;
		private var _paused:Boolean;
		private var _emitterX:Number;
		private var _emitterY:Number;
		
		public function SParticleSystem()
		{
			_simulation = new SimPlayer();
			_simulation.setRenderTarget(this);
			_emitterX = 0;
			_emitterY = 0;
		}
		
		public function advanceTime(time:Number):void
		{
			if (!_paused)
			{
				_simulation.stepSimulation(time);
			}
		}
		
		public function getProject():ProjectValueObject
		{
			return _simulation.getProject();
		}
		
		public function setProject(sim:ProjectValueObject):void
		{
			_simulation.setProject(sim);
		}
		
		public function pause():void
		{
			_paused = true;
		}
		
		public function stop(clearParticles:Boolean = true):void
		{
			_paused = true;
			if (clearParticles)
			{
				clear();
			}
		}
		
		public function play():void
		{
			_paused = false;
		}
		
		public override function clear(dispose:Boolean = false):void
		{
			getProject().resetSimulation();
		}
		
		public function get emitterX():Number  { return _emitterX; }
		
		public function set emitterX(value:Number):void
		{
			_emitterX = value;
			moveEmmiter();
		}
		
		public function get emitterY():Number  { return _emitterY; }
		
		public function set emitterY(value:Number):void
		{
			_emitterY = value;
			moveEmmiter();
		}
		
		public function move(x:Number, y:Number):void
		{
			_emitterX = x;
			_emitterY = y;
			moveEmmiter();
		}
		
		public function start():void 
		{
			play();
		}
		
		private function moveEmmiter():void
		{
			for each (var emitter:Emitter in getProject().emittersArr)
			{
				for each (var init:Initializer in emitter.initializers)
				{
					if (init is PositionAnimated)
					{
						var initPos:Vector.<Zone> = PositionAnimated(init).zones;
						for each (var zone:Zone in initPos)
						{
							zone.setPosition(_emitterX, _emitterY);
						}
					}
				}
			}
		}
	
	}

}