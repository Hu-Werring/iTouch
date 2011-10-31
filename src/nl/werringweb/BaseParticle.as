package nl.werringweb
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class BaseParticle extends Sprite implements Particle
	{
		
		//age variables
		protected var _age:uint;
		protected var _maxAge:uint;
		
		
		//directional variables
		protected var _speedX:Number;
		protected var _speedY:Number;
		protected var _speedZ:Number;
		
		
		//particle color
		protected var _color:uint;
		
		//image
		protected var _sprite:Sprite
		
		//maxAge, color, speedX|Y|Z are allowed to be changed, so created a setter 
		//This way we would be able to create a particle object (by extending this class) that has a fixed maxAge, color, speedX|Y|Z
		public function set maxAge(age:uint):void
		{
			_maxAge = age;
		}
		public function set color(color:uint):void {
			_color = color;
		}
		
		public function set speedX(speed:Number):void
		{
			_speedX = speed;
		}
		public function set speedY(speed:Number):void
		{
			_speedY = speed;
		}
		public function set speedZ(speed:Number):void
		{
			_speedZ = speed;
		}
		
		
		//get speedX|Y|Z for when we want to do some advanced math with them.
		public function get speedX():Number
		{
			return _speedX;
		}
		public function get speedY():Number
		{
			return _speedY;
		}
		public function get speedZ():Number
		{
			return _speedZ;
		}
		//we can always request the particles maximum age
		public function get maxAge():uint
		{
			return _maxAge;
		}
		
		//getting the particles current age is possible, but setting it CANT
		public function get age():uint
		{
			return _age;
		}
		
		
		
		//effect list for this type of particle, useing a static list so that every particle uses this 
		protected static var _effectList:Array = new Array();
		
		
		//add effect to this kind of particle, each event can only be added once, unless it has an unique name
		static public function addEffect(effect:ParticleEffect):void
		{
			var addIt:Boolean = true;
			for(var index:String in _effectList)
			{
				if(_effectList[index].name == effect.name){
					addIt = false;
				}
			}
			if(addIt){
				_effectList.push(effect); 
			}
		}
		
		
		//debug function, will be deleted in later stadium
		static public function countEffect():int
		{
			return _effectList.length;
		}
		
		//Constructor, sets default settings like maxAge, speedX,Y,Z and adds a Listener for when its added to stage
		public function BaseParticle(sprite:Sprite = null)
		{
			
			_maxAge = 120;
			speedX = Math.random() * 10 - 5;
			speedY = Math.random() * 10 - 5;
			speedZ = 0;//Math.random() * 20 - 5;
			this.addEventListener(Event.ADDED_TO_STAGE,init);
			_sprite = sprite;
		}
		
		//when the particle is added to stage, remove eventListener, draw the particle and starts the enter frame event for the animation
		protected function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			drawMe();
			
			this.addEventListener(Event.ENTER_FRAME,animateMe);
		}
		
		//Animate the particle and executes all effects
		//when maxAge is reached, kill it
		protected function animateMe(e:Event):void
		{
			_age++;
			
			var list:Array = BaseParticle._effectList;
			
			for (var i:uint =0;i<list.length;i++){
				list[i].effect(this);
				
			}
			
			
			
			x+=speedX;
			y+=speedY;
			z+=speedZ;
			
			if(_age>=_maxAge){
				deleteMe();
			}
		}
		
		//draw the particle
		protected function drawMe():void
		{
			this.graphics.beginFill(_color);
			this.graphics.drawCircle(-2,-2,4);
			this.graphics.endFill();
		}
		
		
		//delete particle from memory by removing it from the parent and deleting the EnterFrame Event listener
		public function deleteMe():void
		{
			this.removeEventListener(Event.ENTER_FRAME,animateMe);
			this.parent.removeChild(this);
		}
	}
}