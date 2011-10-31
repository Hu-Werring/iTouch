package nl.iTouch.eyecatcher
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import nl.werringweb.*;

	public class ParticleSystem extends Sprite
	{//All items that would like the mouse location are stored in here
		//Not used in this app, since the requirement was that there would be no userinput (screensaver / VJ app)
		private static var _mouseRequestList:Array = new Array();
		public function ParticleSystem()
		{
			var emitor:Emitor = new Emitor(Emitor.RANDOM,10);
			addChild(emitor);
			emitor.setParticle = CDParticle;
			
			var emitor2:Emitor = new Emitor(Emitor.RANDOM,10);
			addChild(emitor2);
			emitor2.setParticle = BoekParticle;
			
			
			
			
			
			
		}
		//ask emitor to get the mouseLocation
		public static function addMouseRequest(emitor:Emitor):void
		{
			_mouseRequestList.push(emitor);
			trace("List:" + _mouseRequestList);
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