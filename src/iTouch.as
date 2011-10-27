package
{
	import flash.display.Sprite;
	
	import nl.iTouch.snake.Snake;
	
	[SWF(frameRate='24',backgroundColor='0xffffff', width="1280", height="1024")]
	public class iTouch extends Sprite
	{
		public function iTouch()
		{
			var game:Snake = new Snake();
			
			addChild(game);
		}
	}
}