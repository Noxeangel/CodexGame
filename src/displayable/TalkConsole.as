package displayable 
{
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
		
		public function TalkConsole() 
		{
			view = new TalkConsoleMC();
			addChild(view);
			view.console_txt.mouseEnabled = false;
		}
		
		public function Init(text:String, duration:Number = BASIC_DURATION, isSkippable:Boolean = true):void
		{
			totalText = text;
			
			timer = new Timer((duration * 1000) / text.length, text.length);
			timer.addEventListener(TimerEvent.TIMER, _onUpdate);
			
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
		}
		
		
		private function _onUpdate(e:TimerEvent):void 
		{
			if (currentIndex == totalText.length - 1)
			{
				timer.removeEventListener(TimerEvent.TIMER, _onUpdate);
				view.removeEventListener(MouseEvent.CLICK, _onClicked);
				timer.stop();
			}
			tmpText += new String(totalText.charAt(currentIndex));
			displayText(tmpText);
			currentIndex ++;
		}
		
		private function displayText(text:String):void
		{
			view.console_txt.text = text;
			Main.managers.SoundM.playSfx(Main.SFX_OK);
		}
		
		public function End():void
		{
			timer.removeEventListener(TimerEvent.TIMER, _onUpdate);
			view.removeEventListener(MouseEvent.CLICK, _onClicked);
			timer.stop();
			tmpText = totalText;
			displayText(tmpText);
		}
		
	}
	
	

}
