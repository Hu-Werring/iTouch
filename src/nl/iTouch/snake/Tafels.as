package nl.iTouch.snake
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Tafels extends Sprite
	{
		//private const _lenght:uint = 5;
		//private const _height:uint = 9;
		
		public var tafelParts:Array = new Array();
		
		private var _switchRotation:Boolean;
		
		public function Tafels(s:Boolean = false)
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			
			_switchRotation = s;
		}
		
		public function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			switch (_switchRotation)
			{
				case true:
					drawTafelHorizontaal();
					break;
				
				case false:
					drawTafelVerticaal();
					break;
			}
		}
		
		public function drawTafelHorizontaal():void
		{
			for (var i:uint = 0; j < 5;j++)
			{
				for(var j:int = 0; i < 9; i++)
				{
					/*if (i == 0)
					{
						if(j == 0)
						{
							
						}
						else if(j == 8)
						{
							
						}
						else
						{
							
						}
					}
					else if (i == 4)
					{
						
					}
					else
					{*/
						var t:TafelFill = new TafelFill();;
						t.x = j * 15;
						t.y = i * 15;
						addChild(t);
						tafelParts.push(t);
					//}
				}
			}
		}
		
		public function drawTafelVerticaal():void
		{
			for (var j:uint = 0; j < 9;j++)
			{
				for(var i:int = 0; i < 5; i++)
				{
					var t:TafelFill = new TafelFill();;
					t.x = i * 15;
					t.y = j * 15;
					addChild(t);
					tafelParts.push(t);
				}
			}
		}
	}
}