package nl.werringweb
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import nl.iTouch.eyecatcher.ParticleSystem;
	
	public class Emitor extends Sprite
	{
		
		/**
		 * Spawn types
		 * RANDOM creates particles over the entire stage
		 * MOUSE spawns them from your mouse location
		 * FIXED spawns from a single point
		 */
		public static const RANDOM:String = "random";
		public static const MOUSE:String = "mouse";
		public static const FIXED:String = "fixed";
		
		/**
		 * Spawn Event
		 * SPAWNED triggers when particle is created
		 */
		public static const SPAWNED:String = "spawned";
		
		//particle
		private var _particle:* = BaseParticle;
		private var _particleParam:Sprite;
		
		
		//count number of particles
		private var _counter:uint;
		
		// spawn timer
		private var _timer:Timer;
		
		//position array
		private var _pos:Array = new Array();
		
		//spawn type
		private var _placement:String;
		
		//Particle color
		//Can be overruled by particle itself
		private var _color:uint = 0xFF0000;
		
		//Sets some startup settings
		//listen when it is added to stage
		public function Emitor(placement:String = Emitor.RANDOM,spawnRate:Number=20)
		{
			this.addEventListener(Event.ADDED_TO_STAGE,init);
			_placement = placement;
			_timer = new Timer(1000/spawnRate);
			
		}
		
		//change particle
		public function set setParticle(particle:*):void
		{
			_particle = particle;
		}
		
		//set the color for spawned particles
		public function set color(color:uint):void{
			_color = color;
		}
		//get the color
		public function get color():uint
		{
			return _color;
		}
		//get the counter for some math
		public function get counter():uint
		{
			return _counter;
		}
		
		//Set spawn location
		public function setPlacement(posX:Number,posY:Number,posZ:Number = 0):void
		{
			_pos['x'] = posX;
			_pos['y'] = posY;
			_pos['z'] = posZ;
		}
		
		//get the loaction for when we want to do math with it
		public function get location():Array
		{
			return _pos;
		}
		
		public function pause():void
		{
			//_pause = true;
			_timer.stop();
		}
		public function resume():void
		{
			_timer.start();
		}
		
		
		//start spawning particles when Emitor is added to stage
		//Load effects for particles
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			_timer.addEventListener(TimerEvent.TIMER,spawner);
			_timer.start();
			trace("placement is mouse:");
			if(_placement == Emitor.MOUSE){
				trace('YES');
				ParticleSystem.addMouseRequest(this);
				_pos['x'] = 0;
				_pos['y'] = 0;
				_pos['z'] = 0;
			}
			
			trace('Add effects:');
			effects();
		}
		
		//adding Effects to the particle
		protected function effects():void
		{
			
			var airResistanceEffect:AirResistanceEffect = new AirResistanceEffect(1);
			BaseParticle.addEffect(airResistanceEffect);
			var gravityEffect:GravityEffect = new GravityEffect(stage.stageWidth,stage.stageHeight);
			BaseParticle.addEffect(gravityEffect);
			var fadeOutEffect:FadeOutEffect = new FadeOutEffect();
			BaseParticle.addEffect(fadeOutEffect);

		}
		
		//spawn particles
		private function spawner(te:TimerEvent):void
		{
			var bp:BaseParticle;
			if(_particleParam == null) bp= new _particle();
			else bp = new _particle(_particleParam);
			bp.maxAge = 60;
			switch(_placement){
				case Emitor.MOUSE:
				case Emitor.FIXED:
					if(_pos['x'] != undefined && _pos['y'] != undefined){
						bp.x = _pos['x'];
						bp.y = _pos['y'];
						bp.z = !_pos['z'] ? 0 : (_pos['z']);
					} else {
						var e:Error = new Error('No spawn location detected');
						e.name = 'Fatal error';
						throw(e);
					}
					
					break;
				default:
					bp.x = Math.random()*stage.stageWidth;
					bp.y = Math.random()*stage.stageHeight;
					break;
			}
			bp.color = _color;
			addChild(bp);
			_counter++;
			dispatchEvent(new Event(Emitor.SPAWNED));
			
		}
		public function set particleParameter(param:Sprite):void
		{
			_particleParam = param;
		}
	}
}