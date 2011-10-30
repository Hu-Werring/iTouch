package nl.iTouch
{
	import flash.data.SQLResult;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import nid.ui.controls.VirtualKeyBoard;

	public class Highscore
	{
		private var db:DataBase = DataBase.getInstance;
		
		private var _name:String;
		private var _tableName:String;
		
		public function Highscore(game:String)
		{
			_name = game;
			_tableName = "HS_" + _name;
			
			db.createTable(_tableName,'id int,naam varchar(20), datum int, score int','id');


		}
		
		public function getList():Array
		{
			var params:Array = new Array();
			
			var ret:Array = db.query("SELECT * FROM "+_tableName+" ORDER BY score DESC",null,50).data;
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
			var holder:Sprite = new Sprite();
			var scoreList:TextField = new TextField();
			var title:TextField = new TextField();
			title.text = _name;
			_name.charAt(0).toUpperCase();
			holder.addChild(title);
			scoreList.border = true;
			scoreList.y = 20;
			scoreList.width = 800;
			scoreList.height = 600;
			holder.addChild(scoreList);
			return holder;
		}
		
		public function submitHS():Sprite
		{
			
			var holder:Sprite = new Sprite();
			holder.graphics.beginFill(0xFFFFFF);
			holder.graphics.lineStyle(1,0xE63028);
			holder.graphics.drawRect(0,0,300,150);
			holder.graphics.endFill();
			var TF:TextField = new TextField();
			TF.width = 300;
			TF.height = 100;
			TF.addEventListener(MouseEvent.CLICK, toggleKeyboard);
			holder.addChild(TF);
			return holder;
		}
		
		private function toggleKeyboard(e:MouseEvent):void 
		{
			
			VirtualKeyBoard.getInstance().target = { field:e.currentTarget, fieldName:"Test" };
		}

	}
}