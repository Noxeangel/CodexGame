package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class StateEvent extends Event 
	{
		static public const DESTROYED:String = "stateevents::destroyed";
		public var targetState:String;
		
		public function StateEvent(type:String,  bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
		public override function clone():Event
		{
			return new StateEvent(type, bubbles, cancelable);
		}
		
	}

}