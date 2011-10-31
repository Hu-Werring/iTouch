package nl.werringweb
{
	import flash.events.Event;
/**
 * Particle interface
 * All particles should have atleast these functions
 */
	public interface Particle
	{
		
		/**
		 * By using Get and Set functions, 
		 * particles objects can disallow changes
		 */
		//Change maxAge
		function set maxAge(age:uint):void;
		//get maxAge, needed for a lot of effect calculations
		function get maxAge():uint;
		//get age, needed for a lot of effect calculations
		function get age():uint;
		
		
		//set and get speed
		function set speedX(speed:Number):void;
		function set speedY(speed:Number):void;
		function set speedZ(speed:Number):void;
		function get speedX():Number;
		function get speedY():Number;
		function get speedZ():Number;
		
		//set color for particle
		function set color(color:uint):void
			
			
		
		//delete particle
		function deleteMe():void;
	}
}