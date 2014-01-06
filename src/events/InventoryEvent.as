package events 
{
	import codex.items.Item;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class InventoryEvent extends Event 
	{
		public static const CONSUMABLE_SELECTED:String = "ConsumableSelected";
		public static const WEAPON_SELECTED:String = "WeaponSelected";
		public static const ARMOR_SELECTED:String = "ArmorSelected";
		public static const ACCESSORY_SELECTED:String = "AccessorySelected";
		
		public var selectedItem:Item;
		
		public function InventoryEvent(type:String,i:Item, bubbles:Boolean=true, cancelable:Boolean=true) 
		{
			selectedItem = i;
			super(type, bubbles, cancelable);
			
		}
		
	}

}