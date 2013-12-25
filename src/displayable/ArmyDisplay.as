package displayable 
{
	import codex.armies.Army;
	import codex.armies.ArmyCorp;
	import flash.display.MovieClip;
	import ArmyDisplayMC;
	import flash.events.MouseEvent;
	import com.greensock.*;
	import com.greensock.easing.*;
	/**
	 * ...
	 * @author Olivier
	 */
	public class ArmyDisplay extends MovieClip 
	{
		private var _view:ArmyDisplayMC ;
		//private var _icon:MovieClip = new MovieClip();
		private var _armyName:String;
		
		private var _armyMaxNumber:int;
		private var _armyCurrentNumber:int;
		
		private var _xMaxAnimation:int;
		
		private var _isMouseEntering:Boolean = false;
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Constructor
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function ArmyDisplay(x:int, y:int) 
		{
			view = new ArmyDisplayMC();
			view.x = x;
			view.y = y;
			_xMaxAnimation = x - view.width + 110;
			//view.scaleX = view.scaleY = 0.7;
			addChild(view);
			addEventListener(MouseEvent.MOUSE_OVER, _onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, _onMouseOut);
			_view.mouseChildren = false;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				EventHandlers
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function _onMouseOver(e:MouseEvent):void 
		{
			if (!_isMouseEntering)
			{
				TweenMax.to(view, 0.5, { x:_xMaxAnimation , ease:Sine.easeInOut } );
				Main.managers.SoundM.playSfx(Main.BIP);
				_isMouseEntering = true;
			}
			
		}
		private function _onMouseOut(e:MouseEvent):void 
		{
			_isMouseEntering = false;
			TweenMax.to(view, 0.5, { x: _xMaxAnimation + view.width - 110 , ease:Sine.easeInOut } );
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Getters Setters
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function get view():ArmyDisplayMC 
		{
			return _view;
		}
		
		public function set view(value:ArmyDisplayMC):void 
		{
			_view = value;
		}
		/*
		public function get icon():MovieClip 
		{
			return _icon;
		}
		
		public function set icon(value:MovieClip):void 
		{
			_icon = value;
		}
		*/
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Custom Functions
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function DisplayIcon(c:Class):void
		{
			view.removeChild(view.blankIcon_mc);
			view.blankIcon_mc = new c();
			view.blankIcon_mc.x = -102;
			view.blankIcon_mc.y = -1;
			view.blankIcon_mc.width = 100;
			view.blankIcon_mc.height = 100;
			view.addChild(view.blankIcon_mc);
		}
		
		public function Update(army:ArmyCorp):void
		{
			if (view.armyName_txt != null)
			{
				view.armyName_txt.text = army.name;
			}
			
			var tmp:String;
			tmp = army.currentNumber.toString() + "/" + army.maxNumber.toString();
			if (view.armyField_txt != null)
			{
				view.armyField_txt.text = tmp;
			}
			
			AdjustEffectBar(army.maxNumber, army.currentNumber);
		}
		public function AdjustEffectBar(maxRange:int, currentRange:int):void
		{
			view.armyBar_mc.bar_core_mc.scaleX = currentRange / maxRange;
		}
		
	}

}