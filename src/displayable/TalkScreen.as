package displayable 
{
	import codex.talk.DialogLine;
	import codex.talk.DialogUnit;
	import flash.display.MovieClip;
	import events.TalkEvent;
	/**
	 * ...
	 * @author Olivier
	 */
	public class TalkScreen extends MovieClip 
	{
		public var view:TalkScreenMC = new TalkScreenMC();
		public var talkConsole:TalkConsole = new TalkConsole();
		
		public var currentDialogUnit:DialogUnit;
		public var currentDialogLineIndex:int;
		
		public function TalkScreen() 
		{
			view.gotoAndStop(1);
			view.right_mc.heroTalk_mc.gotoAndStop(1);
			view.left_mc.heroTalk_mc.gotoAndStop(1);
			addChild(view);
			talkConsole.x = 512;
			talkConsole.y = view.height - talkConsole.height;
			addChild(talkConsole);
			view.quit_txt.mouseEnabled = false;
			
			addEventListener(TalkEvent.NEXT, _onLineFinished);
		}
		
		
		public function Init(unit:DialogUnit):void
		{
			currentDialogUnit = unit;
			currentDialogLineIndex = 0;
			displayNextLine();
		}
		
		private function _onLineFinished(e:TalkEvent):void 
		{
			e.stopImmediatePropagation();
			if (currentDialogLineIndex < currentDialogUnit.lines.length - 1)
			{
				currentDialogLineIndex ++;
				displayNextLine();
			}else
			{
				End();
			}
		}
		
		private function displayNextLine():void
		{
			view.bg_mc.gotoAndStop((currentDialogUnit.lines[currentDialogLineIndex] as DialogLine).background);
			
			view.right_mc.gotoAndStop((currentDialogUnit.lines[currentDialogLineIndex] as DialogLine).rightTalkerPortrait);
			view.left_mc.gotoAndStop((currentDialogUnit.lines[currentDialogLineIndex] as DialogLine).leftTalkerPortrait);
			
			view.right_mc.heroTalk_mc.gotoAndStop((currentDialogUnit.lines[currentDialogLineIndex] as DialogLine).rightTalkerMood);
			view.left_mc.heroTalk_mc.gotoAndStop((currentDialogUnit.lines[currentDialogLineIndex] as DialogLine).leftTalkerMood);
			
			var leftName:String;
			var rightName:String;
			
			if ((currentDialogUnit.lines[currentDialogLineIndex] as DialogLine).isLeftTalkerTalk)
			{
				leftName = (currentDialogUnit.lines[currentDialogLineIndex] as DialogLine).leftTalkerName;
				rightName = "";
			}
			else
			{
				leftName = "";
				rightName = (currentDialogUnit.lines[currentDialogLineIndex] as DialogLine).rightTalkerName;
			}
			
			talkConsole.Init((currentDialogUnit.lines[currentDialogLineIndex] as DialogLine).dialog,5.0,(currentDialogUnit.lines[currentDialogLineIndex] as DialogLine).isSkippable, leftName, rightName);
			talkConsole.Start();
		}
		
		public function End():void
		{
			talkConsole.End();
		}
		
	}

}