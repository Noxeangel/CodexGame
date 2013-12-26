package  {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	
	public class TargetlChooserMC extends MovieClip {
		
		public var name1_txt:TextField;
		public var name2_txt:TextField;
		public var name3_txt:TextField;
		
		public var target1_txt:TextField;
		public var target2_txt:TextField;
		public var target3_txt:TextField;
		
		public var skillButton1_mc:MovieClip;
		public var skillButton2_mc:MovieClip;
		public var skillButton3_mc:MovieClip;
		
		public function TargetlChooserMC() {
			// constructor code
			target1_txt.mouseEnabled = false;
			target2_txt.mouseEnabled = false;
			target3_txt.mouseEnabled = false;
			
			name1_txt.mouseEnabled = false;
			name2_txt.mouseEnabled = false;
			name3_txt.mouseEnabled = false;
		}
	}
	
}
