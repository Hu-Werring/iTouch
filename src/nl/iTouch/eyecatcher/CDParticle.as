package nl.iTouch.eyecatcher
{
	import flash.display.Sprite;
	
	import nl.werringweb.BaseParticle;
	
	public class CDParticle extends BaseParticle
	{
		public function CDParticle(sprite:Sprite=null)
		{
			super(sprite);
		}
		
		override protected function drawMe():void
		{
			var lucas:Sprite = new CdImage();
			lucas.scaleX = 0.4;
			lucas.scaleY = 0.4;
			addChild(lucas)
		}
	}
}