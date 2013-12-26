package game 
{
	import codex.armies.Army;
	import codex.characters.Character;
	import codex.characters.General;
	import codex.items.Inventory;
	/**
	 * ...
	 * @author Olivier
	 */
	public class SaveSlot 
	{
		//Slot relative
		private var date:Date;
		
		//CharacterManager Relative
		private var _hero:General;
		private var _lt1:Character;
		private var _lt2:Character;
		private var _lt3:Character;
		private var _army:Army;
		private var _ennemies:Array;
		
		//ItemManager Relative
		private var _teamInventory:Inventory;
		
		//LevelManager Relative
		private var _currentTurn:int;
		private var _currentLocation:int;
		private var _levels:Array;
		
		//TalkManager Relative
		
		public function SaveSlot() 
		{
			
		}
		
		public function Save(xml:XML):void
		{
			CollectData(xml);
		}
		private function CollectData(xml:XML):void
		{
			_hero = Main.managers.Character.hero;
			_lt1 = Main.managers.Character.lt1;
			_lt2 = Main.managers.Character.lt2;
			_lt3 = Main.managers.Character.lt3;
			_ennemies = Main.managers.Character.enemies;
			_army = Main.managers.Character.army;
			
			_teamInventory = Main.managers.Item.partyInventory;
			
			_currentTurn = Main.managers.Level.currentTurn;
			_currentLocation = Main.managers.Level.currentLocation;
			_levels = Main.managers.Level.Levels;
			
			WriteToXML(xml);
		}
		private function WriteToXML(xml:XML):void
		{
			
		}
		
		
		public function Load(xml:XML):void
		{
			ReadFromXML(xml);
		}
		
		private function ReadFromXML(xml:XML):void
		{
			DispatchData();
		}
		
		private function DispatchData():void
		{
			
		}
		
		
	}

}