
package com.fullsizeBackgroundImage {
	
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	public class fullsizeBackgroundImage extends Sprite {
		
		private var backgroundImgUrl:String; //for backgroundimage URL
		private var backgroundImgLoader:Loader = new Loader(); //container for backgroundimage
		private var patternBitmapData:BitmapData; //for overlay pattern
		private var pattern:Sprite = new Sprite(); //container for overlay pattern
		private var pixel:Sprite = new Sprite(); //container for single pixel
		private var BGx:int;
		private var BGy:int;
		
		
		public function fullsizeBackgroundImage(_backgroundImgUrl:String, _x:int, _y:int) {
			backgroundImgUrl = _backgroundImgUrl;
			addEventListener(Event.ADDED_TO_STAGE, init); //listener to call init
			
			
			BGx = _x;
			BGy = _y; 
			
			x = _x;
			y = _y;
			
			
			
		}
		
		private function init(e:Event):void {
			
			

			
		 	
			
			stage.addEventListener(Event.RESIZE, loadBackImgComplete); //listener for resizing stage
			stage.addEventListener(Event.RESIZE, setPattern); //listener for resizing stage

            backgroundImgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadBackImgComplete); //listener to set backgroundimage when loaded
            backgroundImgLoader.load(new URLRequest(backgroundImgUrl)); //load backgroundimage
			
			addChild(backgroundImgLoader); //add the backgroundimage container to the stage
            addChild(pattern); //add the pixel pattern overlay container to the stage
            
            createPixel(); //call function to create single pixel for pattern overlay
            
			setPattern(null); //call function to create and set pattern overlay
		}
		
		//create single pixel for pattern overlay
		private function createPixel():void {
			pixel.graphics.beginFill(0x000000, 1);
			pixel.graphics.drawRect(0, 0, 1, 1);
			pixel.graphics.endFill();
		}
		
//set the with, height and position of the backgroundimage
		private function loadBackImgComplete(e:Event):void {
		
			backgroundImgLoader.width = 1280; //backgroundimage width is equal to stage width
			backgroundImgLoader.height = 428; //* (backgroundImgLoader.content.height / backgroundImgLoader.content.width); //backgroundimage height is proportional to backgroundimage width
			backgroundImgLoader.y = stage.stageHeight - backgroundImgLoader.height + ((backgroundImgLoader.height - stage.stageHeight) / 2); //center the horizontal position of the backgroundimage 
		}
		
		//set overlay pattern
		private function setPattern(e:Event):void {
			patternBitmapData = new BitmapData(2, 2, true, 0x000000); //create single piece of the pattern
			patternBitmapData.draw(pixel); //convert pixel sprite to bitmapdata
			pattern.graphics.beginBitmapFill(patternBitmapData); //draw bitmapdata
			pattern.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight); //draw rectangele with pattern over the complete stage
			pattern.graphics.endFill(); //end draw bitmapdata
		}
	}
}