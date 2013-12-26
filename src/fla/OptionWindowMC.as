package  {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import fl.controls.ComboBox;
	import fl.controls.Slider;
	
	
	public class OptionWindowMC extends MovieClip {
		
		public var languageField_txt:TextField;
		public var keyboardField_txt:TextField;
		public var tutoField_txt:TextField;
		public var bgmField_txt:TextField;
		public var sfxField_txt:TextField;
		public var quitField_txt:TextField;
		
		public var quit_btn:MovieClip;
		
		public var language_cb:ComboBox;
		public var input_cb:ComboBox;
		public var tuto_cb:ComboBox;
		
		public var bgm_slider:Slider;
		public var sfx_slider:Slider;
		
		public function OptionWindowMC() {
			// constructor code
		}
	}
	
}
