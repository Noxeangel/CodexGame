package managers 
{
	/**
	 * ...
	 * @author Olivier
	 */
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.net.URLLoader;
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
			var loader:URLLoader = new URLLoader();
			var request:URLRequest;
			
			switch(slot)
			{
				case 1:
					request = new URLRequest("Save1.xml");
					loader.addEventListener(Event.COMPLETE, _onLoadSave1);
					loader.load(request);
					break;
				case 2:
					request = new URLRequest("Save2.xml");
					loader.addEventListener(Event.COMPLETE, _onLoadSave2);
					loader.load(request);
					break;
				case 3:
					request = new URLRequest("Save3.xml");
					loader.addEventListener(Event.COMPLETE, _onLoadSave3);
					loader.load(request);
					break;
				default:
					throw new Error("This save slot is not correct try between 1 and 3", "#0001");
					break;
				
			}
		}
		
		private function _onLoadSave3(e:Event):void 
		{
			var dataXML:XML = new XML( e.target.data);
			slot3.Load(dataXML);
		}
		
		private function _onLoadSave2(e:Event):void 
		{
			var dataXML:XML = new XML(e.target.data);
			slot2.Load(dataXML);
		}
		
		private function _onLoadSave1(e:Event):void 
		{
			var dataXML:XML = new XML(e.target.data);
			slot1.Load(dataXML);
		}
	}

}