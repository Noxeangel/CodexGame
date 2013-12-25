package screens.FSM.WarFSM 
{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import screens.FSM.IState;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import FSM.StateEvent;
	/**
	 * ...
	 * @author Olivier
	 */
	public class ChooseSkillEnemyState implements IState 
	{
		private var _timeSinceBegin:int;
		private var dispatcher:EventDispatcher;
		private var _view:MovieClip;
		
		public function ChooseSkillEnemyState(view:MovieClip) 
		{
			_view = view;
		}

		public function Init():void
		{
			dispatcher  = new EventDispatcher();
			trace("ChooseSkillEnemyState Init");
			_view.addEventListener(MouseEvent.CLICK,_onClicked);
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
			trace("ChooseSkillEnemyState ended");
		}
	}

}