package nl.iTouch
{
	public interface Game
	{
		
		function play():void;
		function stop(force:Boolean = false):void;
		
		function howTo():void;
		function highscore():void;
 
	}
}