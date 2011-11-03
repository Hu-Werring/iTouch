package nl.iTouch.maze
{
	import com.greensock.layout.ScaleMode;
	
	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class TubeTile extends MovieClip
	{
		private var _naam:Class;
		public var tileNr:int;
		//public var hasTubeTile:Boolean = false;	
		public var curTubeTile:MovieClip;
		public var left:String = 'false';
		public var right:String = 'false';
		public var top:String = 'false';
		public var bottom:String = 'false';
		public var powerPoint:String = 'false';
		public var tempLine:Sprite = null;
		public var powerSource:Boolean = false;
		public var overlay:MovieClip = new MovieClip();
		public var background:Sprite = new Sprite();
		
		public var outputTile:int = -1;
		
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
			curTubeTile = new _naam();
			curTubeTile.width = 80;
			curTubeTile.height = 80;
			
			background.graphics.beginFill(0xFFFFFF);
			background.graphics.drawRect(0,0,curTubeTile.width, curTubeTile.height);
			background.graphics.endFill();
			
			addChild(background);
			addChild(curTubeTile);
			
			this.overlay.graphics.lineStyle(5, 0x000000, 1, false, "normal", CapsStyle.NONE);
			
			switch(this.naam)
			{
				case 'maze_bookCaseElectricPoint':
					powerPoint = 'right';
					powerSource = true;
					//hasTubeTile = true;
					break;
				
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
					overlay.graphics.moveTo(this.width / 2, this.height);
					overlay.graphics.curveTo(this.width/2, this.height/2, this.x, this.height/2);
					break;
				}
				
				case 'maze_curveBR':
				{
					bottom = 'right';
					right = 'bottom';
					overlay.graphics.moveTo(this.width / 2, this.height);
					overlay.graphics.curveTo(this.width/2, this.height/2, this.width, this.height/2);
					break;
				}
					
				case 'maze_curveTL':
				{
					top = 'left';
					left = 'top';
					overlay.graphics.moveTo(this.width / 2, this.y);
					overlay.graphics.curveTo(this.width/2, this.height/2, this.x, this.height/2);
					break;
				}
					
				case 'maze_curveTR':
				{
					top = 'right'
					right = 'top';
					overlay.graphics.moveTo(this.width / 2, this.y);
					overlay.graphics.curveTo(this.width/2, this.height/2, this.width, this.height/2);
					break;
				}
					
				case 'maze_vertical':
				{
					top = 'bottom';
					bottom = 'top';
					overlay.graphics.moveTo(this.width / 2, this.height);
					overlay.graphics.lineTo(this.width / 2, this.y);
					break;
				}
					
				case 'maze_horizontal':
				{
					left = 'right';
					right = 'left';
					overlay.graphics.moveTo(this.x, this.height/2);
					overlay.graphics.lineTo(this.width, this.height/2);
					break;
				}
					
				default:
				{
					break;
				}
			}
			
			
			//addChildAt(overlay, this.numChildren);
			//this.curTubeTile.visible = false;

		}
		
		public function stroom(from:String):void
		{
			trace('maakstroom');
			trace(this.powerPoint);
			if(this.powerPoint == 'false' && tempLine == null)
			{
				trace('maakstroom2');
				var fromPoint:Point;
				var toPoint:Point;
				var noStroom:Boolean = false;
				tempLine  = new Sprite();
				trace(this.width, this.height);
				tempLine.x = 0;
				tempLine.y = 0;
			//	tempLine.graphics.beginFill(0xFF0000);
				//tempLine.graphics.drawRect(0,0,this.width, this.height);
				//tempLine.graphics.endFill();
				tempLine.graphics.lineStyle(5, 0x00FF00, 1, false, "normal", CapsStyle.NONE);
				//tempLine.width = this.width;
				//tempLine.height = this.height;
	
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
						powerPoint = 'bottom';
						break
					}
						
					case 'top':
					{
						toPoint = new Point(this.width / 2, 0);
						powerPoint = 'top';
						break;
					}
						
					case 'left':
					{
						toPoint = new Point(0, this.height / 2);
						powerPoint = 'left';
						break;
					}
						
					case 'right':
					{
						toPoint = new Point(this.width, this.height / 2);
						powerPoint = 'right';
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
					this.curTubeTile.visible = false;
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
}