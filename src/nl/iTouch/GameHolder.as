package nl.iTouch
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class GameHolder extends Sprite
	{
		private var _game:* = null;
		private var _addedToStage:Boolean = false;
		private var _visible:Boolean = false;
		private var _animate:Boolean = false;
		public function GameHolder()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			_addedToStage = true;
			graphics.beginFill(0xFFFFFF);
			graphics.lineStyle(4,0x00A1E1);
			graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
			graphics.endFill();
			
			this.width = 0;
			
			this.height = 0;
			this.x = stage.stageWidth/2;
			this.y = stage.stageHeight/2;
			this.visible = false;
		}
		
		public function addGame(obj:Class):void
		{
			if(!_addedToStage) throw(new Error('First add GameHolder to stage before adding a game!'));
			if(_game!=null){
				this.removeChild(_game);
				_game.stop(true);
			}
			_game = new obj();
			addChild(_game);
		}
		
		public function show():void
		{
			if(!_visible && !_animate){
				_animate = true;
				this.visible = true;
				TweenLite.to(this,1,{x:2,y:2,height:stage.stageHeight,width:stage.stageWidth,onComplete:function():void{_animate = false; _visible = true;}});
			}
		}
		
		public function hide():void
		{
			if(_visible && !_animate){
				_animate = true;
				TweenLite.to(this,1,{x:stage.stageWidth/2,y:stage.stageHeight/2,height:0,width:0,onComplete:function():void{_animate = false; _visible = false;this.visible = false;}});
			}
		}
	}
}