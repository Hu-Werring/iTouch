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
			bevel.strength = 0.5;
			
			var glow:GlowFilter = new GlowFilter();
			glow.color=0x02AEAE;
			glow.blurX=10;
			glow.blurY=10;
			glow.strength=1.5;
			
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
			bevel.strength = 0.5;
			
			var glow:GlowFilter = new GlowFilter();
			glow.color=0xE63028;
			glow.blurX=10;
			glow.blurY=10;
			glow.strength=1.5;
			
			_sprite.filters = [bevel,glow];
			
		}
		private function  mouseRelease(e:MouseEvent):void
		{
			var bevel:BevelFilter = new BevelFilter();
			bevel.angle = 45;
			bevel.quality = BitmapFilterQuality.HIGH;
			bevel.strength = 0.5;
			
			var glow:GlowFilter = new GlowFilter();
			glow.color=0x02AEAE;
			glow.blurX=10;
			glow.blurY=10;
			glow.strength=1.5;
			
			_sprite.filters = [bevel,glow];
			

		}
	}
}