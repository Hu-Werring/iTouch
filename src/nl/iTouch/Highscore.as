package nl.iTouch
{
	public class Highscore
	{
		private var db:DataBase = DataBase.getInstance;
		
		private var _name:String;
		private var _tableName:String;
		
		public function Highscore(game:String)
		{
			_name = game;
			_tableName = "HS_" + _name;
			db.createTable(_tableName,"id int, naam varchar(127), datum int(10), score int(10)",'id');
		}
		
		public function getList():Array
		{
			var params:Array = new Array();
			params['@table'] = _tableName;
			
			var ret:Array = db.query("SELECT * FROM @table",params,50).data;
			return ret;
		}
		
		public function submit(name:String, score:uint):void
		{
			
		}
	}
}