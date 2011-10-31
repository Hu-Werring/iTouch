package nl.werringweb
{
	public class AirResistanceEffect implements ParticleEffect
	{
		//initiate effect
		public function AirResistanceEffect(resistance:int = 2,name:String = 'Air')
		{
			trace('AirResistance effect is loaded');
			_settings['resist'] = resistance;
			_settings['name'] = 'Air';
		}
		
		//are we active?
		private var _active:Boolean = true;
		
		//store settings for this effect
		private var _settings:Array = new Array();
		//execute the effect
		public function effect(p:Particle):void
		{
			if(_active){
				var particle:BaseParticle = p as BaseParticle;
				particle.speedX *= 1-(_settings['resist']/100);
				particle.speedY *= 1-(_settings['resist']/100);
			}
		}
		
		
		//return effect name
		public function get name():String
		{
			return _settings['name'];
		}
		
		//pause effect
		public function stop():void
		{
			_active = false;
		}
		
		//resume effect
		public function resume():void
		{
			_active=true;
		}
		
		//change setting
		public function config(setting:String, value:*):Boolean
		{
			var succes:Boolean = false;
			if(_settings[setting]!=undefined){
				succes = true;
				_settings[setting] = value;
			}
			return succes;
		}
		
		//changeable settings
		public function configList():Array
		{
			return _settings;
		}
		
		//return active state
		public function get active():Boolean
		{
			return _active;
		}
	}
}