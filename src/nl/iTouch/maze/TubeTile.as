package nl.iTouch.maze
{
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class TubeTile extends MovieClip
	{
		private var _naam:Class;
		public var tileNr:int;
		public var hasTubeTile:Boolean = false;		
		public var left:String = 'false';
		public var right:String = 'false';
		public var top:String = 'false';
		public var bottom:String = 'false';
		
		public function get naam():String
		{
			var tempReturnNaam:String = _naam.toString();
			var tempReturnNaamChunks:Array = tempReturnNaam.split(' ');
			tempReturnNaamChunks = tempReturnNaamChunks[1].split(']');
			return tempReturnNaamChunks[0];
		}
		
		public function TubeTile(name:Class)
		{
			_naam = name;
			addChild(new _naam());
			this.graphics
			switch(this.naam)
			{
				case 'maze_cross':
				{
					
					left = 'right';
					right = 'left';
					top = 'bottom';
					bottom = 'top';
					break;
				}
					
				case 'maze_curveDouble1':
				{
					left = 'top';
					top = 'left';
					right = 'bottom';
					bottom = 'right';
					break;
				}
					
				case 'maze_curveDouble2':
				{
					left = 'bottom';
					bottom = 'left';
					right = 'top';
					top = 'right';
					break;
				}
					
				case 'maze_curveBL':
				{
					bottom = 'left';
					left = 'bottom';
					break;
				}
				
				case 'maze_curveBR':
				{
					bottom = 'right';
					right = 'bottom';
					break;
				}
					
				case 'maze_curveTL':
				{
					top = 'left';
					left = 'top';
					break;
				}
					
				case 'maze_curveTR':
				{
					top = 'right'
					right = 'top';
					break;
				}
					
				case 'maze_vertical':
				{
					top = 'bottom';
					bottom = 'top';
					break;
				}
					
				case 'maze_horizontal':
				{
					left = 'right';
					right = 'left';
					break;
				}
					
				default:
				{
					break;
				}
			}
		}
		
		public function stroom(from:String):void
		{
			var fromPoint:Point;
			var toPoint:Point;
			var noStroom:Boolean = false;
			var tempLine:Sprite = new Sprite();
			tempLine.scaleX = 4;
			tempLine.scaleY = 4;
			trace(this.width, this.height);
			tempLine.x = this.x;
			tempLine.y = this.y;
			this.graphics.beginFill(0xFFFFFF);
			this.graphics.drawRect(0,0,this.width, this.height);
			this.graphics.endFill();
			tempLine.graphics.lineStyle(7, 0x00FF00);

			switch(from)
			{
				case 'bottom':
				{
					fromPoint = new Point(this.width / 2, this.height);
					break;
				}
				
				case 'top':
				{
					fromPoint = new Point(this.width / 2, 0);
					break;
				}
					
				case 'left':
				{
					fromPoint = new Point(0, this.height / 2);
					break;
				}
					
				case 'right':
				{
					fromPoint = new Point(this.width, this.height / 2);
					break;
				}
					
				default:
					noStroom = true;
					break;
			}
			
			switch(this[from])
			{
				case 'bottom':
				{
					toPoint = new Point(this.width / 2, this.height);
					break
				}
					
				case 'top':
				{
					toPoint = new Point(this.width / 2, 0);
					break;
				}
					
				case 'left':
				{
					toPoint = new Point(0, this.height / 2);
					break;
				}
					
				case 'right':
				{
					toPoint = new Point(this.width, this.height / 2);
					break;
				}
					
				default:
					noStroom = true;
					break
			}
			
			if(noStroom == false)
			{
				tempLine.graphics.moveTo(fromPoint.x, fromPoint.y);
				trace('-------------------');
				trace('vanpunt:'+fromPoint, 'naar punt: '+toPoint);
				trace('lineElm x: '+ tempLine.x, 'lineElm y: '+ tempLine.y, 'lineElm height: '+ tempLine.height, 'lineElm width: '+ tempLine.width);
				trace('x: '+this.x, 'y: '+this.y, 'width: '+this.width, 'height: '+this.height);
				
				if(fromPoint.x == toPoint.x || fromPoint.y == toPoint.y)
				{
					tempLine.graphics.lineTo(toPoint.x, toPoint.y);
				}
				else
				{
					tempLine.graphics.curveTo(this.width/2, this.height/2, toPoint.x, toPoint.y);
				}
				
				addChildAt(tempLine, this.numChildren);
				trace('childAdded');
				//tempLine.width = this.width;
				//tempLine.height= this.height;
			}
			else
			{
				trace('noStroomConnectie');
			}
		}
	}
}