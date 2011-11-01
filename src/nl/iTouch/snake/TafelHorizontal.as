package nl.iTouch.snake
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class TafelHorizontal extends Sprite
	{
		
		private const _lenght:uint = 9;
		private const _height:uint = 5;
			
		public var tafelParts:Array = new Array();
			
		public function TafelHorizontal()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
			
		public function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
				
			drawTafel();
		}
			
		public function drawTafel():void
		{
			for (var j:uint = 0; j < 5;j++)
			{
				for(var i:int = 0; i < 9; i++)
				{
					if(j ==0)
					{
						if(i == 0)
						{
							var tH1:TafelHoek = new TafelHoek();
							tH1.x = i * 15;
							tH1.y = j * 15;
							tH1.rotation = 0;
							addChild(tH1);
							tafelParts.push(tH1);
						}
						else if(i == 8)
						{
							var tH2:TafelHoek = new TafelHoek();
							tH2.x = i * 15;
							tH2.y = j * 15;
							tH2.rotation = 90;
							addChild(tH2);
							tafelParts.push(tH2);
						}
						else
						{
							var tR1:TafelRecht = new TafelRecht();
							tR1.x = i * 15;
							tR1.y = j * 15;
							tR1.rotation = 0;
							addChild(tR1);
							tafelParts.push(tR1);
						}
					}
					else if(j == 4)
					{
						if(i == 0)
						{
							var tH3:TafelHoek = new TafelHoek();
							tH3.x = i * 15;
							tH3.y = j * 15;
							tH3.rotation = -90;
							addChild(tH3);
							tafelParts.push(tH3);
						}
						else if(i == 8)
						{
							var tH4:TafelHoek = new TafelHoek();
							tH4.x = i * 15;
							tH4.y = j * 15;
							tH4.rotation = 180;
							addChild(tH4);
							tafelParts.push(tH4);
						}
						else
						{
							var tR2:TafelRecht = new TafelRecht();
							tR2.x = i * 15;
							tR2.y = j * 15;
							tR2.rotation = 180;
							addChild(tR2);
							tafelParts.push(tR2);
						}
					}
					else
					{
						if(i == 0)
						{
							var tR3:TafelRecht = new TafelRecht();
							tR3.x = i * 15;
							tR3.y = j * 15;
							tR3.rotation = -90;
							addChild(tR3);
							tafelParts.push(tR3);
						}
						else if(i == 8)
						{
							var tR4:TafelRecht = new TafelRecht();
							tR4.x = i * 15;
							tR4.y = j * 15;
							tR4.rotation = 90;
							addChild(tR4);
							tafelParts.push(tR4);
						}
						else
						{
							var tF:TafelFill = new TafelFill();
							tF.x = i * 15;
							tF.y = j * 15;
							tF.rotation = 0;
							addChild(tF);
							tafelParts.push(tF);
						}
					}
				}
			}
		}
	}
}