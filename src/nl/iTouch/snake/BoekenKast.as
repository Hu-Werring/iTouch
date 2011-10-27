package nl.iTouch.snake
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class BoekenKast extends Sprite
	{
		public var kastParts:Array = new Array();
		
		public function BoekenKast()
		{
			//addEventListener(Event.ADDED_TO_STAGE, init);
			
			for(var i:int=0;i<=23;i++)
			{
				for(var j:int=0; j<4; j++)
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
						else if(j == 3)
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
							var bkR:BoekenKastRecht = new BoekenKastRecht();
							bkR.x = j*15;
							bkR.y = i*15;
							bkR.rotation = 0;
							addChild(bkR);
							kastParts.push(bkR);
						}
					}
					else if (i == 23)
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
						else if(j == 3)
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
							var bkR:BoekenKastRecht = new BoekenKastRecht();
							bkR.x = j*15;
							bkR.y = i*15;
							bkR.rotation = 180;
							addChild(bkR);
							kastParts.push(bkR);
						}
					}
					else
					{
						if(j == 0)
						{
							var bkR:BoekenKastRecht = new BoekenKastRecht();
							bkR.x = j*15;
							bkR.y = i*15;
							bkR.rotation = -90;
							addChild(bkR);
							kastParts.push(bkR);
						}
						else if (j == 3)
						{
							var bkR:BoekenKastRecht = new BoekenKastRecht();
							bkR.x = j*15;
							bkR.y = i*15;
							bkR.rotation = 90;
							addChild(bkR);
							kastParts.push(bkR);
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