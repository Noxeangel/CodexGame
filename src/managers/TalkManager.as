package managers 
{
	/**
	 * ...
	 * @author Olivier
	 */
	import codex.talk.DialogLine;
	import codex.talk.DialogUnit;
	import flash.display.MovieClip;

	
	public class TalkManager  extends MovieClip
	{

		/*
		Usage:
		One frame by eyes position X Ones frames by Mouth Position
		################################
		|Frame| Mouth        | Eyes    |
		################################
		|1    | Closed       | Opened  |
		|2    | Closed       | Closed  |
		|3    | Closed       | Full    |
		|4    | 0.5 Opened   | Opened  |
		|5    | 0.5 Opened   | Closed  |
		|6    | 0.5 Opened   | Full    |
		|7    | Opened       | Opened  |
		|8    | Opened       | Closed  |
		|9    | Opened       | Full    |
		|10   | little Smile | Opened  |
		|11   | little Smile | Closed  |
		|12   | little Smile | Full    |
		|13   | Med Smile    | Opened  |
		|14   | Med Smile    | Closed  |
		|15   | Med Smile    | Full    |
		|16   | Big Smile    | Opened  |
		|17   | Big Smile    | Closed  |
		|18   | Big Smile    | Full    |
		################################
		*/
		public var debugDialog:DialogUnit = new DialogUnit();
		
		public var units:Array = new Array();
		
		public function TalkManager() 
		{
			
		}
		
		public function Init():void
		{
			var line1:DialogLine = new DialogLine();
			line1.rightTalkerName = "Toto";
			line1.rightTalkerPortrait = 1;
			line1.rightTalkerMood = 1;
			
			line1.leftTalkerName = "Test2";
			line1.leftTalkerPortrait = 1;
			line1.leftTalkerMood = 10;
			
			line1.isLeftTalkerTalk = true;
			
			line1.isSkippable = true;
			
			line1.background = 1;
			
			line1.dialog[0] = "Ceci est une dialogue de test dont le but est de tester les classes nouvellements crées de DialogLine et DialogUnit";
			line1.dialog[1] = "This is a test dialog which aims to test created Property New classes of DialogLine and DialogUnit";
			
			var line2:DialogLine = new DialogLine();
			line2.rightTalkerName = "Toto";
			line2.rightTalkerPortrait = 1;
			line2.rightTalkerMood = 18;
			
			line2.leftTalkerName = "Test2";
			line2.leftTalkerPortrait = 1;
			line2.leftTalkerMood = 2;
			
			line2.isLeftTalkerTalk = false;
			
			line2.isSkippable = true;
			
			line2.background = 1;
			
			line2.dialog[0] = "Ceci est la seconde ligne du texte de test, dans cette ligne je vais vous parler de la reproduction des punaises de lits dans les régions méridionales du sud-est du désert de Gobi";
			line2.dialog[1] = "This is the second line of text test in this line I'll tell you about the reproduction of bed bugs in the southern regions of southeastern Gobi Desert";
			
			var line3:DialogLine = new DialogLine();
			line3.rightTalkerName = "Toto";
			line3.rightTalkerPortrait = 1;
			line3.rightTalkerMood = 13;
			
			line3.leftTalkerName = "Test2";
			line3.leftTalkerPortrait = 1;
			line3.leftTalkerMood = 5;
			
			line3.isLeftTalkerTalk = true;
			
			line3.isSkippable = false;
			
			line3.background = 1;
			
			line3.dialog[0] = "Voici enfin la dernière ligne de ce discours absurde digne d'Alfred Jarry. à la différence de ces copines, cette ligne n'est pas skippable";
			line3.dialog[1] = "Here is finally the last line of this absurd speech worthy of Alfred Jarry. unlike those friends, this line is not skippable";
			
			debugDialog.lines.push(line1);
			debugDialog.lines.push(line2);
			debugDialog.lines.push(line3);
			processTalkXML();
		}
		
		//This function build the assign the values from the XML Data to the attributes 
		private function processTalkXML():void
		{
			var TalkXMLFile:XML = Main.TalkXMLFile;
			
			for each (var dialogUnitNode:XML in TalkXMLFile.DIALOG_UNIT)
			{
				var tmpUnit:DialogUnit = new DialogUnit();
				tmpUnit.id = dialogUnitNode.@ID;
				
				for each (var dialogLineNode:XML in dialogUnitNode.DIALOG_LINE)
				{
					var tmpLine:DialogLine = new DialogLine();
					tmpLine.background = (int)(dialogLineNode.BACKGROUND);
					
					tmpLine.leftTalkerName = dialogLineNode.LEFT_TALKER.@NAME;
					tmpLine.leftTalkerPortrait = (int)(dialogLineNode.LEFT_TALKER.@PORTRAIT);
					tmpLine.leftTalkerMood = (int)(dialogLineNode.LEFT_TALKER.@MOOD);
					
					tmpLine.rightTalkerName = dialogLineNode.RIGHT_TALKER.@NAME;
					tmpLine.rightTalkerPortrait = (int)(dialogLineNode.RIGHT_TALKER.@PORTRAIT);
					tmpLine.rightTalkerMood = (int)(dialogLineNode.RIGHT_TALKER.@MOOD);
					
					tmpLine.isSkippable = (dialogLineNode.SKIPPABLE) == "1" ? true : false;
					
					tmpLine.dialog.push(new String( dialogLineNode.LANGUAGE0));
					tmpLine.dialog.push(new String( dialogLineNode.LANGUAGE1));
					
					tmpUnit.lines.push(tmpLine);
				}
				
				units.push(tmpUnit);
			}
			
		}	
			

	}

}