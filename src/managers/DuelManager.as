package managers
{
	import codex.characters.BaseStat;
	import codex.characters.Character;
	import codex.characters.General;
	import codex.characters.Skill;
	import codex.characters.Vital;
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

		public function DuelManager()
		{
		
		}
		
		public function Init():void
		{
		}


		
		public function ApplyAction(caster:Character, target:Character, skill:Skill):void
		{
			if (skill.hasCost)
			{
				caster.removeMana(skill.cost);
			}
			target.removeLife(skill.multiplicator * (caster.statsArray[skill.originStat] as BaseStat).finalAmmount - (target.statsArray[Main.CONSTITUTION] as BaseStat).finalAmmount);
		}
		
		public function calculateInitiativeArray(view:MovieClip = null):Array
		{
			var arr:Array = new Array();
			arr.push(new ChooseSkillGeneralState());
			arr.push(new ChooseSkillLieutenantState());
			arr.push(new ChooseSkillEnemyState());
			//Must return an array of IState with the States objects already in it
			return arr;
		}
		
	
	
	}

}