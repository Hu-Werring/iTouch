package nl.iTouch
{
	public interface Game
	{
		
		function play():void;
		function stop(force:Boolean = false):void;
		
		function credits():void;
		function highscore():void;
 
	}
}