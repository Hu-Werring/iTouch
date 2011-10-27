package nl.iTouch.eyecatcher
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.utils.*;
	
	public class Lucas extends Sprite {
		private var beweeg:Boolean;		
		private var a:Array = [links];
		private var snelheid:Number;
		
		public function Lucas() {
			addChild(new LucasImage());
			trace("Lucas weergeven");
			width = 150;
			height = 250;		
			beweeg = false;	
			addEventListener(Event.ADDED_TO_STAGE,startlucas);
		}
		public function links():void
		{
				trace("Links");
				addEventListener(Event.ENTER_FRAME,beweegLucasLinks);
				x=0;
				rotation = 90;			
		}
		public	function rechts():void
		{
				trace("Rechts");
				addEventListener(Event.ENTER_FRAME,beweegLucasRechts);
				x=1300;
				rotation = 270;
		}
		public	function onder():void
		{
				trace("Onder");
				addEventListener(Event.ENTER_FRAME,beweegLucasOnder);
				y = 950;
				rotation =0;
		}
		public	function boven():void
		{
				trace("boven");
				addEventListener(Event.ENTER_FRAME,beweegLucasBoven);
				y = 0;
				rotation= 180;
		}			
		public function startlucas(e:Event):void
		{
				randomZijde(); 
		}				
		public	function randomZijde():void
		{
				removeEventListener(Event.ENTER_FRAME,startlucas);
				a[Math.floor(Math.random() * a.length)]();
				snelheid = Math.floor(Math.random() * 5 + 2);
				beweeg = false;
		}
			
		public function beweegLucasOnder(e:Event):void
			{
				if(beweeg == false){
					e.currentTarget.y -= snelheid;
					if(e.currentTarget.y <= 900)
					{
						beweeg = true;
					}
				}				
				else if(beweeg == true){
					e.currentTarget.y +=  snelheid;					
					if(e.currentTarget.y >= 1050)
					{
						beweeg = false;
						trace("Verplaats");
						x = Math.random() * 1200 + 0;					
						randomZijde();
					}
				}								
			}			
			
			public function beweegLucasBoven(e:Event):void
			{
				if(beweeg == false){
					e.currentTarget.y += snelheid;
					if(e.currentTarget.y >= 100)
					{
						beweeg = true;
					}
				}				
				else if(beweeg == true){
					e.currentTarget.y -=  snelheid;					
					if(e.currentTarget.y <= 0)
					{
						beweeg = false;
						trace("Verplaats");
						x = Math.random() * 1200 + 0;					
						randomZijde();
					}
				}								
			}		
			
			public function beweegLucasLinks(e:Event):void
			{				
				if(beweeg == false){
					e.currentTarget.x +=  snelheid;
					if(e.currentTarget.x >= 80)
					{
						beweeg = true;						
					}
				}				
				else if(beweeg == true){
					e.currentTarget.x -=  snelheid;					
					if(e.currentTarget.x <= -50)
					{
						beweeg = false;				
						trace("Verplaats");
						y = Math.random() * 800 + 50;	
						randomZijde();
					}
				}								
			}							
			
			public function beweegLucasRechts(e:Event):void
			{							
				if(beweeg == false){
					e.currentTarget.x -=  snelheid;			
					if(e.currentTarget.x <= 1220)
					{
						beweeg = true;						
					}
				}				
				else if(beweeg == true){
					e.currentTarget.x +=  snelheid;					
					if(e.currentTarget.x >= 1300)
					{
						beweeg = false;			
						trace("Verplaats");
						y = Math.random() * 800 + 50;	
						randomZijde();
					}
				}								
						
			}
		}
}