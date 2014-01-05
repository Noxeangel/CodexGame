package codex.talk 
{
	/**
	 * ...
	 * @author Olivier
	 */
	public class DialogLine 
	{
		private var _rightTalkerName:String;
		private var _rightTalkerMood:int;
		private var _rightTalkerPortrait:int;
		
		private var _leftTalkerName:String;
		private var _leftTalkerMood:int;
		private var _leftTalkerPortrait:int;
		
		private var _dialog:String;
		private var _isLeftTalkerTalk:Boolean;
		private var _isSkippable:Boolean;
		
		private var _background:int;
		
		public function DialogLine() 
		{
			
		}
		
		public function get rightTalkerName():String 
		{
			return _rightTalkerName;
		}
		
		public function set rightTalkerName(value:String):void 
		{
			_rightTalkerName = value;
		}
		
		public function get rightTalkerMood():int 
		{
			return _rightTalkerMood;
		}
		
		public function set rightTalkerMood(value:int):void 
		{
			_rightTalkerMood = value;
		}
		
		public function get rightTalkerPortrait():int 
		{
			return _rightTalkerPortrait;
		}
		
		public function set rightTalkerPortrait(value:int):void 
		{
			_rightTalkerPortrait = value;
		}
		
		public function get leftTalkerName():String 
		{
			return _leftTalkerName;
		}
		
		public function set leftTalkerName(value:String):void 
		{
			_leftTalkerName = value;
		}
		
		public function get leftTalkerMood():int 
		{
			return _leftTalkerMood;
		}
		
		public function set leftTalkerMood(value:int):void 
		{
			_leftTalkerMood = value;
		}
		
		public function get leftTalkerPortrait():int 
		{
			return _leftTalkerPortrait;
		}
		
		public function set leftTalkerPortrait(value:int):void 
		{
			_leftTalkerPortrait = value;
		}
		
		public function get dialog():String 
		{
			return _dialog;
		}
		
		public function set dialog(value:String):void 
		{
			_dialog = value;
		}
		
		public function get isLeftTalkerTalk():Boolean 
		{
			return _isLeftTalkerTalk;
		}
		
		public function set isLeftTalkerTalk(value:Boolean):void 
		{
			_isLeftTalkerTalk = value;
		}
		
		public function get isSkippable():Boolean 
		{
			return _isSkippable;
		}
		
		public function set isSkippable(value:Boolean):void 
		{
			_isSkippable = value;
		}
		
		public function get background():int 
		{
			return _background;
		}
		
		public function set background(value:int):void 
		{
			_background = value;
		}
		
	}

}