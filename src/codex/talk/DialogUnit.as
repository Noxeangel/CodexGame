package codex.talk 
{
	/**
	 * ...
	 * @author Olivier
	 */
	public class DialogUnit 
	{
		private var _id:String = "DEBUG_ID";
		private var _lines:Array = new Array();
		
		public function DialogUnit() 
		{
			
		}
		
		public function get lines():Array 
		{
			return _lines;
		}
		
		public function set lines(value:Array):void 
		{
			_lines = value;
		}
		
		public function get id():String 
		{
			return _id;
		}
		
		public function set id(value:String):void 
		{
			_id = value;
		}
		
	}

}