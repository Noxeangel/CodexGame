package codex.characters
{
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class General extends Character
	{
		private var _currentPosition:int;
		
		public function General()
		{
			super();
		
		}
		
		public function get currentPosition():int
		{
			return _currentPosition;
		}
		
		public function set currentPosition(value:int):void
		{
			_currentPosition = value;
		}
	
	}

}