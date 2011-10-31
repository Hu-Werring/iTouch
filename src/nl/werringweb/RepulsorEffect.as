package nl.werringweb
{
	import flashx.textLayout.elements.InlineGraphicElement;

	public class RepulsorEffect implements ParticleEffect
	{
		
		//are we active?
		private var _active:Boolean = true;
		
		//store settings for this effect
		private var _settings:Array = new Array();
		
		
		public function RepulsorEffect(posX:int,posY:int,forceY:int = 10,forceX:int = 10,name:String = "Repulsor")
		{
			trace(name + ' effect is loaded at:',posX,posY);
			_settings['xG'] = forceX;
			_settings['yG'] = forceY;
			_settings['xPos'] = posX;
			_settings['yPos'] = posY;
			
			_settings['name'] = name;
		}
		
		public function effect(p:Particle):void
		{	
			if(_active){
				var particle:BaseParticle = p as BaseParticle;
				var X:Number = particle.x;
				var Y:Number = particle.y;
				var diffY:Number = Math.abs(Y - _settings['yPos']);
				var diffX:Number = Math.abs(X - _settings['xPos']);
				var factor:Number = 1/(diffX+diffY)
				
				
				if(X >= _settings['xPos'] && Y >= _settings['yPos']){
					particle.speedX += _settings['xG']/100 * factor * diffX;
					particle.speedY += _settings['yG']/100 * factor * diffY;
					
				} else if(X >= _settings['xPos']){
					particle.speedX += _settings['xG']/100 * factor * diffX;;
					particle.speedY -= _settings['yG']/100 * factor * diffY;;
				} else if(Y >= _settings['yPos'])
				{
					particle.speedX -= _settings['xG']/100 * factor * diffX;;
					particle.speedY += _settings['yG']/100 * factor * diffY;;
				} else {
					
					particle.speedX -= _settings['xG']/100 * factor * diffX;;
					particle.speedY -= _settings['yG']/100 * factor * diffY;;
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