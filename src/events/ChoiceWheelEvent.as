package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class ChoiceWheelEvent extends Event 
	{
		public static const LIEUTENANT:String = "lieutenant";
		public static const CHARACTER:String = "character";
		public static const SKILL:String = "skill";
		
		public var returnedObject:Object;
		
		public function ChoiceWheelEvent(type:String, obj:Object = null , bubbles:Boolean=true, cancelable:Boolean=true) 
		{
			super(type, bubbles, cancelable);
			returnedObject = obj;
		}
		
	}

}