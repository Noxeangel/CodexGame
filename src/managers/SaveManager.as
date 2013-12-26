package managers 
{
	/**
	 * ...
	 * @author Olivier
	 */
	import flash.display.MovieClip;
	import game.SaveSlot;

	 
	public class SaveManager  extends MovieClip
	{

		private var slot1:SaveSlot;
		private var slot2:SaveSlot;
		private var slot3:SaveSlot;
		
		public function SaveManager() 
		{
			
		}
		
		public function Init():void
		{
			
		}
		
		public function Save(slot:int):void
		{
			switch(slot)
			{
				case 1:
					slot1.Save(null);
					break;
				case 2:
					slot2.Save(null);
					break;
				case 3:
					slot3.Save(null);
					break;
				default:
					throw new Error("This save slot is not correct try between 1 and 3", "#0001");
					break;
				
			}
		}

		public function Load (slot:int):void
		{
			switch(slot)
			{
				case 1:
					slot1.Load(null);
					break;
				case 2:
					slot2.Load(null);
					break;
				case 3:
					slot3.Load(null);
					break;
				default:
					throw new Error("This save slot is not correct try between 1 and 3", "#0001");
					break;
				
			}
		}
	}

}