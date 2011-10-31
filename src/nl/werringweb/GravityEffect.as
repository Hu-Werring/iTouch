package nl.werringweb
{
	public class GravityEffect implements ParticleEffect
	{
		//are we active?
		private var _active:Boolean = true;
		
		//store settings for this effect
		private var _settings:Array = new Array();
		
		//initiate effect
		public function GravityEffect(stageWidth:Number,stageHeight:Number,forceY:int = 10,forceX:int = 0,name:String = 'Gravity')
		{
			trace('Gravity effect is loaded');
			
			_settings['xG'] = forceX;
			_settings['yG'] = forceY;
			
			_settings['name'] = name;
		}
		
		//run effect
		public function effect(p:Particle):void
		{
			
			if(_active){
				var particle:BaseParticle = p as BaseParticle;
				particle.speedX += _settings['xG']/100;
				particle.speedY += _settings['yG']/100;
				
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