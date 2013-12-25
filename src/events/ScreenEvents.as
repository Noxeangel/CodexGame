package events 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author YopSolo
	 */
	public class ScreenEvents extends Event
	{
		static public const DESTROYED:String = "screenevents::destroyed";
		public var targetScreen:String;
		public function ScreenEvents(type:String, screen:String, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			targetScreen = screen;
		}
		
		
		public override function clone():Event
		{
			return new ScreenEvents(type, targetScreen, bubbles, cancelable);
		}
		
	}

}