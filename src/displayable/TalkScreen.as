package displayable 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class TalkScreen extends MovieClip 
	{
		public var view:TalkScreenMC = new TalkScreenMC();
		public var talkConsole:TalkConsole = new TalkConsole();
		
		public function TalkScreen() 
		{
			view.gotoAndStop(1);
			view.right_mc.heroTalk_mc.gotoAndStop(1);
			view.left_mc.heroTalk_mc.gotoAndStop(18);
			addChild(view);
			talkConsole.x = 512;
			talkConsole.y = view.height - talkConsole.height;
			addChild(talkConsole);
			view.quit_txt.mouseEnabled = false;
		}
		
		public function Init(text:String):void
		{
			talkConsole.Init(text);
			talkConsole.Start();
		}
		
		public function End():void
		{
			talkConsole.End();
		}
		
	}

}