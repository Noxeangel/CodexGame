package displayable 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import MoveIconMC;
	import com.greensock.*;
	import com.greensock.easing.*;
	import managers.TextManager;
	/**
	 * ...
	 * @author Olivier
	 */
	public class PaperButtonLeft extends MovieClip
	{
		
		private var _view:PaperButtonMC= new PaperButtonMC();
		private var _button:HUDButton;
		//private var _icon:MovieClip;
		private var _xMaxAnimation:int;
		
		private var _isMouseEntering:Boolean = false;
		
		public function PaperButtonLeft() 
		{
			_view.buttonMode = true;
			_view.costLine_txt.text = Main.managers.Text.GetText(TextManager.COST);
			addChild(_view);
			_xMaxAnimation = x + view.width - 110;
			_view.addEventListener(MouseEvent.ROLL_OVER, _onMouseOver);
			_view.addEventListener(MouseEvent.ROLL_OUT, _onMouseOut);
			_view.addEventListener(MouseEvent.CLICK, _onMouseClick);
			_view.mouseChildren = false;
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				EventHandlers
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function _onMouseClick(e:MouseEvent):void 
		{
			_onMouseOut(e);
		}
		
		private function _onMouseOver(e:MouseEvent):void 
		{

			Main.managers.SoundM.playSfx(Main.BIP);
			TweenMax.to(_view, 0.5, { x:_xMaxAnimation , ease:Sine.easeInOut, onComplete:_onMouseOverAnimationFinished } );
		}

		private function _onMouseOverAnimationFinished(e:Event=null):void
		{
		}
		private function _onMouseOut(e:MouseEvent):void 
		{
			TweenMax.to(_view, 0.5, { x: _xMaxAnimation - view.width + 110 , ease:Sine.easeInOut, onComplete:_onMouseOutAnimationFinished } );
			
		}
		private function _onMouseOutAnimationFinished(e:Event=null):void
		{
		}
		public function SetPaperButton(name:String, cost:int = 9999, icon:Class = null):void
		{
			SetButton(name);
			SetCost(cost);
			SetIcon(icon);
		}
		
		public function SetCost(i:int):void
		{
			if ( i != 9999)
			{
				_view.buttonCost_txt.text = i.toString();
			}
			else
			{
				_view.buttonCost_txt.text = "";
				_view.costLine_txt.visible = false;
			}
		}
		
		public function SetButton(s:String):void
		{
			
			_view.buttonName_txt.text = s;
		}
		
		public function SetIcon(c:Class):void
		{
			_view.removeChild(_view.blankIcon_mc);
			_view.blankIcon_mc = new c();
			_view.blankIcon_mc.x = 21;
			_view.blankIcon_mc.y = 2;
			_view.blankIcon_mc.width = 70;
			_view.blankIcon_mc.height = 70;
			_view.addChild(_view.blankIcon_mc);
		}
		
		public function get view():PaperButtonMC 
		{
			return _view;
		}
		
		public function set view(value:PaperButtonMC):void 
		{
			_view = value;
		}
		
		//private var forCompiler101:MoveIconMC;
		
	}

}