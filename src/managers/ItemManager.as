package managers 
{
	import codex.items.Item;
	import codex.items.Accessory;
	import codex.items.Armor;
	import codex.items.Consumable;
	import codex.items.Inventory;
	import codex.items.Weapon;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * ...
	 * @author Olivier
	 * @usage this class holds all the methods related to the items and inventories (mostly the constructors)
	 * @usage created once in the Global Manager singleton class
	 */
	public class ItemManager  extends MovieClip
	{

		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				MovieClip used to display the inventory Panel
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private var inventoryScreen:MovieClip;
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Inventory of the hero team and global inventory of all the item of the game
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public var partyInventory:Inventory;
		
		public var totalInventory:Inventory;
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Constructor
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function ItemManager() 
		{
			partyInventory = new Inventory();
			totalInventory = new Inventory();
			
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Init function, called by the init function of the global manager
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Init():void
		{
			processItemXML();
		}

		//This function build the assign the values from the XML Data to the attributes 
		private function processItemXML():void
		{

			var ItemXMLFile:XML = Main.ItemXMLFile;
			
			for each( var nodec:XML in ItemXMLFile.CONSUMABLE)
			{
				var tmpc:Consumable = new Consumable();
				
				
				tmpc.id = nodec.@ID;
				tmpc.name = nodec.NAME;
				
				switch(nodec.RESERVED)
				{
					case("ALL"):
						tmpc.reserved = Main.ALL;
						break;
					case("GENERAL"):
						tmpc.reserved = Main.GENERAL;
						break;
					case("PRIEST"):
						tmpc.reserved = 2;
						break;
					case("ASSASSIN"):
						tmpc.reserved = 3;
						break;
					case("WIZZARD"):
						tmpc.reserved = 4;
						break;
					case("TROUPS"):
						tmpc.reserved = 5;
						break;
				}

				tmpc.vitalMods[Main.LIFE] = (int)(nodec.LIFE);
				tmpc.vitalMods[Main.MANA] = (int)(nodec.MANA);

				tmpc.statMods[Main.STRENGTH] = (int)(nodec.STR);
				tmpc.statMods[Main.CONSTITUTION] = (int)(nodec.CON);
				tmpc.statMods[Main.INTELLIGENCE] = (int)(nodec.INT);
				tmpc.statMods[Main.WILLPOWER] = (int)(nodec.WIL);
				tmpc.statMods[Main.CHARISMA] = (int)(nodec.CHA);
				tmpc.statMods[Main.AGILITY] = (int)(nodec.AGI);
				
				tmpc.viewName = nodec.ICON;
				totalInventory.consumables.push(tmpc);
				
			}

			for each( var nodew:XML in ItemXMLFile.WEAPON)
			{
				var tmpw:Weapon = new Weapon();
				
				tmpw.name = nodew.NAME;
				tmpw.id = nodew.@ID;
				
				switch(nodew.RESERVED)
				{
					case("ALL"):
						tmpw.reserved = 0;
						break;
					case("GENERAL"):
						tmpw.reserved = 1;
						break;
					case("PRIEST"):
						tmpw.reserved = 2;
						break;
					case("ASSASSIN"):
						tmpw.reserved = 3;
						break;
					case("WIZZARD"):
						tmpw.reserved = 4;
						break;
					case("TROUPS"):
						tmpw.reserved = 5;
						break;
				}

				tmpw.vitalMods[Main.LIFE] = (int)(nodew.LIFE);
				tmpw.vitalMods[Main.MANA] = (int)(nodew.MANA);

				tmpw.statMods[Main.STRENGTH] = (int)(nodew.STR);
				tmpw.statMods[Main.CONSTITUTION] = (int)(nodew.CON);
				tmpw.statMods[Main.INTELLIGENCE] = (int)(nodew.INT);
				tmpw.statMods[Main.WILLPOWER] = (int)(nodew.WIL);
				tmpw.statMods[Main.CHARISMA] = (int)(nodew.CHA);
				tmpw.statMods[Main.AGILITY] = (int)(nodew.AGI);
				
				tmpw.viewName = nodew.ICON;
				totalInventory.weapons.push(tmpw);
				
			}
			
			for each( var nodear:XML in ItemXMLFile.ARMOR)
			{
				var tmpar:Armor = new Armor();
				
				tmpar.name = nodear.NAME;
				tmpar.id = nodear.@ID;
				switch(nodear.RESERVED)
				{
					case("ALL"):
						tmpar.reserved = 0;
						break;
					case("GENERAL"):
						tmpar.reserved = 1;
						break;
					case("PRIEST"):
						tmpar.reserved = 2;
						break;
					case("ASSASSIN"):
						tmpar.reserved = 3;
						break;
					case("WIZZARD"):
						tmpar.reserved = 4;
						break;
					case("TROUPS"):
						tmpar.reserved = 5;
						break;
				}

				tmpar.vitalMods[Main.LIFE] = (int)(nodear.LIFE);
				tmpar.vitalMods[Main.MANA] = (int)(nodear.MANA);

				tmpar.statMods[Main.STRENGTH] = (int)(nodear.STR);
				tmpar.statMods[Main.CONSTITUTION] = (int)(nodear.CON);
				tmpar.statMods[Main.INTELLIGENCE] = (int)(nodear.INT);
				tmpar.statMods[Main.WILLPOWER] = (int)(nodear.WIL);
				tmpar.statMods[Main.CHARISMA] = (int)(nodear.CHA);
				tmpar.statMods[Main.AGILITY] = (int)(nodear.AGI);
				
				tmpar.viewName = nodear.ICON;
				totalInventory.armors.push(tmpar);
				
			}
			
			for each( var nodeac:XML in ItemXMLFile.ACCESSORY)
			{
				var tmpac:Accessory = new Accessory();
				
				tmpac.name = nodeac.NAME;
				tmpac.id = nodeac.@ID;

				switch(nodeac.RESERVED)
				{
					case("ALL"):
						tmpac.reserved = 0;
						break;
					case("GENERAL"):
						tmpac.reserved = 1;
						break;
					case("PRIEST"):
						tmpac.reserved = 2;
						break;
					case("ASSASSIN"):
						tmpac.reserved = 3;
						break;
					case("WIZZARD"):
						tmpac.reserved = 4;
						break;
					case("TROUPS"):
						tmpac.reserved = 5;
						break;
				}

				tmpac.vitalMods[Main.LIFE] = (int)(nodeac.LIFE);
				tmpac.vitalMods[Main.MANA] = (int)(nodeac.MANA);

				tmpac.statMods[Main.STRENGTH] = (int)(nodeac.STR);
				tmpac.statMods[Main.CONSTITUTION] = (int)(nodeac.CON);
				tmpac.statMods[Main.INTELLIGENCE] = (int)(nodeac.INT);
				tmpac.statMods[Main.WILLPOWER] = (int)(nodeac.WIL);
				tmpac.statMods[Main.CHARISMA] = (int)(nodeac.CHA);
				tmpac.statMods[Main.AGILITY] = (int)(nodeac.AGI);
				
				tmpac.viewName = nodeac.ICON;
				totalInventory.accesories.push(tmpac);
				
				
			}
			partyInventory.armors.push(returnItem("A001"));
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Custom Functions to display an inventory Screen in a State of Game.
		//				The inventory state is added to the _view MovieClip of a Screen/State
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function DisplayInventoryScreen(view:MovieClip):void
		{
			view.addChild(inventoryScreen);
		}
		public function HideInventoryScreen(view:MovieClip):void
		{
			view.removeChild(inventoryScreen);
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Custom Functions to return an item
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function returnItem(id:String):Item
		{
			var firstLetterID:String = id.charAt(0);
			switch(firstLetterID)
			{
				case 'K':
					return returnConsumable(id);
					break;
				case 'W':
					return returnWeapon(id);
					break;
				case 'D':
					return returnWeapon(id);
					break;
				case 'S':
					return returnWeapon(id);
					break;
				case 'B':
					return returnWeapon(id);
					break;
				case 'A':
					return returnArmor(id);
					break;
				case 'C':
					return returnAccessory(id);
					break;
				default:
					return null;
					break;
			}
		}
		
		public function returnConsumable(id:String):Consumable
		{
			for each(var c:Consumable in totalInventory.consumables)
			{
				if (c.id == id)
				{
					return c;
				}
			}
			return null;
		}
		
		public function returnWeapon(id:String):Weapon
		{
			for each(var w:Weapon in totalInventory.weapons)
			{
				if (w.id == id)
				{
					
					return w;
				}
				
			}
			return null;
		}
		
		public function returnArmor(id:String):Armor
		{
			for each(var w:Armor in totalInventory.armors)
			{
				if (w.id == id)
				{
					
					return w;
				}
				
			}
			return null;
		}
		
		public function returnAccessory(id:String):Accessory
		{
			for each(var w:Accessory in totalInventory.accesories)
			{
				if (w.id == id)
				{
					
					return w;
				}
				
			}
			return null;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Custom Function to return a certain type of item
		//				Used to build an inventory Screen of item usable by a certain Archetype
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function returnItemType (inventory:Inventory ,type:int = Main.CONSUMABLE, reserved:int = Main.ALL):Array
		{
			var arr:Array = new Array();
			switch (type)
			{
				case (Main.CONSUMABLE):
					for each(var cons:Consumable in inventory.consumables)
					{
						if (reserved == cons.reserved)
						{
							arr.push(cons);
						}
						
					}
					break;
				case (Main.WEAPON):
					for each(var weap:Weapon in inventory.weapons)
					{
						if (reserved == weap.reserved)
						{
							arr.push(weap);
						}
					}
					break;
				case (Main.ARMOR):
					for each(var armo:Armor in inventory.armors)
					{
						if (reserved == armo.reserved)
						{
							arr.push(armo);
						}
					}
					break;
				case (Main.ACCESSORY):
					for each(var acce:Accessory in inventory.accesories)
					{
						if (reserved == acce.reserved)
						{
							arr.push(acce);
						}
					}
					break;
				default:
					throw(new Error("This type item doesn't exist", "#404"));
					break;
			}
			return arr;
		}
		
		public function ChangeLanguageFunction():void
		{
			for each(var c:Consumable in  totalInventory.consumables)
			{
				c.name = Main.managers.Text.GetText(TextManager[c.id]);
			}
			for each(var w:Weapon in  totalInventory.weapons)
			{
				w.name = Main.managers.Text.GetText(TextManager[w.id]);
			}
			for each(var a:Armor in  totalInventory.armors)
			{
				a.name = Main.managers.Text.GetText(TextManager[a.id]);
			}
			for each(var ac:Accessory in  totalInventory.accesories)
			{
				ac.name = Main.managers.Text.GetText(TextManager[ac.id]);
			}
			
			for each(var c1:Consumable in  partyInventory.consumables)
			{
				c1.name = Main.managers.Text.GetText(TextManager[c1.id]);
			}
			for each(var w1:Weapon in  partyInventory.weapons)
			{
				w1.name = Main.managers.Text.GetText(TextManager[w1.id]);
			}
			for each(var a1:Armor in  partyInventory.armors)
			{
				a1.name = Main.managers.Text.GetText(TextManager[a1.id]);
			}
			for each(var ac1:Accessory in  partyInventory.accesories)
			{
				ac1.name = Main.managers.Text.GetText(TextManager[ac1.id]);
			}
		}
	}

}