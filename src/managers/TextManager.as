package managers 
{
	/**
	 * ...
	 * @author Olivier
	 */
	import flash.display.MovieClip;

	
	public class TextManager  extends MovieClip
	{

		public function TextManager() 
		{
			
		}
		
		public function Init():void
		{		
		}

		public function GetText(index:int):String
		{
			
			return texts[index][Main.language];
		}
		
		//General Display Texts Indexes
		public static const COST:int = 0;
		public static const ACTIONS_PA:int = 1;
		public static const TURN:int = 2;
		public static const NEXT_TURN:int = 3;
		
		//Vitals and Attributes Texts Indexes
		public static const HP:int = 4;
		public static const MP:int = 5;
		
		public static const STR:int = 6;
		public static const CON:int = 7;
		public static const INT:int = 8;
		public static const WIL:int = 9;
		public static const CHA:int = 10;
		public static const AGI:int = 11;
		
		//Main Menu Texts Indexes
		public static const PLAY:int = 12;
		public static const LOAD:int = 13;
		public static const OPTIONS:int = 14;
		public static const QUIT:int = 15;
		
		//World Map Texts Indexes
		public static const MOVE:int = 16;
		public static const SEARCH:int = 17;
		public static const CAMP:int = 18;
		public static const PROPAGANDA:int = 19;
		public static const INVENTORY:int = 20;
		public static const EQUIP:int = 21;
		public static const TALK:int = 22;
		public static const MENU:int = 23;
		
		//Items Names
		public static const K001:int = 24;
		public static const K002:int = 25;
		
		public static const W001:int = 26;
		public static const W002:int = 27;
		public static const W003:int = 28;
		public static const W004:int = 29;
		public static const W005:int = 30;
		
		public static const D001:int = 31;
		public static const D002:int = 32;
		public static const D003:int = 33;
		public static const D004:int = 34;
		public static const D005:int = 35;
		
		public static const S001:int = 36;
		public static const S002:int = 37;
		public static const S003:int = 38;
		public static const S004:int = 39;
		public static const S005:int = 40;
		
		public static const B001:int = 41;
		public static const B002:int = 42;
		public static const B003:int = 43;
		public static const B004:int = 44;
		public static const B005:int = 45;
		
		public static const A001:int = 46;
		public static const A002:int = 47;
		public static const A003:int = 48;
		
		public static const C001:int = 49;
		public static const C002:int = 50;
		public static const C003:int = 51;
		public static const C004:int = 52;
		public static const C005:int = 53;
		public static const C006:int = 54;
		public static const C007:int = 55;
		public static const C008:int = 56;
		public static const C009:int = 57;
		public static const C010:int = 58;
		public static const C011:int = 59;
		public static const C012:int = 60;
		public static const C013:int = 61;
		public static const C014:int = 62;
		public static const C015:int = 63;
		
		//Duel Texts
		public static const LAUNCH:int = 64;
		
		private var texts:Array = new Array
		(
			new Array("Cost :", "Coût :"),
			new Array("Actions (A.P.)", "Actions (P.A.)"),
			new Array("Turn :", "Tour :"),
			new Array("Next Turn", "Tour Suivant"),
			
			new Array("H.P.", "P.V."),
			new Array("M.P.", "P.M."),
			
			new Array("STR:", "FOR:"),
			new Array("CON:", "CON:"),
			new Array("INT:", "INT:"),
			new Array("WIL:", "POU:"),
			new Array("CHA:", "CHA:"),
			new Array("AGI:", "AGI:"),
			
			new Array("Play","Jouer"),
			new Array("Load","Charger"),
			new Array("Options", "Options"),
			new Array("Quit", "Quitter"),
			
			new Array("Move","Avancer"),
			new Array("Search","Fouiller"),
			new Array("Camp", "Camper"),
			new Array("Propaganda", "Propagande"),
			new Array("Inventory","Inventaire"),
			new Array("Equip","Equipper"),
			new Array("Talk", "Discuter"),
			new Array("Menu", "Menu"),
			
			new Array("Life Potion","Potion de Vie"),
			new Array("Mana Potion", "Potion de Mana"),
			
			new Array("Sword 1","Epée 1"),
			new Array("Sword 2", "Epée 2"),
			new Array("Sword 5","Epée 3"),
			new Array("Sword 4", "Epée 4"),
			new Array("Sword 5", "Epée 5"),
			
			new Array("Dagger 1","Dague 1"),
			new Array("Dagger 2", "Dague 2"),
			new Array("Dagger 5","Dague 3"),
			new Array("Dagger 4", "Dague 4"),
			new Array("Dagger 5", "Dague 5"),
			
			new Array("Scepter 1","Sceptre 1"),
			new Array("Scepter 2", "Sceptre 2"),
			new Array("Scepter 5","Sceptre 3"),
			new Array("Scepter 4", "Sceptre 4"),
			new Array("Scepter 5", "Sceptre 5"),
			
			new Array("Book 1","Grimoire 1"),
			new Array("Book 2", "Grimoire 2"),
			new Array("Book 5","Grimoire 3"),
			new Array("Book 4", "Grimoire 4"),
			new Array("Book 5", "Grimoire 5"),
			
			new Array("Armor 1","Armure 1"),
			new Array("Armor 2", "Armure 2"),
			new Array("Armor 5","Armure 3"),

			new Array("Accessory 1","Accessoire 1"),
			new Array("Accessory 2", "Accessoire 2"),
			new Array("Accessory 5","Accessoire 3"),
			new Array("Accessory 4", "Accessoire 4"),
			new Array("Accessory 5", "Accessoire 5"),
			new Array("Accessory 1","Accessoire 1"),
			new Array("Accessory 2", "Accessoire 2"),
			new Array("Accessory 5","Accessoire 3"),
			new Array("Accessory 4", "Accessoire 4"),
			new Array("Accessory 5", "Accessoire 5"),
			new Array("Accessory 1","Accessoire 1"),
			new Array("Accessory 2", "Accessoire 2"),
			new Array("Accessory 5","Accessoire 3"),
			new Array("Accessory 4", "Accessoire 4"),
			new Array("Accessory 5", "Accessoire 5"),
			
			new Array("Launch","Lancer")
		);
		
	}

}