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
			
			
			var glow:GlowFilter = new GlowFilter();
			glow.color=0x00A1E1;
			glow.blurX=20;
			glow.blurY=20;
			glow.strength=2;
			
			_sprite.filters = [bevel,glow];
			
			
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
			
			var glow:GlowFilter = new GlowFilter();
			glow.color=0xE63028;
			glow.blurX=20;
			glow.blurY=20;
			glow.strength=2;
			
			_sprite.filters = [bevel,glow];
			
		}
		private function  mouseRelease(e:MouseEvent):void
		{
			var bevel:BevelFilter = new BevelFilter();
			bevel.angle = 45;
			bevel.quality = BitmapFilterQuality.HIGH;
			
			var glow:GlowFilter = new GlowFilter();
			glow.color=0x00A1E1;
			glow.blurX=20;
			glow.blurY=20;
			glow.strength=2;
			
			_sprite.filters = [bevel,glow];
			

		}
	}
}