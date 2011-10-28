package nl.iTouch.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	public class StartEC extends Sprite
	{
		var lastTouch:int;
		
		public function Click(e:Event):void
		{
			lastTouch = getTimer() 
		}
		
		public function Timer(e:Event):void
		{
			if(getTimer() - lastTouch <180)
			{
				eyeCatcher();
			}
		}
	}
}