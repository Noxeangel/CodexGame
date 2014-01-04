package  {
	
	import flash.display.MovieClip;
	
	
	public class LeftTalkPortraitMC extends MovieClip {
		
		public var heroTalk_mc:HeroTalkMC;
		
		public function LeftTalkPortraitMC() {
			// constructor code
		}
		
		public function getPortrait(index:String):void
		{
			switch(index)
			{
				case "001":
					gotoAndStop(1);
					break;
				case "002":
					gotoAndStop(2);
					break;
			}
		}
	}
	
}
