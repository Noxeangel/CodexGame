package displayable 
{
	import events.ChoiceWheelEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.greensock.TweenMax;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import codex.characters.Character;
	import codex.characters.Skill;
	/**
	 * ...
	 * @author Olivier
	 */
	public class ChoiceWheel extends MovieClip 
	{

		private var _viewBG:ChoiceWheelBgMC = new ChoiceWheelBgMC();
		
		private var _Branches:Array = new Array();
		private var _Icons:Array = new Array();
		private var _Objects:Array = new Array();
		
		private var _icon1:ChoiceWheelIconLt1MC = new ChoiceWheelIconLt1MC();
		private var _icon2:ChoiceWheelIconLt2MC = new ChoiceWheelIconLt2MC();
		private var _icon3:ChoiceWheelIconLt3MC = new ChoiceWheelIconLt3MC();
		
		private var _ray:Number;
		private var _angle:Number;
		private var _tmpAngle:Number;
		private var _animDuration:Number;

		
		public function ChoiceWheel(iconsParam:Array, objectsParam:Array) 
		{
			_angle = 0;
			_animDuration = 1;
			
			if (iconsParam.length != objectsParam.length)
			{
				throw new Error("#Both params Array must have same length", "#0001");
			}
			
			for (var i:int = 0; i < iconsParam.length; i++)
			{
				_Icons.push(iconsParam[i]);
				_Objects.push(objectsParam[i]);
			}
			
			addChild(_viewBG);
			for ( i = 0; i < _Icons.length; i++)
			{
				_Branches.push(new ChoiceWheelBranch(_Icons[i]));
				addChild(_Branches[i]);
				_Branches[i].rotation = (i * (360 / _Icons.length)) % 360;
				_Branches[i].icon.rotation = 360 - (  i * ( 360 / _Icons.length))%360;
				_Branches[i].icon.addEventListener(MouseEvent.CLICK, _onMouseClick);
				_Branches[i].addEventListener(MouseEvent.MOUSE_OVER, _onMouseOver);
				
			}
			
		}
		
		private function _onMouseClick(e:MouseEvent):void 
		{
			for ( var i:int = 0 ; i < _Branches.length ; i++)
			{
				if (e.currentTarget == _Branches[i].icon)
				{
					var s:String;
					switch( Class(getDefinitionByName(getQualifiedClassName(_Objects[i]))))
					{
						case Character:
							s = ChoiceWheelEvent.LIEUTENANT;
							break;
						case Skill:
							s = ChoiceWheelEvent.SKILL;
							break;
						default:
							s = ChoiceWheelEvent.CHARACTER;
							break;
					}
					
					dispatchEvent(new ChoiceWheelEvent(s, _Objects[i]));
				}
			}
		}
		
		private function _onMouseOver(e:MouseEvent):void 
		{
			var i:int = 0;

			_angle += 360 / _Branches.length;

			for ( i = 0; i < _Branches.length; i++)
			{
				_Branches[i].removeEventListener(MouseEvent.MOUSE_OVER, _onMouseOver);
				new TweenMax(_Branches[i], _animDuration, { rotation:( ((360 / _Branches.length) * i +  _angle) % 360),  onComplete:_onRotationComplete } );
				new TweenMax(_Branches[i].icon, _animDuration, { rotation:   -(( ((360 / _Branches.length) * i +  _angle) % 360))} );
			}
			
		}
		
		private function _onRotationComplete(e:Event = null):void
		{
			
			for ( var i:int = 0; i < _Branches.length; i++)
			{
				_Branches[i].addEventListener(MouseEvent.MOUSE_OVER, _onMouseOver);
				
			}

		}

	}

}