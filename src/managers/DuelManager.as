package managers
{
	import codex.characters.BaseStat;
	import codex.characters.Character;
	import codex.characters.General;
	import codex.characters.Skill;
	import codex.characters.Vital;
	import displayable.FadingText;
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


		
		public function ApplyAction(caster:Character, target:Character, skill:Skill, view:MovieClip):void
		{
			Main.managers.SoundM.playSfx(Main.SFX_HEAL);

			if (skill.hasCost)
			{
				caster.removeMana(skill.cost);
			}
			
			var damages:int  = int(skill.multiplicator * (caster.statsArray[skill.originStat] as BaseStat).finalAmmount * (Math.random()+0.5));
			target.removeLife(damages);
			var color:uint = 0xFF0000;
			if (damages < 0)
			{
				damages *= -1;
				color = 0x00FF00;
			}
			var damagesText:FadingText = new FadingText(damages.toString(), target.animationMachine.x, target.animationMachine.y - 100 , 4, 30, color);
			view.addChild(damagesText);
		}
		
		public function calculateInitiativeArray():Array
		{
			var arr:Array = new Array();
			arr.push("general");
			arr.push("lieutenant");
			arr.push("enemy");
			
			return arr;
		}
		
	
	
	}

}