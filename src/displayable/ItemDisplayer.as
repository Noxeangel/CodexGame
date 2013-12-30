package displayable 
{
	import codex.items.Item;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Olivier
	 */
	public class ItemDisplayer extends MovieClip
	{
		
		public var view:ItemDisplayerMC ;
		public var icon:ItemIcon = new ItemIcon();
		public var holdedItem:Item;
		
		public function ItemDisplayer(item:Item)
		{
			
			view = new ItemDisplayerMC();
			
			view.weaponMods_txt.mouseEnabled = false;
			view.weaponName_txt.mouseEnabled = false;
			icon.mouseChildren = false;
			holdedItem = item;
			//trace(holdedItem);
			SetItemDisplayer(item);
			addChild(view);
			addChild(icon);
			buttonMode = true;
		}
		
		public function SetItemDisplayer(item:Item):void
		{
			if (item != null)
			{
				view.weaponName_txt.text = item.name;
				view.weaponMods_txt.text = item.PrintMods();
				icon.displayImage(item.viewName);
			}
			
		}
		
	}

}