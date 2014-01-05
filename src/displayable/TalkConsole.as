package displayable 
{
	import events.TalkEvent;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class TalkConsole extends MovieClip 
	{
		private const BASIC_DURATION:Number = 5.0;
		
		private var timer:Timer;
		private var tmpText:String;
		private var currentIndex:int;
		private var totalText:String;
		public var view:TalkConsoleMC;
		private var _noClick:Boolean = true;
		public function TalkConsole() 
		{
			view = new TalkConsoleMC();
			addChild(view);
			view.console_txt.mouseEnabled = false;
		}
		
		public function Init(text:String, duration:Number = BASIC_DURATION, isSkippable:Boolean = true ,left:String = "", right:String = ""):void
		{
			totalText = text;
			_noClick = true;
			timer = new Timer((duration * 1000) / text.length, text.length);
			timer.addEventListener(TimerEvent.TIMER, _onUpdate);
			
			view.leftTalker_txt.text = left;
			view.rightTalker_txt.text = right;
			
			if (isSkippable)
			{
				view.addEventListener(MouseEvent.CLICK, _onClicked);
			}
		}
		
		public function Start():void
		{
			tmpText = "";
			currentIndex = 0;
			timer.start();
		}
		
		private function _onClicked(e:MouseEvent):void 
		{
			End();
			if (_noClick)
			{
				_noClick = false;
			}
			else
			{
				view.removeEventListener(MouseEvent.CLICK, _onClicked);
				this.dispatchEvent(new TalkEvent(TalkEvent.NEXT));
			}
			
		}
		
		
		private function _onUpdate(e:TimerEvent):void 
		{
			if (currentIndex == totalText.length - 1)
			{
				End();
			}
			else
			{
				tmpText += new String(totalText.charAt(currentIndex));
				displayText(tmpText);
				currentIndex ++;
			}
			
		}
		
		private function displayText(text:String):void
		{
			view.console_txt.text = text;
			Main.managers.SoundM.playSfx(Main.SFX_OK);
		}
		
		public function End():void
		{
			
			timer.removeEventListener(TimerEvent.TIMER, _onUpdate);
			
			timer.stop();
			tmpText = totalText;
			displayText(tmpText);
			
		}
		
	}
	
	

}
