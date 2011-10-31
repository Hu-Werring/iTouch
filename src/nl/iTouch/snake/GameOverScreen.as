package nl.iTouch.snake
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import nl.iTouch.iButton;
	
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
			
			x = 22.5;
			y = 52.5;
			
			background.alpha = 0;
			addChild(background);
			
			splash.x = 457,5;
			splash.y = 457,5;
			splash.scaleX = 0;
			splash.scaleY = 0;
			addChild(splash);
			
			_fadeTimer = new Timer(20);
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
					_fadeTimer.removeEventListener(TimerEvent.TIMER, fadeIn);
				}
			}
		}
		
		public function fadeOut(te:TimerEvent):void
		{
			trace ("fading","|",background.alpha);
			
			if (background.alpha > 0)
			{
				background.alpha -= 0.05;
			}
			else if (background.alpha <= 0)
			{
				//removeEventListener(TimerEvent.TIMER, fadeOut);
				
				trace ("delete splash");
				
				var elder:Snake = this.parent as Snake;
				trace (elder,this.parent);
				elder.play();
				
				elder.removeChild(this);
			}
			
			if (splash.scaleY > 0)
			{
				splash.scaleX -= 0.05;
				splash.scaleY -= 0.05;
			}
		}
		
		public function deleteMe():void
		{
			_fadeTimer.addEventListener(TimerEvent.TIMER, fadeOut);
			_fadeTimer.start();
		}
	}
}