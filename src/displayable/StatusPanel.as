package displayable 
{
	/**
	 * ...
	 * @author Olivier
	 */
	
	 
	import codex.characters.Character;
	import codex.items.Accessory;
	import codex.items.Armor;
	import codex.items.Weapon;
	import flash.display.MovieClip;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import managers.TextManager;
	 
	public class StatusPanel extends MovieClip
	{
	
		
		private var view:StatusPanelMC = new StatusPanelMC();
		
		private var weaponIcon:ItemIcon = new ItemIcon();
		private var armorIcon:ItemIcon = new ItemIcon();
		private var accessoryIcon:ItemIcon = new ItemIcon();
		
		public function StatusPanel() 
		{
			
			
			addChild(view);
			
			
			weaponIcon.x = 21;
			weaponIcon.y = 160
			addChild(weaponIcon);
			
			armorIcon.x = 19;
			armorIcon.y = 210
			addChild(armorIcon);
			
			accessoryIcon.x = 20;
			accessoryIcon.y = 265
			addChild(accessoryIcon);
		}
		
		public function ShowIcons (character:Character):void
		{
			if (character.weaponEquipped != null)
			{
				weaponIcon.displayImage(character.weaponEquipped.viewName);
			}
			else
			{
				weaponIcon.displayImage();
			}
			if ( character.armorEquipped != null)
			{
				armorIcon.displayImage(character.armorEquipped.viewName);
			}
			else
			{
				armorIcon.displayImage();
			}
			if (character.accesoryEquipped != null)
			{
				accessoryIcon.displayImage(character.accesoryEquipped.viewName);
			}
			else
			{
				accessoryIcon.displayImage();
			}
		}
		
		public function Display(character:Character):void
		{

			ShowIcons(character);

			view.forBase_txt.text =  character.statsArray[Main.STRENGTH].ammount.toString();
			view.forMod_txt.text =  character.statsArray[Main.STRENGTH].mod.toString();
			view.forTot_txt.text =  character.statsArray[Main.STRENGTH].finalAmmount.toString();

			view.conBase_txt.text =  character.statsArray[Main.CONSTITUTION].ammount.toString();
			view.conMod_txt.text =  character.statsArray[Main.CONSTITUTION].mod.toString();
			view.conTot_txt.text =  character.statsArray[Main.CONSTITUTION].finalAmmount.toString();

			view.intBase_txt.text =  character.statsArray[Main.INTELLIGENCE].ammount.toString();
			view.intMod_txt.text =  character.statsArray[Main.INTELLIGENCE].mod.toString();
			view.intTot_txt.text =  character.statsArray[Main.INTELLIGENCE].finalAmmount.toString();

			view.wilBase_txt.text =  character.statsArray[Main.WILLPOWER].ammount.toString();
			view.wilMod_txt.text =  character.statsArray[Main.WILLPOWER].mod.toString();
			view.wilTot_txt.text =  character.statsArray[Main.WILLPOWER].finalAmmount.toString();

			view.chaBase_txt.text =  character.statsArray[Main.CHARISMA].ammount.toString();
			view.chaMod_txt.text =  character.statsArray[Main.CHARISMA].mod.toString();
			view.chaTot_txt.text =  character.statsArray[Main.CHARISMA].finalAmmount.toString();
		
			if (character.weaponEquipped != null)
			{
				view.weaponName_txt.text = character.weaponEquipped.name;
				view.weaponMods_txt.text = character.weaponEquipped.PrintMods();
			}
			else
			{
				view.weaponName_txt.text = "None";
				view.weaponMods_txt.text = "Mod: 0";
			}
			if (character.armorEquipped != null)
			{
				
				view.armorName_txt.text = character.armorEquipped.name;
				view.armorMods_txt.text = character.armorEquipped.PrintMods();
			}
			else
			{
				view.armorName_txt.text = "None";
				view.armorMods_txt.text = "Mod: 0";
			}
			if (character.accesoryEquipped != null)
			{
				view.accessoryName_txt.text = character.accesoryEquipped.name;
				view.accessoryMods_txt.text = character.accesoryEquipped.PrintMods();
			}
			else
			{
				view.accessoryName_txt.text = "None";
				view.accessoryMods_txt.text = "Mod: 0";
			}
			
			if (view.strLine_txt != null)
			{
				view.strLine_txt.text = Main.managers.Text.GetText(TextManager.STR);
			}
			if (view.conLine_txt != null)
			{
				view.conLine_txt.text = Main.managers.Text.GetText(TextManager.CON);
			}
			if (view.intLine_txt != null)
			{
				view.intLine_txt.text = Main.managers.Text.GetText(TextManager.INT);
			}
			if (view.wilLine_txt != null)
			{
				view.wilLine_txt.text = Main.managers.Text.GetText(TextManager.WIL);
			}
			if (view.chaLine_txt != null)
			{
				view.chaLine_txt.text = Main.managers.Text.GetText(TextManager.CHA);
			}
		}
		
		
	}

}