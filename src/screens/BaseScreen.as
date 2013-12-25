package screens
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author YopSolo
	 */
	public class BaseScreen extends Sprite
	{
		protected var _view:MovieClip;
		
		protected var _switchTo:Array;
		protected var _screenName:String;
		
		public function BaseScreen( viewReference:MovieClip )
		{
			_view = viewReference;
			_screenName = "BaseScreen";
			_switchTo = new Array("MainMenu")
			start();
		}
		
		protected function start():void
		{
			_view.addEventListener(Event.ADDED_TO_STAGE, onViewReady);
			_view.addEventListener(Event.REMOVED_FROM_STAGE, _onViewRemovedFromStage);
			
			addChild(_view);
		}
		
		protected function onViewReady(e:Event):void
		{
			// things starts here !
		}
		
		public function end():void
		{
			// destroy stuff and remove the view			
			while (_view.numChildren) _view.removeChildAt(0);
			removeChild(_view);
		}
		
		protected function _onViewRemovedFromStage(e:Event):void
		{
			_view.removeEventListener(Event.ADDED_TO_STAGE, onViewReady);
			_view.removeEventListener(Event.REMOVED_FROM_STAGE, _onViewRemovedFromStage);	
		}
		
		public function IsSwitchable(screenName:String):Boolean
		{
			var i:int;
			for (i = 0; i < _switchTo.length ; i++)
			{
				if ( _switchTo[i] == screenName)
				{
					return true;
				}
			}
			return false;
		}
		
		public function get screenName():String 
		{
			return _screenName;
		}
	
	}
}