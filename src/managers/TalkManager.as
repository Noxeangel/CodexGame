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

		public var debugDialog:DialogUnit = new DialogUnit();
		
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
			
			line1.dialog = "Ceci est une dialogue de test dont le but est de tester les classes nouvellements crées de DialogLine et DialogUnit";
			
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
			
			line2.dialog = "Ceci est la seconde ligne du texte de test, dans cette ligne je vais vous parler de la reproduction des punaises de lits dans les régions méridionales du sud-est du désert de Gobi";
			
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
			
			line3.dialog = "Voici enfin la dernière ligne de ce discours absurde digne d'Alfred Jarry. à la différence de ces copines, cette ligne n'est pas skippable";
			
			debugDialog.lines.push(line1);
			debugDialog.lines.push(line2);
			debugDialog.lines.push(line3);
		}

	}

}