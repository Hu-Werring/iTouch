package nl.iTouch.eyecatcher
{	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Matrix;
	import flash.utils.*;
	
	import nl.iTouch.*;
//0x0490C5

	public class Eyecatcher extends Sprite {

		public var streep:Shape = new Shape;
		public var streep2:Shape = new Shape;
		public var bord:Sprite = new BordImage();
		public var tel:Number = 0;
		public var bordje:Boolean = false;
		public var ps:ParticleSystem = new ParticleSystem();	

		public function Eyecatcher() {			
			addEventListener(Event.ADDED_TO_STAGE,init);
		}		

		private function init(e:Event):void
		{
					
			var backgroundGradient:Sprite = new Sprite();
			var luuk:Sprite = new Lucas();
			var gat:Sprite = new GatImage();
			var timer:Timer = new Timer(20);
			var timer2:Timer = new Timer(200);

			removeEventListener(Event.ADDED_TO_STAGE,init);			
			
			bord.y = stage.stageHeight / 2 - 500;
			bord.x = stage.stageWidth / 2 - 265;
			gat.x = stage.stageWidth / 2 - 140;
			gat.y = stage.stageHeight / 2 - 230;
			
			
			
			addChild(backgroundGradient);			
			addChild(luuk);		
			addChildAt(gat, 2);			
			new iButton(bord);	
			addChildAt(bord, 3);
			
			ps.alpha = 0.7;
			addChildAt(ps, 1);
			
			streep.graphics.beginFill(0xFFFFFF); 
			streep.graphics.drawRect(0, 0, 20,20);
			streep.graphics.endFill();
			streep2.graphics.beginFill(0xFFFFFF); 
			streep2.graphics.drawRect(0, 0, 20,20);
			streep2.graphics.endFill();
			streep.x = 580;
			streep.y = 375;
			streep2.x = 670;
			streep2.y = 375;
			streep.visible=false;			
			streep2.visible=false;

			addChildAt(streep , 5);
			addChildAt(streep2 , 6);
			addEventListener(MouseEvent.CLICK, ganaar);	
		
			var colors:Array = [0xFF3334, 0x0490C5];
			var alphas:Array = [1, 1];
			var ratios:Array = [0, 0xFF];
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(stage.stageWidth, stage.stageHeight, (3 * Math.PI / 2), 0, 10);
			var focalPoint:Number = 0.5;
			
			with(backgroundGradient.graphics){
				clear();
				beginGradientFill(GradientType.RADIAL, colors, alphas, ratios, matrix, SpreadMethod.PAD, InterpolationMethod.RGB, focalPoint);
				drawRect(0, 0, stage.stageWidth, stage.stageHeight);
				endFill();
			}				
			
			timer2.addEventListener(TimerEvent.TIMER, knipperend);
			timer.addEventListener(TimerEvent.TIMER, beweegbord);
			timer.start();
			timer2.start();

		}			
		
		public function ganaar(e:Event):void{
			dispatchEvent(new Event('CLICKED_EYECATCHER'));
		}	
		
		public function knipperend(e:Event):void{
			
			tel ++;						

			if(tel == 16){
				streep.visible=true;
				streep2.visible=true;
			}
			else if(tel > 16){				
				streep.visible=false;
				streep2.visible=false;				
				tel = 0;
			}
					
		}	
		
		public function beweegbord(e:Event):void{
			
						
			if(bordje == false){
				bord.x -=  2;	
				bord.rotation += 0.14
				if(bord.x <= 350)
				{
					bordje = true;						
				}
			}				
			else if(bordje == true){
				bord.x +=  2;			
				bord.rotation -= 0.14;
				if(bord.x >= 400)
				{
					bordje = false;			
				}				
			}
		}
		
		public function hide():void
		{
			this.visible = false;
			ps.pause();
		}
		public function show():void
		{
			this.visible = true;
			ps.resume();
		}
	}
}