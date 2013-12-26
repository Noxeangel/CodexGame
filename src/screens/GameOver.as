package screens
{
	import displayable.PaperButtonLeft;
	import events.ScreenEvents;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class GameOver extends BaseScreen
	{
		
		public var mainMenuButton:PaperButtonLeft;
		
		public function GameOver()
		{
			super( new GameOverMC );
			_switchTo = new Array(	"MainMenu"
											);
			_screenName = "GameOver";
		}
		
		// =====================================================================
		public function get view():GameOverMC 
		{
			return _view as GameOverMC;
		}			
		
		// =====================================================================
		override protected function onViewReady(e:Event):void
		{
			Main.managers.Init();
			
			mainMenuButton = new PaperButtonLeft();
			mainMenuButton.x = 0;
			mainMenuButton.y = 30;
			mainMenuButton.SetPaperButton("Menu",9999,MoveIconMC);
			mainMenuButton.addEventListener(MouseEvent.CLICK, _onClickHandler);
			view.addChild(mainMenuButton);
			//view.addEventListener(MouseEvent.CLICK, _onClickHandler); 
		}
		
		private function _onClickHandler(e:MouseEvent):void
		{
			dispatchEvent(new ScreenEvents(ScreenEvents.DESTROYED, "MainMenu", true, true));
		}
		
		// =====================================================================
		override public function end():void
		{
			view.removeEventListener(MouseEvent.CLICK, _onClickHandler);
			super.end();
		}
	}

}