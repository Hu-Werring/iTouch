package nl.iTouch
{
	import com.greensock.TweenLite;
	
	import flash.data.SQLResult;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import mx.utils.StringUtil;
	
	import nid.ui.controls.VirtualKeyBoard;
	import nid.ui.controls.vkb.KeyBoardEvent;

	public class Highscore
	{
		private var db:DataBase = DataBase.getInstance;
		
		private var _name:String;
		private var _tableName:String;
		
		private var _dotLength:int = 121;
		
		public function Highscore(game:String)
		{
			_name = game;
			_tableName = "HS_" + _name;
			
			db.createTable(_tableName,'id int,naam varchar(20), datum int, score int','id');


		}
		
		public function getList(type:String):Array
		{
			var params:Array = new Array();
			var datum:uint
			if(type == 'Week'){
				datum = new Date().getTime()/1000 - 60*60*24*7;
			} else {
				datum = new Date().getTime()/1000 - 60*60*24*30;
			}
			params['@datum'] = datum;
			var ret:Array = db.query("SELECT * FROM "+_tableName+" WHERE datum > @datum ORDER BY score DESC",params,20).data;
			return ret;
		}
		
		public function submit(name:String, score:uint):void
		{
			var data:Array = new Array();
			data['@naam'] = name;
			data['@score'] = score;
			data['@datum'] = Math.round(new Date().getTime()/1000);
			db.query('INSERT INTO '+_tableName+' (id, naam, score, datum) VALUES (null,@naam,@score,@datum)',data);
		}
		
		public function highScoreList():Sprite
		{
			
			var hsList:HSList = new HSList();
			hsList.GameNameTF.text = _name;
			hsList.GameScoreTypeTF.text = 'Week Score';
			var score:Array = generateScore('Week');
			hsList.ScoreList.text = score[1];
			hsList.NameList.text = score[0];
			return hsList;
		}
		
		private function generateScore(type:String):Array
		{
			var list:Array = getList(type);
			
			var names:String = "";
			var scores:String = "";
			for (var i:uint = 0; i<list.length;i++){
				names += formatName(list[i],i);
				scores+= list[i].score + "\n";
			}
			
			return [names,scores];
		}
		
		private function formatName(item:Object,i:int):String
		{
			var txt:String = "";
			switch((i+1).toString().length)
			{
				case 1:
				{
					txt += "  " + (i+1) + ". ";
					break;
				}
				case 2:
				{
					txt += (i+1) + ". ";
					break;
				}
			}
			return txt + item.naam + "\n";
		}
		
		public function submitHS(score:uint):Sprite
		{
			
			var sw:ScoreWindow = new ScoreWindow();
			sw.TFName.addEventListener(MouseEvent.CLICK,toggleKeyboard);
			sw.TFScore.text = score.toString();
			sw.sendKnop.buttonMode = true;
			sw.noSendKnop.buttonMode = true;
			sw.sendKnop.addEventListener(MouseEvent.CLICK,sendScoreMouse);
			sw.noSendKnop.addEventListener(MouseEvent.CLICK,noSendScore);
			
			VirtualKeyBoard.getInstance().addEventListener(KeyBoardEvent.ENTER,sendScoreKb)
			
			return sw;
		}
		
		private function sendScore(obj:ScoreWindow):void
		{
			var naam:String = obj.TFName.text;
			var score:uint = uint(obj.TFScore.text);
			if(naam.length !=0){
				hideKB();
				hideSubmit(obj);
				submit(naam,score);
			} else {
				obj.TFName.borderColor = 0xFF0000;
				obj.TFName.backgroundColor = 0xFFCCCC;
			}

		}
		
		private function sendScoreMouse(e:MouseEvent):void
		{	
			sendScore(e.currentTarget.parent);
		}
		private function sendScoreKb(e:KeyBoardEvent):void
		{
			sendScore(e.obj as ScoreWindow);
		}
		
		private function noSendScore(e:MouseEvent):void
		{
			hideSubmit(e.target.parent as ScoreWindow);
		}

		
		private function hideSubmit(object:ScoreWindow):void
		{
			object.noSendKnop.removeEventListener(MouseEvent.CLICK,noSendScore);
			object.sendKnop.removeEventListener(MouseEvent.CLICK,sendScore);
			TweenLite.to(object,1,{alpha:0,scaleX:0,scaleY:0,x:object.width/2+object.x,y:object.height/2+object.y,onComplete:function():void{ 
				object.parent.removeChild(object);
			}});

		}
		private function toggleKeyboard(e:MouseEvent):void 
		{
			VirtualKeyBoard.getInstance().target = { field:e.currentTarget, fieldName:"Je hebt de highscore behaald,\nType je naam." };
		}
		private function hideKB():void
		{
			VirtualKeyBoard.getInstance().hide();
		}

	}
}