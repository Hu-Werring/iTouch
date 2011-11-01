package nl.iTouch.guessgame
{
	import com.greensock.TweenLite;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.display.ContentDisplay;
	
	import effects.TwirlEffect;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
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
		
		private var _bookHolder:GuessGameHolder = new GuessGameHolder();
		
		private var _timeLeft:int;
		private var effect:TwirlEffect = new TwirlEffect();
		private var effects:int;
		
		private var blurY:BlurFilter = new BlurFilter(0,15);
		private var blurX:BlurFilter = new BlurFilter(10,0);
		public function GuessGame()
		{
			_queue = new LoaderMax({name:'mainQueue',onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler});
			addEventListener(Event.ADDED_TO_STAGE,init);
			
			/*Should become XML if there is time left*/
			_boekenlijst.push({ naam:'Rapporteren voor techniek en ICT',
				image:'rapporteren_voor_techniek_en_ict',
				author:'Marcel Heerink',
				desc:'Dit boek is een praktische handleiding voor het opstellen van rapporten in een specifieke omgeving. Aan de hand van duidelijke voorbeelden bespreekt de auteur de belangrijkste aspecten van verschillende soorten rapporten met betrekking tot techniek. De auteur besteedt ruime aandacht aan project- en procesgerichte rapportage en geeft aan wat voor de uiteenlopende rapportvarianten essentieel is.',
				antwoorden:['Rapporteren de basis','Rapporteren voor Techniek en ICT','Rapport over rapporteren','Ethiek voor Techniek en ICT']
			});
			_boekenlijst.push({ naam:'Veilig en verantwoord werken',
				image:'veilig_en_verantwoord_werken',
				author:'J. v. Gijn/A.W. Zwaard',
				desc:'Dit boek wil duidelijk maken, speciaal voor studenten die een technische opleiding volgen, wat verantwoord werken is. Bij verantwoord werken geeft men zich rekenschap van dat wat men onderneemt. Daarvoor is kennis nodig: kennis van mogelijke risico\'s, maar ook kennis van de achtergronden van die risico\'s. Door de behandeling van die achtergronden - die van chemische, natuurkundige, biologische, maar ook van sociologische aard kunnen zijn - heeft het boek een brede achtergrond.',
				antwoorden:['Veilig en verantwoord werken','Veilig werken met elektronische installaties','Duurzaam ondernemen','Veilig werken in besloten ruimtes']
			});
			_boekenlijst.push({ naam:'Basisvaardigheden wiskunde',
				image:'basisvaardigheden_wiskunde',
				author:'Wolters-Noordhoff',
				desc:'Wiskunde is voor elke HTO-student doorbereiding voor de studie. Dit boek is geschikt voor zelfstudie per twee pagina\'s wordt onderwerp behandeld met duidelijke uitleg, voorbeelden en opdrachten. Oefen met de cd-rom bij het boek net zo lang totdat, je de stof beheerst. Dit boek is een handig naslagwerk door de overzichtelijke opbouw van de stof en de duidelijke praktijkvoorbeelden.',
				antwoorden:['Basisvaardigheden wiskunde','Wiskunde voor hto','Wiskunde in blokken','Toegepaste wiskunde']
			});
			_boekenlijst.push({ naam:'Zo doe je een onderzoek',
				image: 'zo_doe_je_een_onderzoek',
				author:'Roel Grit/Mark Julsing',
				desc:'Organisaties, zoals bedrijven, instellingen en overheden, laten geregeld onderzoeken uitvoeren. Een afgestudeerde van hogeschool of universiteit moet daarom beschikken over onderzoeksvaardigheden. Veel studenten krijgen daarom vanaf het begin tot het eind van hun studie opdrachten om een onderzoek uit te voeren. Het eindproduct van het onderzoek is een onderzoeksrapport of een scriptie. Met dit boek voer je in acht stappen een onderzoek uit.',
				antwoorden:['Statistiek in onderzoek','Wat is onderzoek?','Methoden en technieken van onderzoek','Zo doe je een onderzoek']
			});
			
			_boekenlijst.push({	naam:'Elektrische netwerken',
				image:'electrische_netwerken',
				author:'Paul Holmes',
				desc:'Dit boek is een toegankelijke inleiding op de theorie en praktijk: de essentiële stof voor iedere elektrotechnicus. Het boek bestaat uit drie delen. Het accent van dit boek ligt op praktische toepasbaarheid. Modelvorming, aansluiting bij de praktijk, probleemaanpak en technisch inzicht krijgen dan ook meer aandacht dan formele theoretische bewijsvorming.',
				antwoorden:['Elektrische installatie techniek','Elektrische netwerken','Management in netwerken','Het elektrische woud']
			});
			_boekenlijst.push({	naam:'Computersystemen en embedded systemen',
				
				image:'Computersystemen_en_embedded_systemen',
				author:'L.J.M. van Moergestel',
				desc:'Dit boek biedt een gedegen basiskennis op het gebied van computertechnieken waarbij ook de embedded systemen aan de orde komen. Daarnaast worden andere belangrijke,nieuwe systemen besproken zoals digital signal processing, Harvard-architectuur, bussystemen die bij embedded systemen een rol spelen, grafische beeldweergave, transmissietechnieken (van TDM en FDM tot ADSL), dataopslag in netwerken (NAS, SAN), optische disks (DVD), 64-bits multiprocessoren, en realtime scheduling (voor embedded systemen). ',
				antwoorden:['Embedded elextronics','Inleiding computersystemen','Computersystemen en embedded systemen','Computertechniek']
				});
			_boekenlijst.push({	naam:' Constructieprincipes',
				image:'constuctie_principes',
				author:'M.P. Koster',
				
				desc:' Ontwerpen hangt samen met het bedenken van iets nieuws. De vraag is: kun je dat leren? Ondanks het feit dat het bedenken als proces niet als opvallend methodisch en systematisch wordt gekenmerkt, valt hier toch een grote verbetering te bereiken. Dit boek wil de rol spelen van de ontwerper met een rijke ervaring, die bovendien deze ervaring op een toegankelijke manier heeft geordend. Het boek bestrijkt het deelveld van de werktuigbouwkunde dat zich kenmerkt door nauwkeurigheid in beweging en plaats.',
				antwoorden:['Constructieprincipes','Werktuigbouwkunde voor hto','Constructies','Mechanica van construcites']
				});
			_boekenlijst.push({	naam:' Analyse van bedrijfsprocessen',
				image:'analyse_van_bedrijfsprocessen',
				author:'Jan in \'t Veld',

				desc:' Dit boek beschrijft de theorie en de praktijk van het denken in systemen, modellen, processen en regelkringen. Dit systeem en procesdenken wordt toegepast bij het analyseren van processen, bij het bepalen van de noodzakelijke informatiestromen en bij het ontwerpen van organisatiestructuren. Het boek vormt de basis voor een goed begrip van de voordelen en beperkingen van procesgerichte managementtechnieken als Total Quality Management, Logistiek en Supply Chain Management, Business Process Redesign en Workflow Management.',
				antwoorden:['Management van processen','Presteren met processen','Kijk op bedrijfprocessen','Analyse  van bedrijfsprocessen']
				});

			for(var i:int = 0;i<_boekenlijst.length;i++)
			{
				_queue.append(new ImageLoader("img/"+ _boekenlijst[i].image + '.jpg',{name:_boekenlijst[i].naam, alpha:0, width:500, height:347,x:0,y:0, scaleMode:"proportionalInside"}));
				trace(_boekenlijst[i].image);
			}
			_queue.load();			
		}
		
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			if(_loaded) play();
			
			addChild(_bookHolder);
			
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
			
			_bookHolder.bookHolder.filters = [blurX,blurY];
			
			_bookHolder.authorTF.text = boek.author;
			_bookHolder.descTF.text = boek.desc;
			
			trace(boek.author,boek.desc);
			
			
			_bookHolder.AntwA.text = "A: " + boek.antwoorden[0];
			_bookHolder.AntwB.text = "B: " + boek.antwoorden[1];
			_bookHolder.AntwC.text = "C: " + boek.antwoorden[2];
			_bookHolder.AntwD.text = "D: " + boek.antwoorden[3];
			_bookHolder.AntwA.wordWrap = true;
			_bookHolder.AntwB.wordWrap = true;
			_bookHolder.AntwC.wordWrap = true;
			_bookHolder.AntwD.wordWrap = true;
			
			var loader:ImageLoader =LoaderMax.getLoader(boek.naam) as ImageLoader; 
			
			_bookHolder.bookHolder.addChild(effect);
			effect.effectIn(loader.rawContent);
			effects = 3;
			_bookHolder.bookHolder.addEventListener(MouseEvent.CLICK,disableEffects);
			
		}
		private function disableEffects(e:MouseEvent):void
		{
			switch(effects){
				case 3:
					effect.disable();
				break;
				case 2:
					_bookHolder.bookHolder.filters = [blurX];
				break;
				case 1:
					_bookHolder.bookHolder.filters = [];
				break;
			}
			effects--;
		}
		public function stop(force:Boolean = false):void
		{
			_queue.unload();
		}
		
		public function credits():void
		{
			
		}
		
		public function highscore():void
		{
			
		}
	}
}