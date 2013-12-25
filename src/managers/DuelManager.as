package managers
{
	import codex.characters.Character;
	import codex.characters.General;
	import codex.characters.Skill;
	import flash.display.MovieClip;
	import screens.FSM.DuelFSM.ChooseLieutenantState;
	import screens.FSM.DuelFSM.ChooseSkillEnemyState;
	import screens.FSM.DuelFSM.ChooseSkillGeneralState;
	import screens.FSM.DuelFSM.ChooseSkillLieutenantState;
	import flash.events.EventDispatcher;
	import events.ManagerEvent;
	/**
	 * ...
	 * @author Olivier
	 * @usage created once in the Global Manager singleton class
	 */
	public class DuelManager extends MovieClip
	{
		private var dispatcher:EventDispatcher = new EventDispatcher();
		
		public static const PHYSICAL_ATTACK:int = 0;
		public static const MAGICAL_ATTACK:int = 1;
		public static const SPECIAL_TECHNIQUE:int = 2;
		public static const USE_OBJECT:int = 3;
		public static const HEAL:int = 4;
		public static const PROTECT:int = 5;
		public static const MAGIC:int = 6;
		
		public var general:General;
		public var lieutenant:Character;
		public var enemy:General = new General();
		
		public function DuelManager()
		{
		
		}
		
		public function Init():void
		{
		}

		public function InitDuel():void
		{
			general = Main.managers.Character.hero;
			//general.Trace();
			lieutenant = new Character();
			
			if ( Main.managers.Character.returnGeneralFromLevel(Main.managers.Level.getIDByIndex(Main.managers.Level.currentLocation)) != null)
			{
				enemy = Main.managers.Character.returnGeneralFromLevel(Main.managers.Level.getIDByIndex(Main.managers.Level.currentLocation));
			}
			else
			{
				throw new Error("No ennemy in this level, consult Enemies.XML for more details");
			}
		}
		
		public function ApplyAction(caster:Character, target:Character, skill:Skill):void
		{
			
		}
		
		public function calculateInitiativeArray(view:MovieClip = null):Array
		{
			var arr:Array = new Array();
			arr.push(new ChooseSkillGeneralState(view));
			arr.push(new ChooseSkillLieutenantState(view));
			arr.push(new ChooseSkillEnemyState(view));
			//Must return an array of IState with the States objects already in it
			return arr;
		}
		
	
	
	}

}