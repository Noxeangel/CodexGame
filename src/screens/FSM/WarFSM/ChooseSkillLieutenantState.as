package screens.FSM.WarFSM 
{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	//import screens.FSM.IState;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import events.StateEvent;
	/**
	 * ...
	 * @author Olivier
	 */
	public class ChooseSkillLieutenantState implements IState 
	{
		private var _timeSinceBegin:int;
		private var dispatcher:EventDispatcher;
		private var _view:MovieClip;
		
		public function ChooseSkillLieutenantState(view:MovieClip) 
		{
			_view = view;
		}

		public function Init():void
		{
			dispatcher  = new EventDispatcher();
			trace("ChooseSkillLieutenantState Init");
			_view.addEventListener(MouseEvent.CLICK, _onClicked);
			_parentView.addEventListener(MouseEvent.CLICK, _onClicked);
			_parentView.dispatchEvent(new AnimStateEvent(AnimStateEvent.CHANGE, AnimStateEvent.TARGET_GENERAL, 0, true, true));
			_parentView.dispatchEvent(new AnimStateEvent(AnimStateEvent.CHANGE, AnimStateEvent.TARGET_LIEUTENANT, 0, true, true));
			_parentView.dispatchEvent(new AnimStateEvent(AnimStateEvent.CHANGE, AnimStateEvent.TARGET_ENEMY_GENERAL, 0, true, true));
			GenerateScreen();
		}
		
		private function _onClicked(e:MouseEvent):void 
		{
			
			_view.dispatchEvent(new StateEvent(StateEvent.DESTROYED, true, true));
			trace("message broadcasted");
			
		}

		private function GenerateScreen():void
		{
			
		}
		
		public function Update(elapsedTime:int):void
		{
			_timeSinceBegin += elapsedTime;
			//trace (_timeSinceBegin);
			
			
		}
		
		public function End():void
		{
			_view.removeEventListener(MouseEvent.CLICK, _onClicked);
			trace("ChooseSkillLieutenantState ended");
		}
	}

}