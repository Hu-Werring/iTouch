package nl.iTouch
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.*;
	
	public class iButton extends Sprite
	{
		private var _sprite:Sprite;
		public function iButton(image:Sprite)
		{
			_sprite = image;
			buttonEffects();
			
			var bevel:BevelFilter = new BevelFilter();
			bevel.angle = 45;
			bevel.quality = BitmapFilterQuality.HIGH;
			_sprite.filters = [bevel];
			addChild(_sprite);
		}
		
		private function buttonEffects():void
		{
			_sprite.addEventListener(MouseEvent.MOUSE_DOWN,mousePress);
			_sprite.addEventListener(MouseEvent.MOUSE_UP,mouseRelease);
		}
		
		
		private function  mousePress(e:MouseEvent):void
		{
			var bevel:BevelFilter = new BevelFilter();
			bevel.angle = 225;
			bevel.quality = BitmapFilterQuality.HIGH;
			_sprite.filters = [bevel];
		}
		private function  mouseRelease(e:MouseEvent):void
		{
			var bevel:BevelFilter = new BevelFilter();
			bevel.angle = 45;
			bevel.quality = BitmapFilterQuality.HIGH;
			_sprite.filters = [bevel];

		}
	}
}