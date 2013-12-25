package displayable 
{
	import codex.characters.Character;
	import flash.display.MovieClip;
	import codex.characters.Skill;
	import managers.TextManager;
	/**
	 * ...
	 * @author Olivier
	 */
	public class SkillChooser extends MovieClip 
	{
		public var view:SkillChooserMC;
		public var skills:Array;
		
		
		public function SkillChooser() 
		{
			view = new SkillChooserMC();
			skills = new Array();
			addChild(view);
			
			
			view.skillButton1_mc.buttonMode = true;
			view.skillButton2_mc.buttonMode = true;
			view.skillButton3_mc.buttonMode = true;
			
			view.name1_txt.mouseEnabled = false;
			view.costLine1_txt.mouseEnabled = false;
			view.cost1_txt.mouseEnabled = false;
			view.launch1_txt.mouseEnabled = false;
			
			view.name2_txt.mouseEnabled = false;
			view.costLine2_txt.mouseEnabled = false;
			view.cost2_txt.mouseEnabled = false;
			view.launch2_txt.mouseEnabled = false;
			
			view.name3_txt.mouseEnabled = false;
			view.costLine3_txt.mouseEnabled = false;
			view.cost3_txt.mouseEnabled = false;
			view.launch3_txt.mouseEnabled = false;
		}
		
		public function SetUp(character:Character):void
		{
			var l:int = skills.length;
			for ( var index:int =0 ; index < l; index++ )
			{
			  skills.pop();
			}
			trace( "skills array size= " + skills.length.toString());
			character.SetSkillKnown();
			for each(var skill:Skill in character.duelSkillArray)
			{
				if (skill.isKnown)
				{
					skills.push(skill);
					trace (skill.name);
				}
			}
			
			view.name1_txt.text = (skills[0] as Skill).name;
			view.costLine1_txt.text = Main.managers.Text.GetText(TextManager.COST);
			view.cost1_txt.text = (skills[0] as Skill).cost.toString();
			view.launch1_txt.text = Main.managers.Text.GetText(TextManager.LAUNCH);
			
			view.name2_txt.text = (skills[1] as Skill).name;
			view.costLine2_txt.text = Main.managers.Text.GetText(TextManager.COST);
			view.cost2_txt.text = (skills[1] as Skill).cost.toString();
			view.launch2_txt.text = Main.managers.Text.GetText(TextManager.LAUNCH);
			
			view.name3_txt.text = (skills[2] as Skill).name;
			view.costLine3_txt.text = Main.managers.Text.GetText(TextManager.COST);
			view.cost3_txt.text = (skills[2] as Skill).cost.toString();
			view.launch3_txt.text = Main.managers.Text.GetText(TextManager.LAUNCH);
		}
	}

}