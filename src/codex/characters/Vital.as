package codex.characters 
{
	/**
	 * ...
	 * @author Olivier
	 */
	
	import codex.characters.BaseStat;
	 
	public class Vital 
	{
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Attributes of the Class
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private var _name:String;				//Name of the Vital (use for exemple Main.VITAL_NAMES[Main.LIFE])
		private var _maxValue:int;
		private var _curValue:int;
		private var _basedOnStat:BaseStat; 		//Stat the vital derivates from
		private var _statIndex:int;				//index of the Stat the vital derivates from (Use for Exemple Main.STRENGTH)
		private var _statMult:int;				//Multiplicator depend of the archetype
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Base Constructor
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Vital(name:String,  stat:BaseStat /*= new BaseStat("empty")*/, statIndex:int = 0, mult:int = 0) 
		{
			_name = name;
			_basedOnStat = stat;
			_statIndex = statIndex;
			_statMult = mult;
			
			SetVital(stat);
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Basic Setters And Getters
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function get name():String 
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function get maxValue():int 
		{
			return _maxValue;
		}
		
		public function set maxValue(value:int):void 
		{
			_maxValue = value;
		}
		
		public function get curValue():int 
		{
			return _curValue;
		}
		
		public function set curValue(value:int):void 
		{
			_curValue = value;
		}
		
		public function get basedOnStat():BaseStat 
		{
			return _basedOnStat;
		}
		
		public function set basedOnStat(value:BaseStat):void 
		{
			_basedOnStat = value;
		}
		
		public function get statIndex():int 
		{
			return _statIndex;
		}
		
		public function set statIndex(value:int):void 
		{
			_statIndex = value;
		}
		
		public function get statMult():int 
		{
			return _statMult;
		}
		
		public function set statMult(value:int):void 
		{
			_statMult = value;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Custom Functions
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function SetVital( stat:BaseStat) : void
		{
			_basedOnStat = stat;
			//trace("vital:" + _name + ", based Stat: " + stat.name + " stat mult: "+ _statMult + " base stat ammount" + _basedOnStat.ammount);
			
			_maxValue = _statMult * _basedOnStat.finalAmmount;
		}
		
	}

}