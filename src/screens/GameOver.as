package screens
{
	import events.ScreenEvents;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class GameOver extends BaseScreen
	{
		
		public function GameOver()
		{
			super( new GameOverMC );
			_switchTo = new Array(	"MainMenu"
											);
			_screenName = "GameOver";
		}
		
		// =====================================================================
		public function get view():MainMenuMC 
		{
			return _view as MainMenuMC;
		}			
		
		// =====================================================================
		override protected function onViewReady(e:Event):void
		{
			view.addEventListener(MouseEvent.CLICK, _onClickHandler); 
		}
		
		private function _onClickHandler(e:MouseEvent):void
		{
			dispatchEvent(new ScreenEvents(ScreenEvents.DESTROYED, "MainMenu", false, false));
		}
		
		// =====================================================================
		override public function end():void
		{
			view.removeEventListener(MouseEvent.CLICK, _onClickHandler);
			super.end();
		}
	}

}