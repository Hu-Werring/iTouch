package nl.iTouch.eyecatcher
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import nl.werringweb.*;

	public class ParticleSystem extends Sprite
	{//All items that would like the mouse location are stored in here
		//Not used in this app, since the requirement was that there would be no userinput (screensaver / VJ app)
		private static var _mouseRequestList:Array = new Array();
		public var emitor:Emitor = new Emitor(Emitor.RANDOM,8);
		public var emitor2:Emitor = new Emitor(Emitor.RANDOM,8);
		public function ParticleSystem()
		{
			
			addChild(emitor);
			emitor.setParticle = CDParticle;
			
			
			addChild(emitor2);
			emitor2.setParticle = BoekParticle;
			
			
			
			
			
			
		}
		
		public function pause():void
		{
			emitor.pause();
			emitor2.pause();
					
		}
		
		public function resume():void
		{
			emitor.resume();
			emitor2.resume();
			
		}
		
		
		//ask emitor to get the mouseLocation
		public static function addMouseRequest(emitor:Emitor):void
		{
			_mouseRequestList.push(emitor);
		}
		
		
		//send mouse location to all emitors requesting them
		private function mouseLoc(e:MouseEvent):void
		{
			var list:Array = ParticleSystem._mouseRequestList;
			for(var i:uint=0;i<list.length;i++){
				list[i].setPlacement(e.stageX,e.stageY);
			}
		}
	}
}