package nl.iTouch.eyecatcher
{
	import flash.display.Sprite;
	
	import nl.werringweb.BaseParticle;
	
	public class Particle_b extends BaseParticle
	{
		public function Particle_b(sprite:Sprite=null)
		{
			super(sprite);
		}
		
		override protected function drawMe():void
		{
			var lucas:Sprite = new Particle2();
			lucas.scaleX = 0.4;
			lucas.scaleY = 0.4;
			addChild(lucas)
		}
	}
}