package nl.werringweb
{
	/**
	 * Particle effect interface
	 * All particle effects should have atleast these functions
	 */
	public interface ParticleEffect
	{
		//execute the effect
		function effect(p:Particle):void;
		
		//pause the effect
		function stop():void;
		//resume the effect
		function resume():void;
		//configure effect settings
		function config(setting:String,value:*):Boolean;
		//get list of configurable items
		function configList():Array;
		//is effected enabled or is it paused
		function get active():Boolean;
		//name of the effect (UNIQUE!) 
		function get name():String;
		
	}
}