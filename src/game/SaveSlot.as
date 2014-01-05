package game 
{
	import codex.armies.Army;
	import codex.characters.Character;
	import codex.characters.General;
	import codex.characters.Vital;
	import codex.items.Accessory;
	import codex.items.Armor;
	import codex.items.Consumable;
	import codex.items.Inventory;
	import codex.items.Item;
	import codex.items.Weapon;
	import codex.levels.Level;
	import XML;
	import Date;
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
		
		public function Save():XML
		{
			return (CollectData());
		}
		private function CollectData():XML
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
			
			return (WriteToXML());
		}
		private function WriteToXML():XML
		{
			var d:Date = new Date();
			var tmpXML:XML = new XML(<SAVE></SAVE>);
			tmpXML.@slot = 1;
			
			
			tmpXML.TIME = new String(d.toTimeString().slice(0 ,d.toTimeString().length - 8 ));
			
			tmpXML.DATE = d.toDateString();
			
			tmpXML.LOCATION = _currentLocation;
			
			tmpXML.TURN = _currentTurn;

			tmpXML.appendChild(writeCharacter(_hero));
			tmpXML.appendChild(writeCharacter(_lt1));
			tmpXML.appendChild(writeCharacter(_lt2));
			tmpXML.appendChild(writeCharacter(_lt3));
			
			tmpXML.appendChild(writeArmy(_army));
			
			tmpXML.appendChild(writeInventory(_teamInventory));
			
			for each(var level:Level in _levels)
			{
				tmpXML.appendChild(writeLevel(level));
			}
			return (tmpXML);
		}
		
		
		
		private function writeCharacter(c:Character):XML
		{
			var character:XML = new XML(<CHARACTER></CHARACTER>);
			character.@ID = c.id;
			
			character.NAME = c.name;
			character.CURRENT_LIFE = (c.vitalsArray[Main.LIFE] as Vital).curValue;
			character.CURRENT_MANA = (c.vitalsArray[Main.MANA] as Vital).curValue;
			
			character.DIALOG_STATE = "DEBUG_NULL";
			
			
			character.WEAPON = c.weaponEquipped == null ? "NULL" : c.weaponEquipped.id;
			character.ARMOR = c.armorEquipped == null ? "NULL" : c.armorEquipped.id;
			character.ACCESSORY = c.accesoryEquipped == null ? "NULL" : c.accesoryEquipped.id;
			
			return character;
		}
		
		private function writeArmy(a:Army):XML
		{
			var army:XML = new XML(<ARMY></ARMY>);
			
			var lancer:XML = new XML(<LANCER/>);
			var archer:XML = new XML(<ARCHER/>);
			var knight:XML = new XML(<KNIGHT/>);
			
			lancer.MAX = a.lancers.maxNumber;
			lancer.CUR = a.lancers.currentNumber;
			
			archer.MAX = a.archers.maxNumber;
			archer.CUR = a.archers.currentNumber;
			
			knight.MAX = a.knights.maxNumber;
			knight.CUR = a.knights.currentNumber;
			
			army.appendChild(lancer);
			army.appendChild(archer);
			army.appendChild(knight);
			
			return army;
		}
		
		private function writeInventory(i:Inventory):XML
		{
			var inventory:XML = new XML(<INVENTORY></INVENTORY>);
			
			for each( var c:Consumable in i.consumables)
			{
				inventory.CONSUMABLE = c.id; 
			}
			for each( var w:Weapon in i.weapons)
			{
				inventory.WEAPON = w.id; 
			}
			for each( var a:Armor in i.armors)
			{
				inventory.ARMOR = a.id; 
			}
			for each( var ac:Accessory in i.accesories)
			{
				inventory.ACCESSORY = ac.id; 
			}
			
			return inventory;
		}
		
		private function writeLevel(l:Level):XML 
		{
			var level:XML = new XML(<LEVEL></LEVEL>);
			level.@ID = l.id;
			
			level.NAME = l.name;
			
			level.IS_ALLY = l.isAlly;
			
			level.IS_SEARCH_DONE = l.isSearchDone;
			level.IS_PROPAGANDA_DONE = l.isPropagandaDone;
			
			return level;
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