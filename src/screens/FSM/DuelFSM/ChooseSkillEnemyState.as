package screens.FSM.DuelFSM 
{
	import codex.characters.Character;
	import codex.characters.Skill;
	import displayable.ChoiceWheel;
	import displayable.FadingText;
	//import displayable.HUDButton;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	//import flash.events.KeyboardEvent;
	//import flash.events.MouseEvent;
	import flash.text.TextField;
	import screens.FSM.IState;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import events.StateEvent;
	import events.AnimStateEvent;
	import events.ChoiceWheelEvent;
	/**
	 * ...
	 * @author Olivier
	 */
	public class ChooseSkillEnemyState implements IState 
	{
		private var _timeSinceBegin:int;
		private var _parentView:MovieClip;
		
		public var choiceWheel:ChoiceWheel;
		
		public function ChooseSkillEnemyState(parent:MovieClip) 
		{
			_parentView = parent;
		}

		public function Init():void
		{
			
			var skillArray:Array = new Array();
			var iconArray:Array = new Array();
			var i:int;
			for each (var skill:Skill in Main.managers.Duel.enemy.duelSkillArray)
			{
				if (skill.isKnown)
				{
					skillArray.push(skill);
					iconArray.push(new ChoiceWheelIconBlankMC());
				}
			}
			choiceWheel = new ChoiceWheel(iconArray, skillArray);
			choiceWheel.x = 1024 / 2;
			choiceWheel.y = _parentView.height / 2 - 100;
			
			GenerateScreen();
		}
		
		private function GenerateScreen():void
		{

			_parentView.addChild(choiceWheel);
			
			_parentView.addEventListener(ChoiceWheelEvent.SKILL, _onSkillChoosed);
		}
		
		private function _onSkillChoosed(e:ChoiceWheelEvent):void 
		{
			e.stopImmediatePropagation();
			var tmpSkill:Skill = e.returnedObject as Skill;
			_parentView.removeEventListener(ChoiceWheelEvent.SKILL, _onSkillChoosed);
			_parentView.removeChild(choiceWheel);
			Main.managers.Duel.ApplyAction(Main.managers.Duel.general, Main.managers.Duel.enemy, e.returnedObject as Skill/*, new MovieClip()*/);
			
			_parentView.dispatchEvent(new AnimStateEvent(AnimStateEvent.CHANGE, AnimStateEvent.TARGET_ENEMY_GENERAL, 1, true, true));
			
			//Debug line Must be removed
			//trace((e.returnedObject as Skill).name + " launched by enemy, his class is :" + Main.managers.Duel.enemy.archetype.name );
			Main.managers.Duel.lieutenant.removeLife(tmpSkill.multiplicator * Main.managers.Duel.enemy.statsArray[tmpSkill.originStat].finalAmmount);
			if (tmpSkill.hasCost)
			{
				Main.managers.Duel.enemy.removeMana(tmpSkill.cost);
			}
			//_parentView.addChild(new FadingText((Main.managers.Duel.general.vitalsArray[Main.LIFE].curValue).toString(), 200, 200, 5, 12));
			
			_parentView.dispatchEvent(new StateEvent(StateEvent.DESTROYED, true, true));
		}
		
		public function Update(elapsedTime:int):void
		{
			_timeSinceBegin += elapsedTime;
		}
		
		public function End():void
		{
			
		}
		private function _onAnimOver(e:AnimStateEvent):void
		{
			if (e.targetCharacter == AnimStateEvent.TARGET_ENEMY_GENERAL)
			{
				_parentView.dispatchEvent(new StateEvent(StateEvent.DESTROYED, true, true));
				_parentView.removeEventListener(AnimStateEvent.OVER, _onAnimOver);
			}
			
			trace("message broadcasted from GeneralSkill");
		}
	}

}