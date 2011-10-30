package nl.iTouch.maze
{
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class Lucas extends MovieClip
	{
		var pathStartTile:int = 139;
		var pathEndTile:int = 56;
		var manualPathlvl1:Array;
		var path:Array;
		
		public function Lucas()
		{
			addEventListener(Event.ADDED_TO_STAGE,initLucas);
		}
		
		public function initLucas(e:Event):void
		{
			//Maak lucas en plaats.
			var lucasMc:maze_lucas = new maze_lucas();
			lucasMc.x = 0;
			lucasMc.y = 0;
			this.x = 160;
			this.y = 720;
			this.rotation = 90;
			this.scaleX = 0.5;
			this.scaleY = 0.5;
			addChild(lucasMc);
			
			//bedenk het pad voor lucas.
			this.pathStartTile = 139;
			this.pathEndTile = 56;
			//createPath();
			this.path = createManualPath();
			
			addEventListener(Event.ENTER_FRAME, moveLucas);
		}
		
		private function createPath():void
		{
			//
		}
		
		private function createManualPath():Array
		{
			this.manualPathlvl1 = new Array(139, 138);
			return this.manualPathlvl1;
		}
		
		private function moveLucas(e:Event):void
		{
			
		}

	}
}