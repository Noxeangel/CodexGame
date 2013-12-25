package  {
	
	import flash.display.MovieClip;
	
	import flash.text.TextField; 
	import LifeBarMC;
	
	
	public class CharacterDisplayMC extends MovieClip {
		
		public var lifeField_txt:TextField = new TextField();
		public var manaField_txt:TextField = new TextField();
		
		public var lifeLine_txt:TextField = new TextField();
		public var manaLine_txt:TextField = new TextField();
		
		public var lifeBar_mc:MovieClip;
		public var manaBar_mc:MovieClip;
		
		public var blankIcon_mc:MovieClip;
		
		public function CharacterDisplayMC() {
			// constructor code
			
		}
		
	}
	
}
