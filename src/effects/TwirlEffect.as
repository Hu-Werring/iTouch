package effects 
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.easing.Expo;
	import com.greensock.easing.Sine;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.display.Shader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.ShaderFilter;
	
	/**
	 * ...
	 * @author Zach
	 */
	public class TwirlEffect extends Sprite
	{
		// Grab the pixelBender Filters
		[Embed(source='twirl_scale.pbj', mimeType='application/octet-stream')]
		private var twirl:Class;
		[Embed(source='ripple.pbj', mimeType='application/octet-stream')]
		private var ripple:Class;
		
		private var shader:Shader;
		private var rippleshader:Shader;
		private var filter:ShaderFilter;
		private var ripplefilter:ShaderFilter;
		private var photo:Bitmap;
		private var photo2:Bitmap;
		public var amount:Number
		public var scale:Number
		
		public function TwirlEffect() 
		{
			trace("TwirlEffect");
			photo = new Bitmap(null, "auto", true);
			photo2 = new Bitmap(null, "auto", true);
		}
		private function reset(filterClass:Class):void 
		{
			shader = new Shader(new filterClass());
			filter = new ShaderFilter(shader);
			
			rippleshader = new Shader(new ripple());
			ripplefilter = new ShaderFilter(rippleshader);
			
			rippleshader.data.size.value = [0.8];
			rippleshader.data.amount.value = [0.9];
			rippleshader.data.phase.value = [0];
			rippleshader.data.radius.value = [300];
			rippleshader.data.center.value = [photo.width/2, photo.height/2];
			
		}
		public function effectIn(source:Bitmap):void {
			amount = 5;
			scale = 1;
			var data:BitmapData = new BitmapData(source.width, source.height, true, 0x00000000);
			data.draw(source);
			photo.bitmapData = data;
			addChild(photo);
			photo2.bitmapData = data;
			photo2.alpha = 0;
			addChild(photo2);
			reset(twirl);
			update();
		}
		
		private function update():void {
			if (filter == null) return;
			// TWIRL
			// Some other parameters you might want to play with are commented out here.
			//shader.data.size.value = [photo.width, photo.height];
			//shader.data.outputSize.value = [585, 341];
			//shader.data.latitude.value = [s * 90];
			//shader.data.longitude.value = [c * 360];
			//shader.data.bulge.value = [1];
			shader.data.center.value = [photo.width/2, photo.height/2];
			shader.data.radius.value = [75+((1/amount)*180)];
			shader.data.twirlAngle.value = [amount * 180];
			
			// RIPPLE
			// Some other parameters you might want to play with are commented out here.
			//rippleshader.data.size.value = [amount-1];
			rippleshader.data.amount.value = [1-scale];
			rippleshader.data.phase.value[0] = 0.4;
			
			// Apply filter to the photo
			photo.filters = [filter, ripplefilter];
		}
		
		public function disable():void
		{
			effectOut();
		}
		private function effectOut():void {
			TweenLite.to(photo,1,{alpha:0});
			TweenLite.to(photo2,1,{alpha:1});
		}
		
		private function updateOut(e:Event = null):void {
		
		}
		
		
	}
	
}