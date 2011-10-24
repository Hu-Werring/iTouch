package
{
	import flash.display.Sprite;
	
	import nl.iTouch.iButton;
	
	public class iTouchGameArcade extends Sprite
	{
		public function iTouchGameArcade()
		{
			var test:Sprite = new Sprite();
			
			test.graphics.beginFill(0xFF44FF);
			test.graphics.drawCircle(0,0,15);	
			test.graphics.endFill();
			
			var testButton:iButton = new iButton(test);
			
			testButton.x = (stage.stageWidth-testButton.width)/2;
			testButton.y = (stage.stageHeight-testButton.height)/2;
			addChild(testButton);
			
		}
	}
}