package  {
	
	import flash.display.MovieClip;
	
	
	public class LeftTalkPortraitMC extends MovieClip {
		
		public var heroTalk_mc:HeroTalkMC;
		public var priestTalk_mc:PriestTalkMC;
		
		public function LeftTalkPortraitMC() {
			// constructor code
		}
		
		public function getPortrait(index:int):MovieClip
		{
			switch(index)
			{
				case 1:
					gotoAndStop(1);
					return heroTalk_mc;
					break;
				case 2:
					gotoAndStop(2);
					return priestTalk_mc;
					break;
				default:
					gotoAndStop(3);
					return new MovieClip();
			}
		}
	}
	
}
