package managers 
{
	/**
	 * ...
	 * @author Olivier
	 */
	import flash.display.MovieClip;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import game.SaveSlot;

	
	 
	public class SaveManager  extends MovieClip
	{

		private var slot1:SaveSlot = new SaveSlot();
		private var slot2:SaveSlot = new SaveSlot();
		private var slot3:SaveSlot = new SaveSlot();
		
		private var ref:FileReference = new FileReference();
		private var req:URLRequest;
		private var bytes:ByteArray = new ByteArray();
		
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
					
					bytes.writeUTFBytes(slot1.Save());
					ref.save(bytes, "Save1.xml");
					
					break;
				case 2:
					bytes.writeUTFBytes(slot2.Save());
					ref.save(bytes, "Save2.xml");
					break;
				case 3:
					bytes.writeUTFBytes(slot3.Save());
					ref.save(bytes, "Save3.xml");
					break;
				default:
					throw new Error("This save slot is not correct try between 1 and 3", "#0001");
					break;
				
			}
		}

		public function Load (slot:int):void
		{
			var tmpXML:XML;
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