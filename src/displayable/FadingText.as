package displayable 
{
	import com.greensock.plugins.TintPlugin;
	import flash.display.MovieClip;
	import flash.text.Font;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import com.greensock.TweenMax;
	/**
	 * ...
	 * @author Olivier
	 */
	public class FadingText extends MovieClip 
	{
		
		public var text_txt:TextField;
		private var text:String;
		private var _time:Number;
		
		public function FadingText(t:String , x:int = 0, y:int = 0, time:Number = 1,fontSize:int = 20, color:uint = 0x000000) 
		{
			_time = time;
			
			var tFormat:TextFormat = new TextFormat();
			tFormat.font = "Viking-Normal";
			tFormat.color = color;
			tFormat.size = fontSize;
			
			text_txt = new TextField();
			text_txt.mouseEnabled = false;
			text_txt.defaultTextFormat = tFormat;
			text_txt.embedFonts = true;
			text_txt.text = t;
			text_txt.autoSize = TextFieldAutoSize.LEFT;

			this.x = x -( text_txt.width / 2);
			this.y = y;

			this.addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			
		}
		
		private function _onAddedToStage(e:Event):void
		{
			this.addChild(text_txt);
			this.removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			this.addEventListener(Event.REMOVED, _onRemoved);
			new TweenMax(text_txt, _time , { alpha:0, y: -50, onComplete:_onComplete } );
		}
		
		private function _onComplete(e:Event = null):void 
		{
			this.parent.removeChild(this);
		}
		
		 
		private function _onRemoved(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			this.removeEventListener(Event.REMOVED, _onRemoved);
		}
		
	}

}