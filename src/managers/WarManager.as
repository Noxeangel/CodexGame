package managers 
{
	import codex.characters.Character;
	import flash.display.MovieClip;

	/**
	 * ...
	 * @author Olivier
	 */
	public class WarManager  extends MovieClip
	{

		public static const PHYSICAL_ATTACK:int = 0;
		public static const MAGICAL_ATTACK:int = 1;
		public static const TALK_TROOPS:int = 2;
		public static const HEAL_TROOPS:int = 3;
		public static const KILL_GENERAL:int = 4;
		public static const MAGIC:int = 5;
		
		public function WarManager() 
		{
			
		}
		
		public function Init():void
		{
		}

		public function ApplyAction(caster:Character , target:Character, action:int, currentView:MovieClip):void
		{
			switch (action)
			{
				case PHYSICAL_ATTACK:
					
					break;
				case MAGICAL_ATTACK:
					
					break;
				case TALK_TROOPS:
					
					break;
				case HEAL_TROOPS:
					
					break;
				case KILL_GENERAL:
					
					break;
				case MAGIC:
					
					break;
				default:
					throw new Error("WarManager.ApplyAction requires a legal int as parameter for action. Use the following syntax as exemple WarManager.PHYSICAL_ATTACK", "#0001")
					break;
			}
		}
		
		public function calculateInitiativeArray(view:MovieClip):Array 
		{
			var arr:Array;
			//Must return an array of IState with the States objects already in it
			//The first state must be :  choose army type
			return arr;
		}
		
	}

}