package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class ManagerEvent extends Event 
	{
		public static const LOADING_COMPLETE:String = "loading_complete";
		
		public var _dispatcher:Class;
		
		public function ManagerEvent(type:String, dispatcher:Class, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			_dispatcher = dispatcher;
			super(type, bubbles, cancelable);
			
		}
		
	}

}