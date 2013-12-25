package displayable 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.greensock.*;
	import com.greensock.easing.*;
	import managers.TextManager;
	/**
	 * ...
	 * @author Olivier
	 */
	public class TurnCounter extends MovieClip 
	{
		private var _view:TurnCounterMC = new TurnCounterMC();
		
		public function TurnCounter() 
		{
			
			_view.turnLine_txt.text = Main.managers.Text.GetText(TextManager.TURN);
			_view.buttonText_txt.text = Main.managers.Text.GetText(TextManager.NEXT_TURN);
			addChild(_view);
			addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
		}
		
		private function _onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			TweenMax.to(_view, 1, {y:  -_view.height, ease:Sine.easeInOut } );
		}
		
		public function out():void
		{
			TweenMax.to(_view, 1, {y:  0, ease:Sine.easeInOut } );
		}
		
		
		public function get view():TurnCounterMC 
		{
			return _view;
		}
		
		public function set view(value:TurnCounterMC):void 
		{
			_view = value;
		}
	}

}