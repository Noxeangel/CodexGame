package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class TalkEvent extends Event 
	{
		static public const NEXT:String = "talkEvent::next";
		static public const END:String = "talkEvent::end";
		
		public function TalkEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=true) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}