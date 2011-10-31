package nl.iTouch.snake
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class GameOverScreen extends Sprite
	{
		public var splash:SplashScreen = new SplashScreen();
		public var background:GameOverBackground = new GameOverBackground();
		
		public var _fadeTimer:Timer;
		
		public function GameOverScreen()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			background.alpha = 0;
			addChild(background);
			
			splash.x = 457,5;
			splash.y = 457,5;
			splash.scaleX = 0;
			splash.scaleY = 0;
			splash.addEventListener(MouseEvent.CLICK, onTouch);
			addChild(splash);
			
			trace("werkt!! w00t");
			
			_fadeTimer = new Timer(40);
			_fadeTimer.addEventListener(TimerEvent.TIMER, fadeIn);
			_fadeTimer.start();
		}
		
		public function fadeIn(te:TimerEvent):void
		{
			if(background.alpha < 0.85)
			{
				background.alpha += 0.025;
			}
			else if (background.alpha >= 0.85)
			{
				if(splash.scaleX < 1 && splash.scaleY < 1)
				{
					splash.scaleX += 0.05;
					splash.scaleY += 0.05;
				}
				else
				{
					_fadeTimer.stop();
				}
			}
		}
		
		public function fadeOut():void
		{
			
		}
		
		public function onTouch(me:MouseEvent):void
		{
			
		}
	}
}