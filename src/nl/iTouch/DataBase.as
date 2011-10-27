package nl.iTouch
{
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	import flash.filesystem.File;

	public class DataBase
	{
		//SINGLETON
		private static var singleton:DataBase= null;
		public function DataBase()
		{
			if(DataBase.singleton != null) throw(new Error("Tried to load a singleton class twice. Call class with DataBase.getInstance instead of new DataBase"));
			DataBase.singleton = this;
			init();
		}
		public static function get getInstance():DataBase
		{
			if(DataBase.singleton == null) DataBase.singleton = new DataBase();
			return DataBase.singleton;
		}
		//END SINGLETON
		
		
		private var _dbFile:File;
		private var _sqlCon:SQLConnection;
		private var _sqlStatement:SQLStatement;
		
		private function init():void
		{
			try {
			_dbFile = File.applicationDirectory.resolvePath('iTouch.db');
			if(!_dbFile.exists) throw(new Error('Database could not be found!'));
			_sqlCon = new SQLConnection();
			_sqlStatement = new SQLStatement();
			
			_sqlCon.open(_dbFile);
			_sqlStatement.sqlConnection = _sqlCon;
			} catch(e:Error) {
				trace(e.message,e.getStackTrace());
			}
		}
		
		public function query(qry:String,params:Array = null):SQLResult
		{
			_sqlStatement.clearParameters();
			_sqlStatement.text = qry;
			if(params !=null){
				for(var key:* in params)
				{
					trace(key,params[key]);
					_sqlStatement.parameters[key] = params[key];
				}
			}
			_sqlStatement.execute();
			return _sqlStatement.getResult();
		}
		
		public function createTable(name:String,fields:String,key:String):void
		{
			try{
				var res:SQLResult = query('CREATE TABLE '+name+' ('+fields+', PRIMARY KEY ('+key+'));');
			} catch(e:SQLError){
				//Ignore error table already exists, SQLite doesn't support if not exists
				if(e.details!="table '"+name+"' already exists"){
					throw(e);
				} else {
					trace(e.details);
				}
			}
		}
		
		public function insert(data:Array,table:String):SQLResult
		{
			var fieldList:String = "";
			var inserts:Array = new Array();
			for (var key:String in data){
				fieldList += key + ", ";
				inserts['@' + key] = data[key];
			}
			fieldList = fieldList.slice(0,-2);
			try{
				var res:SQLResult = query('INSERT INTO ' + table + ' (' + fieldList + ') VALUES (@'+fieldList.replace(', ',', @')+')',inserts);
			} catch(e:SQLError){
				trace(e);
			}
			return res;
		}
	}
}