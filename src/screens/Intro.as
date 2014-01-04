package screens
{
	import displayable.PaperButtonLeft;
	import displayable.TalkConsole;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import events.ScreenEvents;
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class Intro extends BaseScreen
	{
		public var skipAll_btn:PaperButtonLeft;
		public var skip_btn:PaperButtonLeft;
		
		
		
		public function Intro()
		{
			super( new IntroMC );
			_switchTo = new Array(	"WorldMap"
											);
			_screenName = "Intro";
		}
		
		// =====================================================================
		public function get view():IntroMC 
		{
			return _view as IntroMC;
		}		
		
		// =====================================================================
		override protected function onViewReady(e:Event):void
		{
			super.onViewReady(e);
			view.gotoAndStop(1);
			Init();
		}
		
		private function Init():void
		{
			
			
			skip_btn = new PaperButtonLeft();
			skip_btn.SetPaperButton("Skip Sequence",9999,MoveIconMC);
			skip_btn.x = 0;
			skip_btn.y = stage.stageHeight - skip_btn.height * 2;
			
			skipAll_btn = new PaperButtonLeft();
			skipAll_btn.SetPaperButton("Skip All Intro",9999,MoveIconMC);
			skipAll_btn.x = 0;
			skipAll_btn.y = stage.stageHeight - skipAll_btn.height ;
			view.addEventListener(Event.FRAME_CONSTRUCTED, GenerateScreen );
			
			skip_btn.addEventListener(MouseEvent.CLICK, _onClickHandler); // [d]
			skipAll_btn.addEventListener(MouseEvent.CLICK, _onClickHandler); // [d]
			
			GenerateScreen();
		}
		
	
		private function GenerateScreen(e:Event = null):void
		{
			view.addChild(skip_btn);
			view.addChild(skipAll_btn);
			
			
			
		}
		
		private function _onClickHandler(e:MouseEvent):void
		{
			
			switch(e.currentTarget)
			{
				case  skip_btn:
					Main.managers.SoundM.playSfx(Main.SFX_SELECT);
					if (view.currentFrame < view.totalFrames)
					{
						view.gotoAndStop(view.currentFrame + 1);
					}
					else
					{
						dispatchEvent(new ScreenEvents(ScreenEvents.DESTROYED,"WorldMap",true,true));
					}
					break;
				case skipAll_btn:
					Main.managers.SoundM.playSfx(Main.SFX_SELECT);
					dispatchEvent(new ScreenEvents(ScreenEvents.DESTROYED, "WorldMap", true, true));
					break;
			}
		}
		
		// =====================================================================
		override public function end():void
		{
			_view.removeEventListener(MouseEvent.CLICK, _onClickHandler); // [d]
			super.end();
		}
		
	}

}