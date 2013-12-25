package  {
	
	import com.greensock.plugins.TintPlugin;
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	
	public class FadingText_MC extends MovieClip {
		
		private var timer:Timer ;
		public var text_txt:TextField;
		private var text:String;
		
		public function FadingText_MC(t:String , x:int = 0, y:int = 0, color:uint = 0x000000, time:Number = 1) {
			text_txt.text = t;
			this.x = x;
			this.y = y;
			timer = new Timer((time * 1000 / 100), 0);
			text_txt.textColor = color;
			this.addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			this.addEventListener(Event.REMOVED, _onRemoved);
			timer.addEventListener(TimerEvent.TIMER, _update);
		}
		
		private function _onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			timer.start();
		}
		 private function _update(e:TimerEvent):void
		 {
			
			 this.y -= timer.currentCount / 5;
			 this.alpha = timer.currentCount / 50;
			 
			 if(this.alpha <= 0.0)
			 {
				 timer.stop();
				 this.parent.removeChild(this);
			 }
		 }
		 
		 
		 private function _onRemoved(e:Event):void
		 {
			 this.removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			 this.removeEventListener(Event.REMOVED, _onRemoved);
			 timer.removeEventListener(TimerEvent.TIMER, _update);
		 }
		
	}
	
}
