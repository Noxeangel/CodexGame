package displayable 
{
	import events.ScreenEvents;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class OptionWindow extends MovieClip 
	{
		private var view:OptionWindowMC = new OptionWindowMC();
		
		public function OptionWindow() 
		{
			addChild(view);	
			view.addEventListener(MouseEvent.CLICK, _onClick);
			
			view.quitField_txt.mouseEnabled = false;
			
		}
		
		public function Init():void
		{
			
			view.bgm_slider.value = Main.bgmVolume * 100;
			view.sfx_slider.value = Main.sfxVolume * 100;
			view.language_cb.selectedIndex = Main.language;
			view.input_cb.selectedIndex = Main.isKeyboard ;
			view.tuto_cb.selectedIndex = Main.isTutorial;
		}
		
		private function _onClick(e:MouseEvent):void 
		{
			Main.bgmVolume = view.bgm_slider.value / 100;
			Main.sfxVolume = view.sfx_slider.value / 100;
			
			Main.language = view.language_cb.selectedIndex;
			Main.isKeyboard = view.input_cb.selectedIndex;
			Main.isTutorial = view.tuto_cb.selectedIndex;
			if (e.target == view.quit_btn)
			{
				dispatchEvent(new ScreenEvents(ScreenEvents.DESTROYED,"MainMenu",true,true));
			}
			
			
		}
		
	}

}