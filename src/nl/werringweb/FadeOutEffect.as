package nl.werringweb
{
	public class FadeOutEffect implements ParticleEffect
	{
		//initiate effect
		public function FadeOutEffect(name:String = 'Gracefull Death')
		{
			trace('Fade Out effect is loaded');
			_settings['name'] = name;
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
				if(particle.age > particle.maxAge/2){
					particle.alpha -= 1/(particle.maxAge/2)
				}
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