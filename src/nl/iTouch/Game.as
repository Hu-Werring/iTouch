package nl.iTouch
{
	public interface Game
	{
		
		public function play():void;
		public function stop(force:Boolean = false):void;
		
		public function credits():void;
		public function highscore():void;
 
	}
}