package codex.items 
{
	/**
	 * ...
	 * @author Olivier
	 * @usage : This class is only a data holder class. all the functions related to item use are in the Item Manager Class
	 */
	import managers.TextManager;
	
	 
	public class Item 
	{
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Basic Attributes of the class
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private var _id :String;										//ID of the Item in the XML Data File
		private var _name:String;										//Name of the Item
		
		private var _reserved:int;										//Which archetype can wear it

		private var _statMods:Array = new Array();
		private var _vitalMods:Array = new Array();
		
		private var _viewName:String									//Name of the MoveClass Class of the icon
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Basic Constructor
		//		Void. The real constructor is in the Item Manager Class
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Item() 
		{
			
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Basic Setters And Getters
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function get id():String 
		{
			return _id;
		}
		
		public function set id(value:String):void 
		{
			_id = value;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}

		public function get reserved():int 
		{
			return _reserved;
		}
		
		public function set reserved(value:int):void 
		{
			_reserved = value;
		}

		public function get viewName():String 
		{
			return _viewName;
		}
		
		public function set viewName(value:String):void 
		{
			_viewName = value;
		}
		
		public function get statMods():Array 
		{
			return _statMods;
		}
		
		public function set statMods(value:Array):void 
		{
			_statMods = value;
		}
		
		public function get vitalMods():Array 
		{
			return _vitalMods;
		}
		
		public function set vitalMods(value:Array):void 
		{
			_vitalMods = value;
		}
		
		
		public function PrintMods():String
		{
			var line:String = new String();
			if ( _statMods[Main.STRENGTH] != 0)
			{
				line += Main.managers.Text.GetText(TextManager.STR)+" + " + _statMods[Main.STRENGTH].toString() +" , ";
			}
			if (_statMods[Main.CONSTITUTION] != 0)
			{
				line += Main.managers.Text.GetText(TextManager.CON)+" + " + _statMods[Main.CONSTITUTION].toString() +" , ";
			}
			if ( _statMods[Main.INTELLIGENCE] != 0)
			{
				line += Main.managers.Text.GetText(TextManager.INT)+" + " + _statMods[Main.INTELLIGENCE].toString() +" , ";
			}
			if (_statMods[Main.WILLPOWER] != 0)
			{
				line += Main.managers.Text.GetText(TextManager.WIL)+" + " + _statMods[Main.WILLPOWER].toString() +" , ";
			}
			if (_statMods[Main.CHARISMA] != 0)
			{
				line += Main.managers.Text.GetText(TextManager.CHA)+" + " + _statMods[Main.CHARISMA].toString() +" , ";
			}
			
			return line;
		}
		
		
	}

}