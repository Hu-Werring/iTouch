package nl.iTouch
{
	import flash.display.Sprite;
	import flash.events.*;	 
	
	public class Credits extends Sprite implements Game
	{
		public function Credits()
		{
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			var cred:CreditsImage = new CreditsImage();
			addChild(cred);			
		}
		
		public function play():void
		{
		}
		
		public function stop(force:Boolean=false):void
		{
		}
		
		public function credits():void
		{
		}
		
		public function highscore():void
		{
		}
	}
}