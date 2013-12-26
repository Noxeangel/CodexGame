package screens 
{
	import displayable.HUDButton;
	import displayable.OptionWindow;
	import displayable.PaperButtonLeft;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import MainMenuMC;
	import flash.display.MovieClip;
	import flash.system.fscommand;
	import managers.TextManager;
	import events.ScreenEvents;
	/**
	 * ...
	 * @author Olivier
	 */
	public class MainMenu extends BaseScreen 
	{
		
		public var play_btn:PaperButtonLeft;
		public var load_btn:PaperButtonLeft;
		public var options_btn:PaperButtonLeft;
		public var quit_btn:PaperButtonLeft;
		
		public var option_win:OptionWindow;
		
		public function MainMenu() 
		{
			super(new MainMenuMC);
			_switchTo = new Array(	"Intro",
									"GameOver",
									"WorldMap",
									"MainMenu"
											);
			_screenName = "MainMenu";
									
		}
		
		// =====================================================================
		public function get view():MainMenuMC 
		{
			return _view as MainMenuMC;
		}		
		
		// =====================================================================
		override protected function onViewReady(e:flash.events.Event):void
		{
			super.onViewReady(e);
			Init();
		}
		
		private function Init():void
		{
			Main.managers.Item.ChangeLanguageFunction();
			
			option_win = new OptionWindow();
			option_win.x = 200;
			option_win.y = 200;
			
			play_btn = new PaperButtonLeft();
			load_btn = new PaperButtonLeft();
			options_btn = new PaperButtonLeft();
			quit_btn = new PaperButtonLeft();
			
			play_btn.x = 0;
			play_btn.y = 30;
			play_btn.SetPaperButton(Main.managers.Text.GetText(TextManager.PLAY),9999,MoveIconMC);
			play_btn.addEventListener(MouseEvent.CLICK, _onClickHandler);
			
			load_btn.x = 0;
			load_btn.y = 110;
			load_btn.SetPaperButton(Main.managers.Text.GetText(TextManager.LOAD),9999,PropagandaIconMC);
			load_btn.addEventListener(MouseEvent.CLICK, _onClickHandler);
			
			options_btn.x = 0;
			options_btn.y = 190;
			options_btn.SetPaperButton(Main.managers.Text.GetText(TextManager.OPTIONS),9999,MenuIconMC);
			options_btn.addEventListener(MouseEvent.CLICK, _onClickHandler);
			
			quit_btn.x = 0;
			quit_btn.y = 270;
			quit_btn.SetPaperButton(Main.managers.Text.GetText(TextManager.QUIT),9999,MoveIconMC);
			quit_btn.addEventListener(MouseEvent.CLICK, _onClickHandler);
			
			Main.managers.SoundM.playBGM(Main.BGM_MAIN_MENU);
			
			GenerateScreen();
		}
		
		private function GenerateScreen():void
		{
			view.addChild(play_btn);
			view.addChild(load_btn);
			view.addChild(options_btn);
			view.addChild(quit_btn);
			
			view.addChild(option_win);
			option_win.visible = false;
		}
		
		private function _onClickHandler(e:MouseEvent):void
		{
			switch (e.currentTarget)
			{
				case play_btn:	
					dispatchEvent(new ScreenEvents(ScreenEvents.DESTROYED,"Intro",true,true));
					break;
				case options_btn:	
					option_win.Init();
					option_win.visible = true;
					break;
				case load_btn:	
					dispatchEvent(new ScreenEvents(ScreenEvents.DESTROYED,"WorldMap",true,true));
					break;
					
				case quit_btn:
					fscommand("quit");
					break;
			}
			
		}
		
		// =====================================================================
		override public function end():void
		{
			view.removeChild(play_btn);
			view.removeChild(load_btn);
			view.removeChild(options_btn);
			view.removeChild(quit_btn);
			_view.removeEventListener(MouseEvent.CLICK, _onClickHandler); // [d]
			
			Main.managers.SoundM.stopAllSounds();
			super.end();
		}
		
	}

}