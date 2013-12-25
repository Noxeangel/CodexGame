package codex.armies
{
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class Army
	{
		private var _lancers:ArmyCorp = new ArmyCorp();
		private var _archers:ArmyCorp = new ArmyCorp();
		private var _knights:ArmyCorp = new ArmyCorp();
		
		public function Army()
		{
		
		}
		
		public function rest():void
		{
			_lancers.rest();
			_archers.rest();
			_knights.rest();
		}
		
		public function SetArmyCorps(lancerMax:int, archersMax:int, knightsMax:int):void
		{
			_lancers.SetUpCorp(Main.LANCER, lancerMax);
			_archers.SetUpCorp(Main.ARCHER, archersMax);
			_knights.SetUpCorp(Main.KNIGHT, knightsMax);
		}
		
		public function retrunCorpByID(type:int):ArmyCorp
		{
			var tmp:ArmyCorp = new ArmyCorp();
			
			switch (type)
			{
				case Main.LANCER: 
					tmp = _lancers;
					break;
				case Main.ARCHER: 
					tmp = _archers;
					break;
				case Main.KNIGHT: 
					tmp = _knights;
					break;
			}
			
			return tmp;
		}
		
		public function get lancers():ArmyCorp
		{
			return _lancers;
		}
		
		public function set lancers(value:ArmyCorp):void
		{
			_lancers = value;
		}
		
		public function get archers():ArmyCorp
		{
			return _archers;
		}
		
		public function set archers(value:ArmyCorp):void
		{
			_archers = value;
		}
		
		public function get knights():ArmyCorp
		{
			return _knights;
		}
		
		public function set knights(value:ArmyCorp):void
		{
			_knights = value;
		}
	
	}

}