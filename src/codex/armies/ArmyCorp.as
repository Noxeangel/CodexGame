package codex.armies
{
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class ArmyCorp
	{
		
		private var _name:String;
		//use for exemple Main.LANCER to set Lancer type corp
		private var _type:int;
		private var _maxNumber:int;
		private var _currentNumber:int;
		private var _isDead:Boolean = false;
		private var _animationMachine:ArmyAnimationMachine = new ArmyAnimationMachine();
		private var _mod:int = 0;
		
		public function ArmyCorp()
		{
		
		}
		
		public function SetUpCorp(type:int, max:int):void
		{
			_type = type;
			setNameFromType();
			_maxNumber = max;
			_currentNumber = max;
			_animationMachine.Init(_type,_currentNumber);
		}
		
		public function addMaxTroops(ammount:int):void
		{
			_maxNumber += ammount;
			
			_currentNumber = _maxNumber;
			
		}
		
		public function rest():void
		{
			_currentNumber = _maxNumber;
		}
		
		public function removeTroops(ammount:int):void
		{
			if (_currentNumber - ammount <= 0)
			{
				_currentNumber = 0;
				_isDead = true;
			}
			else if (_currentNumber - ammount >= _maxNumber)
			{
				_currentNumber = _maxNumber;
				_isDead = false;
			}
			else
			{
				_currentNumber -= ammount;
				_isDead = false;
			}
		}
		
		private function setNameFromType():void
		{
			switch (_type)
			{
				case Main.LANCER: 
					_name = "Lancers";
					break;
				case Main.ARCHER: 
					_name = "Archers";
					break;
				case Main.KNIGHT: 
					_name = "Knights";
					break;
			}
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get maxNumber():int
		{
			return _maxNumber;
		}
		
		public function get currentNumber():int
		{
			return _currentNumber;
		}
		
		public function get isDead():Boolean
		{
			return _isDead;
		}
		
		public function get mod():int
		{
			return _mod;
		}
		
		public function set mod(value:int):void
		{
			_mod = value;
		}
		
		public function get animationMachine():ArmyAnimationMachine 
		{
			return _animationMachine;
		}
		
		public function set animationMachine(value:ArmyAnimationMachine):void 
		{
			_animationMachine = value;
		}
	
	}

}