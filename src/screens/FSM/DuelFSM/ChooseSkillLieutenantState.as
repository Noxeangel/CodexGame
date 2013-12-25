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
	import managers.DuelManager;
	/**
	 * ...
	 * @author Olivier
	 */
	public class ChooseSkillLieutenantState extends MovieClip implements IState 
	{
		private var _timeSinceBegin:int;
		private var _parentView:MovieClip;
		
		public var choiceWheelSkillLT:ChoiceWheel;
		
		public function ChooseSkillLieutenantState(parent:MovieClip) 
		{
			_parentView = parent;
		}

		public function Init():void
		{
			
			
			var skillArray:Array = new Array();
			var iconArray:Array = new Array();
			var i:int;
			
			for each (var skill:Skill in  Main.managers.Duel.lieutenant.duelSkillArray)
			{
				if (skill.isKnown)
				{
					skillArray.push(skill);
					iconArray.push(new ChoiceWheelIconBlankMC());
				}
			}
			choiceWheelSkillLT = new ChoiceWheel(iconArray, skillArray);
			
			choiceWheelSkillLT.x = 1024 / 2;
			choiceWheelSkillLT.y = _parentView.height / 2 - 100;

			
			if (Main.managers.Duel.lieutenant.isDead)
			{
				End();
			}else
			{
				GenerateScreen();
			}
			
		}
		
		private function GenerateScreen():void
		{

			_parentView.addChild(choiceWheelSkillLT);
			//trace("Choose your Skill Lieutenant");
			_parentView.addEventListener(ChoiceWheelEvent.SKILL, _onSkillChoosed);
		}
		
		private function _onSkillChoosed(e:ChoiceWheelEvent):void 
		{
			e.stopImmediatePropagation();
			var tmpSkill:Skill = e.returnedObject as Skill;
			_parentView.removeEventListener(ChoiceWheelEvent.SKILL, _onSkillChoosed);
			_parentView.removeChild(choiceWheelSkillLT);
			Main.managers.Duel.ApplyAction(Main.managers.Duel.lieutenant, new Character(), e.returnedObject as Skill/*, new MovieClip()*/);
			
			_parentView.dispatchEvent(new AnimStateEvent(AnimStateEvent.CHANGE, AnimStateEvent.TARGET_LIEUTENANT, 1, true, true));
			//trace((e.returnedObject as Skill).name + " launched by lieutenant, his class is :" + Main.managers.Duel.lieutenant.archetype.name );
			//Debug line Must be removed
			Main.managers.Duel.enemy.removeLife(tmpSkill.multiplicator * Main.managers.Duel.lieutenant.statsArray[tmpSkill.originStat].finalAmmount);
			if (tmpSkill.hasCost)
			{
				Main.managers.Duel.lieutenant.removeMana(tmpSkill.cost);
			}
			_parentView.addChild(new FadingText((Main.managers.Duel.general.vitalsArray[Main.LIFE].curValue).toString(), 200, 200, 5, 12));
			
			End();
		}
		
		public function Update(elapsedTime:int):void
		{
			//_timeSinceBegin += elapsedTime;
		}
		
		public function End():void
		{
			_parentView.dispatchEvent(new StateEvent(StateEvent.DESTROYED, true, true));
		}
		
		
		private function _onAnimOver(e:AnimStateEvent):void
		{
			if (e.targetCharacter == AnimStateEvent.TARGET_LIEUTENANT)
			{
				_parentView.dispatchEvent(new StateEvent(StateEvent.DESTROYED, true, true));
				//_parentView.removeEventListener(AnimStateEvent.OVER, _onAnimOver);
			}
			
			trace("message broadcasted from GeneralSkill");
		}
	}

}