package nl.werringweb
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	

	public class SpecialParticle extends BaseParticle
	{
		private var _sprite:Sprite
		//execute constuctor from BaseParticle
		public function SpecialParticle(sprite:Sprite)
		{
			super();
			_sprite = sprite;
		}
		//other images, we take our color
		//and use is as a counter to check what image we should use
		override protected function drawMe():void
		{
			addChild(_sprite);

		}

	}
}