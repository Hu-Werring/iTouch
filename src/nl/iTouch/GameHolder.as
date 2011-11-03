package nl.iTouch
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class GameHolder extends Sprite
	{
		public static const CREATED:String = 'C';
		public static const ONSTAGE:String = 'S';
		public static const GAME_INVISIBLE:String = 'Gi';
		public static const GAME_VISIBLE:String = 'Gv';
		
		
		private var _game:* = null;
		private var _addedToStage:Boolean = false;
		private var _visible:Boolean = false;
		private var _animate:Boolean = false;
		private var _status:String;
		public function GameHolder()
		{
			_status = GameHolder.CREATED;
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		public function get game():*
		{
			return _game;
		}
		
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			_addedToStage = true;
			graphics.beginFill(0xFFFFFF);
			graphics.lineStyle(4,0x00A1E1);
			graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
			graphics.endFill();
			
			this.scaleX = 0.01;
			
			this.scaleY = 0.01;
			this.x = stage.stageWidth/2;
			this.y = stage.stageHeight/2;
			this.visible = false;
			_status = GameHolder.ONSTAGE;
			
			//var tmp:Sprite = new Sprite()
			//tmp.graphics.beginFill(0xFF0000);
			//tmp.graphics.drawCircle(50,50,25);
		//	tmp.graphics.endFill();
			var back:Sprite = new HomeButton();
			back = new iButton(back);
			back.x = 940;
			back.y = 100;
			//back.scaleX = 0.4;
			//back.scaleY= 0.4;
			back.addEventListener(MouseEvent.CLICK,killGame);
			addChild(back);
		}
		private function killGame(e:MouseEvent):void
		{
			hide();
		}
		
		public function addGame(obj:Class):void
		{
			if(!_addedToStage) throw(new Error('First add GameHolder to stage before adding a game!'));
			if(_game!=null){
				this.removeChild(_game);
				_game.stop(true);
			}
			_game = new obj();
			_game.addEventListener('BACK',hide);
			addChildAt(_game,0);
			if(visible){
				_status = GameHolder.GAME_VISIBLE;
			} else {
				_status = GameHolder.GAME_INVISIBLE;
			}
		}
		
		public function show():void
		{
			if(!_visible && !_animate){
				_animate = true;
				this.visible = true;
				_status = GameHolder.GAME_VISIBLE;
				TweenLite.to(this,1,{x:2,y:2,scaleX:1,scaleY:1,onComplete:function():void{_animate = false; _visible = true;}});
			}
		}
		
		public function hide(e:MouseEvent = null):void
		{
			if(_visible && !_animate){
				_animate = true;
				_game.stop(true);
				TweenLite.to(this,1,{x:stage.stageWidth/2,y:stage.stageHeight/2,height:0,width:0,onComplete:function():void{_animate = false; _visible = false;this.visible = false;  _status = GameHolder.GAME_INVISIBLE; dispatchEvent(new Event(GameHolder.GAME_INVISIBLE));}});
			}
		}
		public function get status():String
		{
			return _status;
		}
	}
	
}