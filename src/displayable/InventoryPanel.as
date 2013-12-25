package displayable 
{
	import codex.items.Accessory;
	import codex.items.Armor;
	import codex.items.Consumable;
	import codex.items.Inventory;
	import codex.items.Item;
	import codex.items.Weapon;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class InventoryPanel extends MovieClip 
	{
		private var view:InventoryPanelMC = new InventoryPanelMC();
		
		private var itemDisplayers_arr:Array = new Array();
		private var itemDisplayersViewables_arr:Array = new Array();
		private var index:int = 0;
		
		private const LENGTH_OF_VIEW:int = 12;
		
		public function InventoryPanel() 
		{
			ResetInventory();
			addChild(view);
			
			addEventListener(MouseEvent.CLICK, _onClickHandler);
		}
		
		private function _onClickHandler(e:MouseEvent):void 
		{
			if (e.target == view.topScroller_mc)
			{
				ScrollUp();
			}
			if (e.target == view.bottomScroller_mc)
			{
				ScrollDown();
			}
		}
		
		public function SetInventoryPanel(inventory:Array):void
		{
			
			for each (var i:Item in inventory)
			{
				if (i != null)
				{
					itemDisplayers_arr.push(new ItemDisplayer(i));
					
				}
				
			}
			trace(itemDisplayers_arr.length);
			DisplayInventoryPanel();
		}
		
		public function DisplayInventoryPanel():void
		{
			var i:int;
			for (i = index; i < index + LENGTH_OF_VIEW ; i++)
			{
				if (itemDisplayers_arr[i])
				{
					itemDisplayersViewables_arr.push(itemDisplayers_arr[i]);
				}
			}
			i = 0;
			for each(var d:ItemDisplayer in itemDisplayersViewables_arr)
			{
				d.x = 20;
				d.y = 20 + 50 * i;
				i++;
				addChild(d);
			}
		}
		
		public function ClearInventoryPanel():void
		{
			for each(var d:ItemDisplayer in itemDisplayersViewables_arr)
			{
				removeChild(d);
			}
			itemDisplayersViewables_arr = new Array();
		}
		
		public function ResetInventory():void
		{
			itemDisplayers_arr = new Array();
			ClearInventoryPanel();
		}
		
		public function ScrollDown():void
		{
			
			if (index < itemDisplayers_arr.length - LENGTH_OF_VIEW)
			{
				index ++;
				ClearInventoryPanel();
				DisplayInventoryPanel();
			}
		}
		public function ScrollUp():void
		{
			if (index > 0)
			{
				index --;
				ClearInventoryPanel();
				DisplayInventoryPanel();
			}
		}
		
	}

}