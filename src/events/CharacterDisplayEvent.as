package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class CharacterDisplayEvent extends Event 
	{
		public static const DISPLAY:String = "display";
		public static const HIDE:String = "hide";
		
		public var posX:Number;
		public var posY:Number;
		
		public function CharacterDisplayEvent(type:String, x:Number = 0, y:Number = 0, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			posX = x;
			posY = y;
		}
		
	}

}