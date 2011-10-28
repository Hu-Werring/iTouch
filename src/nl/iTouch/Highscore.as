package nl.iTouch
{
	import flash.data.SQLResult;
	import flash.display.Sprite;
	import flash.text.TextField;

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
			var data:Array = new Array();
			data['id'] = null;
			data['naam'] = 'qwertyuiopasdfghjklzxcvbnm';
			data['score'] = int(Math.random()*0xFFFFFF);
			data['datum'] = Math.round(new Date().getTime()/1000);
			var res:SQLResult = db.insert(data,_tableName);
			


		}
		
		public function getList():Array
		{
			var params:Array = new Array();
			params['@table'] = _tableName;
			
			var ret:Array = db.query("SELECT * FROM @table ORDER BY score DESC",params,50).data;
			return ret;
		}
		
		public function submit(name:String, score:uint):void
		{
			var data:Array = new Array();
			data['id'] = 'null';
			data['naam'] = name;
			data['score'] = score;
			data['datum'] = Math.round(new Date().getTime()/1000);
			db.insert(data,_tableName);
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
	}
}