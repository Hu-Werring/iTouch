package nl.iTouch.eyecatcher
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.utils.*;
	
	public class Lucas extends Sprite {
		private var beweeg:Array = new Array();	
		
		private var a:Array = [boven, onder, links, rechts];
		private var snelheid:Number;

		public var lucasLinks:LucasImage = new LucasImage();
		public var lucasRechts:LucasImage = new LucasImage();
		public var lucasBoven:LucasImage = new LucasImage();
		public var lucasOnder:LucasImage = new LucasImage();
		
		public function Lucas() {
			var tralalala:LucasImage = new LucasImage();
			tralalala.visible = false;
			addChild(tralalala);
			width = 125; //25
			height = 265;//53	
			beweeg['links'] = false;	
			beweeg['rechts'] = false;	
			beweeg['boven'] = false;	
			beweeg['onder'] = false;
			

			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		public function links():void
		{
				trace("Links");
				addEventListener(Event.ENTER_FRAME,beweegLucasLinks);	
		}
		public	function rechts():void
		{
				trace("Rechts");
				addEventListener(Event.ENTER_FRAME,beweegLucasRechts);
		}
		public	function onder():void
		{
				trace("Onder");
				addEventListener(Event.ENTER_FRAME,beweegLucasOnder);
		}
		public	function boven():void
		{
				trace("boven");
				addEventListener(Event.ENTER_FRAME,beweegLucasBoven);
		}			
		public function init(e:Event):void
		{		
			removeEventListener(Event.ADDED_TO_STAGE,init);		
			
				lucasLinks.x = -5;
				lucasLinks.y = 0;
				lucasLinks.rotation = 90;
				addChild(lucasLinks);	

				lucasRechts.x= 2565;
				lucasRechts.y= 0;
				lucasRechts.rotation = 270;
				addChild(lucasRechts);
				
				lucasOnder.x = 0;				
				lucasOnder.y = 2100;
				lucasOnder.rotation = 0;
				addChild(lucasOnder);
				
				lucasBoven.x = 0; 
				lucasBoven.y = 0;
				lucasBoven.rotation= 180;
				addChild(lucasBoven);
				
				randomZijde(); 
		}				
		public	function randomZijde():void
		{
				a[Math.floor(Math.random() * a.length)]();
				snelheid = Math.floor(Math.random() * 8 + 4);
				//snelheid = 8;
				trace('Random zijde');
				
				lucasRechts.y = Math.random() * 2200 + 100;	
				lucasLinks.y = Math.random() * 1900 + 100;
				lucasBoven.x = Math.random() * 2200 + 100;	
				lucasOnder.x = Math.random() * 2200 + 100;
		}
			
		public function beweegLucasOnder(e:Event):void
			{
				if(beweeg['onder'] == false){
					lucasOnder.y -= snelheid;
					if(lucasOnder.y <= 1800)
					{
						beweeg['onder'] = true;
					}
				}				
				else if(beweeg['onder'] == true){
					lucasOnder.y +=  snelheid;					
					if(lucasOnder.y >= 2100)
					{
						beweeg['onder'] = false;
						trace("Verplaats");
						//lucasOnder.x = Math.random() * 2300;
						//lucasOnder.y = 2100;
						this.removeEventListener(Event.ENTER_FRAME,beweegLucasOnder);

						randomZijde();
					}
				}								
			}			
			
			public function beweegLucasBoven(e:Event):void
			{
				if(beweeg['boven'] == false){
					lucasBoven.y += snelheid;
					if(lucasBoven.y >= 250)
					{
						beweeg['boven'] = true;
					}
				}				
				else if(beweeg['boven'] == true){
					lucasBoven.y -=  snelheid;					
					if(lucasBoven.y <= 0)
					{
						beweeg['boven'] = false;
						trace("Verplaats");
						//lucasBoven.x = Math.random() * 2300;	
						//lucasBoven.y = 0;
						this.removeEventListener(Event.ENTER_FRAME,beweegLucasBoven);
						randomZijde();

					}
				}								
			}		
			
			public function beweegLucasLinks(e:Event):void
			{			
				trace(lucasLinks.x);
				if(beweeg['links'] == false){
					
					if(lucasLinks.x >= 250)
					{
						beweeg['links'] = true;						
					} else {
						lucasLinks.x +=  snelheid;						
					}
				}				
				else if(beweeg['links'] == true){
					if(lucasLinks.x <= -5)
					{
						beweeg['links'] = false;				
						trace("Verplaats",lucasLinks.x);
						//lucasLinks.y = Math.random() * 1800;
						//lucasLinks.x = 0;
						this.removeEventListener(Event.ENTER_FRAME,beweegLucasLinks);
						randomZijde();


					} else {
						lucasLinks.x -=  snelheid;					
					}
				}								
			}							
			
			public function beweegLucasRechts(e:Event):void
			{							
				if(beweeg['rechts'] == false){
					lucasRechts.x -=  snelheid;			
					if(lucasRechts.x <= 2300)
					{
						beweeg['rechts'] = true;						
					}
				}				
				else if(beweeg['rechts'] == true){
					lucasRechts.x +=  snelheid;					
					if(lucasRechts.x >= 2565)
					{
						beweeg['rechts'] = false;			
						trace("Verplaats" + " x: " + lucasRechts.x + " y: " + lucasRechts.y);
						//lucasRechts.y = Math.random() * 2300;	
					//	lucasRechts.x= 2550;
						this.removeEventListener(Event.ENTER_FRAME,beweegLucasRechts);					
						randomZijde();
					}
				}								
						
			}
		}
}