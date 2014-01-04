package displayable 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.greensock.*;
	import com.greensock.easing.*;
	import Date;
	/**
	 * ...
	 * @author Olivier
	 */
	public class Console extends MovieClip
	{
		
		private var _view:Console_Field = new Console_Field();
		private var date:Date = new Date();
		
		public function Console() 
		{
			_view.mouseEnabled = false;
			_view.mouseChildren = false;
			addChild(_view);
			_view.console_txt.text = "";
			_view.console_txt.scrollV = -1;
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
		
		public function DisplayOnConsole(line:String):void
		{
			date = new Date();
			_view.console_txt.text += new String(date.toTimeString().slice(0 ,date.toTimeString().length - 8 ));
			_view.console_txt.text += "| ";
			_view.console_txt.text += line;
			_view.console_txt.text += " \n";
			_view.console_txt.scrollV += 1;
		}
		
		public function ClearConsole():void
		{
			_view.console_txt.text = "";
			_view.console_txt.scrollV = 0;
		}
		
		public function get view():Console_Field 
		{
			return _view;
		}
		
	}

}