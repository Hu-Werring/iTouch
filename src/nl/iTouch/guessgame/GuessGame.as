package nl.iTouch.guessgame
{
	import com.greensock.TweenLite;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.display.ContentDisplay;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import nl.iTouch.DataBase;
	import nl.iTouch.Game;
	import nl.iTouch.Highscore;
	
	public class GuessGame extends Sprite implements Game
	{
		private const _totaltime:int = 30;
		
		
		
		private var _db:DataBase = DataBase.getInstance;
		private var _hs:Highscore = new Highscore('ChaosBoeken');
		private var _boekenlijst:Array = new Array();
		
		private var _queue:LoaderMax;
		private var _loaded:Boolean = false;
		
		
		private var _timeLeft:int;
		
		public function GuessGame()
		{
			_queue = new LoaderMax({name:'mainQueue',onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler});
			addEventListener(Event.ADDED_TO_STAGE,init);
			
			/*Should become XML if there is time left*/
			_boekenlijst.push({naam:'Test',image:'testBoek',desc:'Beschrijving van dit boek',antwoorden:['Test','xD','ROFL','LMAO']});
			_boekenlijst.push({naam:'Test2',image:'testBoek2',desc:'Beschrijving van dit boek2',antwoorden:['Test2','xD','ROFL','LMAO']});
			_boekenlijst.push({naam:'Test3',image:'testBoek3',desc:'Beschrijving van dit boek3',antwoorden:['Test3','xD','ROFL','LMAO']});
			_boekenlijst.push({naam:'Test4',image:'testBoek4',desc:'Beschrijving van dit boek4',antwoorden:['Test4','xD','ROFL','LMAO']});
			_boekenlijst.push({naam:'Test5',image:'testBoek5',desc:'Beschrijving van dit boek5',antwoorden:['Test5','xD','ROFL','LMAO']});
			for(var i:int = 0;i<_boekenlijst.length;i++)
			{
				_queue.append(new ImageLoader(_boekenlijst[i].image + '.png',{name:_boekenlijst[i].naam, estimatedBytes:2400, container:this, alpha:0, width:250, height:150, scaleMode:"proportionalInside"}));
				trace(_boekenlijst[i].image);
			}
			_queue.load();			
		}
		
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			if(_loaded) play();
			
			
		}
		
		private function completeHandler(e:LoaderEvent):void
		{
			if(stage) play();
			_loaded = true;
		}
		
		private function progressHandler(event:LoaderEvent):void {
			trace("progress: " + event.target.progress);
		}
		
		private function errorHandler(event:LoaderEvent):void {
			trace("error occured with " + event.target + ": " + event.text);
		}
		
		public function play():void
		{
			this.parent.addEventListener(MouseEvent.CLICK,startGame);
		}
		
		private function startGame(e:MouseEvent):void
		{
			this.parent.removeEventListener(MouseEvent.CLICK,startGame);
			var boek:Object = _boekenlijst[Math.floor(Math.random()*_boekenlijst.length)];
			
			trace(boek.naam,boek.image,boek.desc,boek.antwoorden);
			
			TweenLite.to(LoaderMax.getContent(boek.naam),1,{alpha: 1});
			
		}
		
		
		
		public function stop(force:Boolean = false):void
		{
			
		}
		
		public function credits():void
		{
			
		}
		
		public function highscore():void
		{
			
		}
	}
}