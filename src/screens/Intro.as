package screens
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import events.ScreenEvents;
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class Intro extends BaseScreen
	{
		public function Intro()
		{
			super( new IntroMC );
			_switchTo = new Array(	"WorldMap"
											);
			_screenName = "Intro";
		}
		
		// =====================================================================
		public function get view():IntroMC 
		{
			return _view as IntroMC;
		}		
		
		// =====================================================================
		override protected function onViewReady(e:Event):void
		{
			super.onViewReady(e);
			view.addEventListener(MouseEvent.CLICK, _onClickHandler); // [d]
		}
		
		private function _onClickHandler(e:MouseEvent):void
		{
			dispatchEvent(new ScreenEvents(ScreenEvents.DESTROYED,"WorldMap",true,true));
		}
		
		// =====================================================================
		override public function end():void
		{
			_view.removeEventListener(MouseEvent.CLICK, _onClickHandler); // [d]
			super.end();
		}
		
	}

}