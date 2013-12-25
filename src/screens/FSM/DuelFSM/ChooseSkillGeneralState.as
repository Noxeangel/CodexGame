package screens.FSM.DuelFSM
{
	import codex.characters.Character;
	import codex.characters.Skill;
	import displayable.ChoiceWheel;
	import displayable.FadingText;
	import screens.Duel;

	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;

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
	public class ChooseSkillGeneralState extends MovieClip implements IState
	{
		private var _timeSinceBegin:int;
		private var _parentView:MovieClip;
		
		public var choiceWheel:ChoiceWheel;
		
		public function ChooseSkillGeneralState(parent:MovieClip)
		{
			_parentView = parent;
		}
		
		public function Init():void
		{
			var skillArray:Array = new Array();
			var iconArray:Array = new Array();
			var i:int;
			for each (var skill:Skill in  Main.managers.Duel.general.duelSkillArray)
			{
				if (skill.isKnown)
				{
					skillArray.push(skill);
					iconArray.push(new ChoiceWheelIconBlankMC());
				}
			}
			choiceWheel = new ChoiceWheel(iconArray, skillArray);
			iconArray.length = 0;
			skillArray.length = 0;
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
			_parentView.removeEventListener(ChoiceWheelEvent.SKILL, _onSkillChoosed);
			_parentView.removeChild(choiceWheel);
			var tmpSkill:Skill = e.returnedObject as Skill;
			//Main.managers.Duel.ApplyAction(Main.managers.Duel.general, Main.managers.Duel.enemy, e.returnedObject as Skill, _parentView);
			
			Main.managers.Duel.enemy.removeLife(tmpSkill.multiplicator * Main.managers.Duel.general.statsArray[tmpSkill.originStat].finalAmmount);
			if (tmpSkill.hasCost)
			{
				Main.managers.Duel.general.removeMana(tmpSkill.cost);
			}
			_parentView.addChild(new FadingText((Main.managers.Duel.general.vitalsArray[Main.LIFE].curValue).toString(), 200, 200, 5, 12));
			//_parentView.addChildAt((e.returnedObject as Skill).effectAnim, _parentView.numChildren);
			
			_parentView.dispatchEvent(new AnimStateEvent(AnimStateEvent.CHANGE, AnimStateEvent.TARGET_GENERAL, 1, true, true));
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
			if (e.targetCharacter == AnimStateEvent.TARGET_GENERAL)
			{
				_parentView.removeEventListener(AnimStateEvent.OVER, _onAnimOver);
				//_parentView.dispatchEvent(new StateEvent(StateEvent.DESTROYED, true, true));
				
			}
			_parentView.addChild(new FadingText("message broadcasted from GeneralSkill", choiceWheel.x, choiceWheel.y - choiceWheel.height / 2,2,18,0x000000));
			trace("message broadcasted from GeneralSkill");
		}
	}

}