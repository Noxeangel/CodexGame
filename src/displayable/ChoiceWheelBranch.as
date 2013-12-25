package displayable 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author Olivier
	 */
	public class ChoiceWheelBranch extends MovieClip
	{
		private var _view:ChoiceWheelBranchMC = new ChoiceWheelBranchMC();
		private var _icon:MovieClip;
		
		public function ChoiceWheelBranch(icon:MovieClip) 
		{
			_icon = icon as MovieClip;
			addChild(_view);
			icon.x = _view.icon_mc.x;
			icon.y = _view.icon_mc.y;
			_view.addChild(_icon);
			
			
			addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
		}
		
		private function _onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			
		}
		
		public function get view():ChoiceWheelBranchMC 
		{
			return _view;
		}
		
		public function set view(value:ChoiceWheelBranchMC):void 
		{
			_view = value;
		}
		
		public function get icon():MovieClip 
		{
			return _icon;
		}
		
		public function set icon(value:MovieClip):void 
		{
			_icon = value;
		}
		
	}

}