package nl.iTouch.snake
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class BoekenKast extends Sprite
	{
		private const partsX:uint = 6
		private const partsY:uint = 23
		
		public var kastParts:Array = new Array();
		
		public function BoekenKast()
		{
			//addEventListener(Event.ADDED_TO_STAGE, init);
			
			for(var i:int=0;i <= partsY;i++)
			{
				for(var j:int=0; j < partsX; j++)
				{
					if(i == 0)
					{
						if(j == 0)
						{
							var bkH1:BoekenKastHoek = new BoekenKastHoek();
							bkH1.x = j*15;
							bkH1.y = i*15;
							bkH1.rotation = 0;
							addChild(bkH1);
							kastParts.push(bkH1);
						}
						else if(j == partsX-1)
						{
							var bkH2:BoekenKastHoek = new BoekenKastHoek();
							bkH2.x = j*15;
							bkH2.y = i*15;
							bkH2.rotation = 90;
							addChild(bkH2);
							kastParts.push(bkH2);
						}
						else
						{
							var bkR1:BoekenKastRecht = new BoekenKastRecht();
							bkR1.x = j*15;
							bkR1.y = i*15;
							bkR1.rotation = 0;
							addChild(bkR1);
							kastParts.push(bkR1);
						}
					}
					else if (i == partsY)
					{
						if(j == 0)
						{
							var bkH3:BoekenKastHoek = new BoekenKastHoek();
							bkH3.x = j*15;
							bkH3.y = i*15;
							bkH3.rotation = -90;
							addChild(bkH3);
							kastParts.push(bkH3);
						}
						else if(j == partsX-1)
						{
							var bkH4:BoekenKastHoek = new BoekenKastHoek();
							bkH4.x = j*15;
							bkH4.y = i*15;
							bkH4.rotation = 180;
							addChild(bkH4);
							kastParts.push(bkH4);
						}
						else
						{
							var bkR2:BoekenKastRecht = new BoekenKastRecht();
							bkR2.x = j*15;
							bkR2.y = i*15;
							bkR2.rotation = 180;
							addChild(bkR2);
							kastParts.push(bkR2);
						}
					}
					else
					{
						if(j == 0)
						{
							var bkR3:BoekenKastRecht = new BoekenKastRecht();
							bkR3.x = j*15;
							bkR3.y = i*15;
							bkR3.rotation = -90;
							addChild(bkR3);
							kastParts.push(bkR3);
						}
						else if (j == partsX-1)
						{
							var bkR4:BoekenKastRecht = new BoekenKastRecht();
							bkR4.x = j*15;
							bkR4.y = i*15;
							bkR4.rotation = 90;
							addChild(bkR4);
							kastParts.push(bkR4);
						}
						else
						{
							var bkF:BoekenKastFill = new BoekenKastFill();
							bkF.x = j*15;
							bkF.y = i*15;
							addChild(bkF);
							kastParts.push(bkF);
						}
					}
				}
			}
		}
		
		public function init(ev:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			

		}
	}
}