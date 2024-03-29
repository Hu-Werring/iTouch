package nl.iTouch.snake
{
	import com.greensock.TweenAlign;
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import flashx.textLayout.formats.TextAlign;
	
	import nl.iTouch.iButton;
	
	public class GameOverScreen extends Sprite
	{
		public var splash:SplashScreen = new SplashScreen();
		public var background:GameOverBackground = new GameOverBackground();
		
		private var elder:Snake;
		
		public var _fadeTimer:Timer;
		
		public function GameOverScreen()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			elder = this.parent as Snake;
			x = 22.5;
			y = 52.5;
			
			background.alpha = 0;
			addChild(background);
			
			splash.x = 457,5;
			splash.y = 457,5;
			splash.scaleX = 0;
			splash.scaleY = 0;
			splash.alpha = 0;
			addChild(splash);
			
			/*_fadeTimer = new Timer(20);
			_fadeTimer.addEventListener(TimerEvent.TIMER, fadeIn);
			_fadeTimer.start();*/
			TweenLite.to(background,0.5,{alpha:0.85,onComplete:function():void{
				
			}})
			TweenLite.to(splash,0.5,{scaleX:1,scaleY:1,alpha:1})
				
			/*var txtFrmtTitle:TextFormat = new TextFormat();
			txtFrmtTitle.align = TextAlign.LEFT;
			txtFrmtTitle.size = 60;
			txtFrmtTitle.font = "_sans";
			
			var title:TextField = new TextField();
			title.x = 457,5;
			title.y = 457,5;
			title.width = 100;
			title.height = 70;
			title.text = "GameOver";
			title.defaultTextFormat = txtFrmtTitle;
			addChild(title);*/
			
		}
		
		public function deleteMe():void
		{
			TweenLite.to(background,0.5,{alpha:0,onComplete: function():void{
				elder.play();
				
				this.visible = false
				}
			});
				
			TweenLite.to(splash,0.5,{scaleX:0, scaleY:0, alpha:0});
		}
	}
}