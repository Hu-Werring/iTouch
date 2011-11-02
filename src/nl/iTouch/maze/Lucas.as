package nl.iTouch.maze
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.*;
	
	import nl.iTouch.maze.Grid;
	
	public class Lucas extends MovieClip
	{
		public var pathStartTile:int = 139;
		public var pathEndTile:int = 56;
		public var manualPath:Array;
		public var path:Array;
		public var maxSpeed:int = 500;
		public var speed:int;
		public var moveCounter:int = 0;
		public var gTilesObj:Array;
		public var rot:int;
		public var lucasMc:MovieClip;
		// get matrix object from your MovieClip (mc) 
		public var orgWidth:int;
		public var orgHeight:int;
		public var m:Matrix;
		
		public function Lucas(startTile:int, endTile:int, speed:int)
		{
			this.pathStartTile = startTile;
			this.pathEndTile = endTile;
			this.speed = speed;
			
			addEventListener(Event.ADDED_TO_STAGE, initLucas);
		}
		
		public function initLucas(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,initLucas);
			trace('added');
			//Maak lucas en plaats.
			this.lucasMc = new maze_lucasMoving();
			this.lucasMc.x = 0;
			this.lucasMc.y = 0;
			this.x = 160;
			this.y = 720;

			//this.rotation = 0;
			//this.scaleX = 0.5;
			//this.scaleY = 0.5;
			addChild(this.lucasMc);
			this.orgWidth = this.lucasMc.width;
			this.orgHeight = this.lucasMc.height;
			this.m = this.lucasMc.transform.matrix;

			//createPath();
			this.path = createManualPath();
			
			//setInterval(rotateLucas, 10, 1, 'tr');
			setTimeout(this.walkPath, 2000);
		}
		
		private function createPath():void
		{
			//
		}
		
		private function createManualPath():Array
		{
			this.manualPath = new Array(129, 115, 101, 102, 88, 74, 75, 76, 90, 104, 118, 132, 133, 119, 105, 91, 77, 78, 79, 80, 81, 82, 83, 84);
			return this.manualPath;
		}
		
		private function walkPath():void
		{
			if(this.moveCounter < this.path.length)
			{
				var pointX:int = this.gTilesObj[this.path[this.moveCounter]-1].x;
				var pointY:int = this.gTilesObj[this.path[this.moveCounter]-1].y;
				var toPoint:Point = new Point(pointX,pointY);
				this.moveCounter++;
				this.moveLucas(toPoint);
			}
		}
		
		private function moveLucas(to:Point):void
		{
			if(this.x != to.x)
			{
				if(this.x - to.x > 0)
				{
					this.x--;
					if(this.rot != 270)
					{
						this.rotateLucas(270,'tr');
					}
				}
				else
				{
					this.x++;
					if(this.rot != 90)
					{
						this.rotateLucas(90,'tr');
					}
				}
			}

			if(this.y != to.y)
			{
				if(this.y - to.y > 0)
				{
					this.y--;
					if(this.rot != 0)
					{
						this.rotateLucas(0,'tr');
					}
				}
				else
				{
					this.y++;
					//this.rotation = 270;
					if(this.rot != 180)
					{
						this.rotateLucas(180,'tr');
					}
				}
			}
			
			if(this.x == to.x && this.y == to.y)
			{
				this.walkPath();
			}
			else
			{
				setTimeout(moveLucas,10,to);
			}
		}
		
		private function rotateLucas(deg:int, rtPoint:String):void
		{
			switch(rtPoint)
			{
				default:
					//
					break;
				
				case 'lt':
				case 'tl':
					//Left-top, top-left	
					break;
				
				case 'rt':
				case 'tr':
					//Right-top, top-right
					break;
				
				case 'lb':
				case 'bl':
					//Left-bottom, bottom-left
					break;
				
				case 'rb':
				case 'br':
					//Right-bottom, bottom-right
					break;
			}
			
			//var m:Matrix = this.lucasMc.transform.matrix; 

			// set the point around which you want to rotate your MovieClip (relative to the MovieClip position) 
			var point:Point = new Point(this.orgWidth/2, this.orgHeight/2); 
			
			// get the position of the MovieClip related to its origin and the point around which it needs to be rotated 
			point = m.transformPoint(point); 
			// set it 
			m.translate( -point.x, -point.y); 
			
		//	m.rotate(-this.rot * (Math.PI / 180));
			// rotate it of 30° 
			m.rotate((deg - this.rot)* (Math.PI / 180)); 
			
			// and get back to its "normal" position 
			m.translate(point.x, point.y); 
			
			// finally, to set the MovieClip position, use this 
			this.lucasMc.transform.matrix = m; 
			this.rot = deg;
			// or this 
			//this.x = m.tx; 
			//this.y = m.ty; 
			//this.rotation += deg;  
		}
		
		public function setGridTiles(GrTl:Array):void
		{
			this.gTilesObj = GrTl;
		}

	}
}