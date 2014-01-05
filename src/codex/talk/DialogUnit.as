package codex.talk 
{
	/**
	 * ...
	 * @author Olivier
	 */
	public class DialogUnit 
	{
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
		
	}

}