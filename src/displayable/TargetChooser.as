package displayable 
{
	import codex.characters.Character;
	import codex.characters.General;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class TargetChooser extends MovieClip 
	{
		
		public var view:TargetlChooserMC = new TargetlChooserMC();
		
		public function TargetChooser() 
		{
			addChild(view);
			
			view.skillButton1_mc.buttonMode = true;
			view.skillButton2_mc.buttonMode = true;
			view.skillButton3_mc.buttonMode = true;
			
			view.name1_txt.mouseEnabled = false;
			view.target1_txt.mouseEnabled = false;
			
			view.name2_txt.mouseEnabled = false;
			view.target2_txt.mouseEnabled = false;
			
			view.name3_txt.mouseEnabled = false;
			view.target3_txt.mouseEnabled = false;
			
		}
		
		public function SetUp(hero:General, lieutenant:Character, enemy:General):void
		{
			view.name1_txt.text = enemy.name;
			
			view.name2_txt.text = hero.name;
			view.name3_txt.text = lieutenant.name;
			
		}
		
	}

}