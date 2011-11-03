package nl.iTouch.eyecatcher
{
	import flash.display.Sprite;
	
	import nl.werringweb.BaseParticle;
	
	public class Particle_a extends BaseParticle
	{
		public function Particle_a(sprite:Sprite=null)
		{
			super(sprite);
		}
		override protected function drawMe():void
		{
			var lucas:Sprite = new Particle1();
			lucas.scaleX = 0.4;
			lucas.scaleY = 0.4;
			addChild(lucas)
		}
	}
}