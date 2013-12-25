package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class AnimStateEvent extends Event 
	{
		
		static public const CHANGE:String = "anim_change";
		static public const OVER:String = "anim_over";
		
		static public const TARGET_GENERAL:int = 0;
		static public const TARGET_LIEUTENANT:int = 1;
		static public const TARGET_ALLY_ARMY:int = 2;
		static public const TARGET_ENEMY_GENERAL:int = 3;
		static public const TARGET_ENEMY_ARMY:int = 4;
		
		public var targetCharacter:int;
		public var switchToAnim:int;
		
		
		public function AnimStateEvent(type:String,targ:int, anim:int, bubbles:Boolean=true, cancelable:Boolean=true) 
		{
			super(type, bubbles, cancelable);
			targetCharacter = targ;
			switchToAnim = anim;
		}
		
	}

}