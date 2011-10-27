package nl.iTouch.eyecatcher
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Matrix; [SWF(backgroundColor="0x0490C5")] //0x0490C5
	import nl.iTouch.*;
	
	public class Eyecatcher extends Sprite {
		
		public function Eyecatcher() {
			
			addEventListener(Event.ADDED_TO_STAGE,init); 
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			
			var backgroundGradient:Sprite = new Sprite();
			addChild(backgroundGradient);
			var luuk:Sprite = new Lucas();
			addChild(luuk);		
			
			var bord:Sprite = new BordImage();
			var gat:Sprite = new GatImage();
			bord.y = stage.stageHeight / 2 - 500;
			bord.x = stage.stageWidth / 2 - 265;
			gat.x = stage.stageWidth / 2 - 140;
			gat.y = stage.stageHeight / 2 - 230;
			addChildAt(gat, 1);			
			new iButton(bord);	
			addChildAt(bord, 2);
			
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			//stage.align = StageAlign.TOP_LEFT;
			//stage.addEventListener(Event.ADDED, onStageResize);
			//stage.addEventListener(Event.RESIZE, onStageResize);
			
			//function onStageResize(e:Event):void{
			var colors:Array = [0xFF3334, 0x0490C5];
			var alphas:Array = [1, 1];
			var ratios:Array = [0, 0xFF];
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(stage.stageWidth, stage.stageHeight, (3 * Math.PI / 2), 0, 10);
			var focalPoint:Number = .5;
			
			with(backgroundGradient.graphics){
				clear();
				beginGradientFill(GradientType.RADIAL, colors, alphas, ratios, matrix, SpreadMethod.PAD, InterpolationMethod.RGB, focalPoint);
				drawRect(0, 0, stage.stageWidth, stage.stageHeight);
				endFill();
			}
		}
		
	}
}
