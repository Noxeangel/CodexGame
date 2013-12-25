package screens.FSM.DuelFSM 
{
	import codex.characters.Character;
	import displayable.CharacterDisplay;
	import displayable.ChoiceWheel;
	import displayable.FadingText;
	import displayable.HUDButton;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import screens.FSM.IState;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import events.StateEvent;
	import events.ChoiceWheelEvent;
	/**
	 * ...
	 * @author Olivier
	 */
	public class ChooseLieutenantState extends MovieClip implements IState 
	{
		private var _timeSinceBegin:int;
		
		public var _parentView:MovieClip;
		
		
		//public var _choiceWheel:ChoiceWheel ;
		public var _ltChooser:LtChooserMC;
		
		public function ChooseLieutenantState(parent:MovieClip) 
		{
			//trace("Choose Lieutenant State Constructor");
			_parentView = parent;
			this.x = 0;
			this.y = 0;
			this.width = 1024;
			this.height = 768;
			
		}

		public function Init():void
		{
			
			//_choiceWheel = new ChoiceWheel(new Array(new ChoiceWheelIconLt1MC(),new ChoiceWheelIconLt2MC(),new ChoiceWheelIconLt3MC()),new Array(Main.managers.Character.lt1,Main.managers.Character.lt2,Main.managers.Character.lt3));
			//_choiceWheel.x = _parentView.width / 2;
			//_choiceWheel.y = _parentView.height / 2 - 100;
			_ltChooser = new LtChooserMC();
			_ltChooser.x = 612;
			_ltChooser.y = 200;
			_parentView.addEventListener(MouseEvent.CLICK, _onLtChoosed);
			
			GenerateScreen();
		}
		
		private function GenerateScreen():void
		{

			//_parentView.addChild(_choiceWheel);
			//this.addChild(_ltChooser);
			_parentView.addChild(_ltChooser);
			//_parentView.addEventListener(ChoiceWheelEvent.LIEUTENANT, _onLtChoosed);
		}
		
		private function _onLtChoosed(e:/*ChoiceWheelEvent*/MouseEvent):void 
		{
			/*
			e.stopImmediatePropagation();
			Main.managers.Duel.lieutenant = e.returnedObject as Character;
			Main.managers.Duel.lieutenant.SetSkillKnown();
			//Main.managers.Duel.general.Trace();
			//Main.managers.Duel.lieutenant.Trace();
			//Main.managers.Duel.enemy.Trace();
			*/
			
			switch(e.target)
			{
				case (_ltChooser.lt1Icon_mc):
					Main.managers.Duel.lieutenant = Main.managers.Character.lt1;
					Main.managers.Duel.lieutenant.SetSkillKnown();
					_parentView.removeChild(_ltChooser);
					End();
					break;
				case (_ltChooser.lt2Icon_mc):
					Main.managers.Duel.lieutenant = Main.managers.Character.lt2;
					Main.managers.Duel.lieutenant.SetSkillKnown();
					_parentView.removeChild(_ltChooser);
					End();
					break;
				case (_ltChooser.lt3Icon_mc):
					Main.managers.Duel.lieutenant = Main.managers.Character.lt3;
					Main.managers.Duel.lieutenant.SetSkillKnown();
					_parentView.removeChild(_ltChooser);
					End();
					break;
			}
			
			//_parentView.addChild(new FadingText((e.returnedObject as Character).archetype.name, _choiceWheel.x, _choiceWheel.y - _choiceWheel.height / 2,2,18,0x000000));
			/*_parentView.*/
			//trace((e.returnedObject as Character).archetype.name + " choosed");
		}

		public function Update(elapsedTime:int):void
		{
			_timeSinceBegin += elapsedTime;
		}
		
		public function End():void
		{
			
			//_parentView.removeEventListener(ChoiceWheelEvent.LIEUTENANT, _onLtChoosed);
			//_parentView.removeChild(_choiceWheel);
			_parentView.removeEventListener(MouseEvent.CLICK, _onLtChoosed);
			
			_parentView.dispatchEvent(new StateEvent(StateEvent.DESTROYED, true, true));
			//removeChild(_ltChooser);
		}
	}

}