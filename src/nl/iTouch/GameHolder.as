package nl.iTouch
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class GameHolder extends Sprite
	{
		private var _game:* = null;
		private var _addedToStage:Boolean = false;
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
	}
}