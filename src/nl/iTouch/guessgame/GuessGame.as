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
	import flash.filters.BlurFilter;
	
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
		
		private var _bookHolder:Sprite = new Sprite();
		
		private var _timeLeft:int;
		
		public function GuessGame()
		{
			_queue = new LoaderMax({name:'mainQueue',onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler});
			addEventListener(Event.ADDED_TO_STAGE,init);
			
			/*Should become XML if there is time left*/
			_boekenlijst.push({	naam:'Rapporteren voor techniek en ICT',
								image:'rapporteren_voor_techniek_en_ict',
								author:'M. Heerink',
								desc:'Dit boek is een praktische handleiding voor het opstellen van rapporten in een specifieke omgeving. Aan de hand van duidelijke voorbeelden bespreekt de auteur de belangrijkste aspecten van verschillende soorten rapporten met betrekking tot techniek. De auteur besteedt ruime aandacht aan project- en procesgerichte rapportage en geeft aan wat voor de uiteenlopende rapportvarianten essentieel is.',
								antwoorden:['Rapporteren de basis','Rapporteren voor Techniek en ICT','Rapport over rapporteren','Ethiek voor Techniek en ICT']
			});
			_boekenlijst.push({	naam:'Veilig en verantwoord werken',
								image:'veilig_en_verantwoord_werken',
								author:'J. Van Gijn & A.W. Zwaard',
								desc:'Dit boek wil duidelijk maken, speciaal voor studenten die een technische opleiding volgen, wat verantwoord werken is. Bij verantwoord werken geeft men zich rekenschap van dat wat men onderneemt. Daarvoor is kennis nodig: kennis van mogelijke risico\'s, maar ook kennis van de achtergronden van die risico\'s. Door de behandeling van die achtergronden - die van chemische, natuurkundige, biologische, maar ook van sociologische aard kunnen zijn - heeft het boek een brede achtergrond.',
								antwoorden:['Veilig en verantwoord werken','Veilig werken met elektronische installaties','Duurzaam ondernemen','Veilig werken in besloten ruimtes']
			});
			_boekenlijst.push({	naam:'Basisvaardigheden wiskunde',
								image:'basisvaardigheden_wiskunde',
								author:'Douwe Jan Douwes & Jaap Grasmeijer',
								desc:'Wiskunde is voor elke HTO-student doorbereiding voor de studie. Dit boek is geschikt voor zelfstudie per twee pagina’s wordt onderwerp behandeld met duidelijke uitleg, voorbeelden en opdrachten. Oefen met de cd-rom bij het boek net zo lang totdat, je de stof beheerst. Dit boek is een handig naslagwerk door de overzichtelijke opbouw van de stof en de duidelijke praktijkvoorbeelden.',
								antwoorden:['Basisvaardigheden wiskunde','Wiskunde voor hto','Wiskunde in blokken','Toegepaste wiskunde']
			});
			_boekenlijst.push({	naam:'Zo doe je een onderzoek',
								image:'zo_doe_je_een_onderzoek',
								author:'Roel Grit & Mark Julsing',
								desc:'Organisaties, zoals bedrijven, instellingen en overheden, laten geregeld onderzoeken uitvoeren. Een afgestudeerde van hogeschool of universiteit moet daarom beschikken over onderzoeksvaardigheden. Veel studenten krijgen daarom vanaf het begin tot het eind van hun studie opdrachten om een onderzoek uit te voeren. Het eindproduct van het onderzoek is een onderzoeksrapport of een scriptie. Met dit boek voer je in acht stappen een onderzoek uit.',
								antwoorden:['Statistiek in onderzoek','Wat is onderzoek?','Methoden en technieken van onderzoek','Zo doe je een onderzoek']
			});

			for(var i:int = 0;i<_boekenlijst.length;i++)
			{
				_queue.append(new ImageLoader("img/"+ _boekenlijst[i].image + '.jpg',{name:_boekenlijst[i].naam, estimatedBytes:2400, container:_bookHolder, alpha:0, width:500, height:347, scaleMode:"proportionalInside"}));
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
			
			var blurY:BlurFilter = new BlurFilter(0,15);
			var blurX:BlurFilter = new BlurFilter(10,0);
			_bookHolder.filters = [blurX,blurY];
			_bookHolder.x = 300;
			_bookHolder.y= 400;
			addChild(_bookHolder);
			trace(boek.naam,boek.image,boek.author,boek.desc,boek.antwoorden);
			
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