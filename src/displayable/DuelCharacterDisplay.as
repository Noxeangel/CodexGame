package displayable 
{
	import codex.characters.Character;
	import flash.display.MovieClip;
	import managers.TextManager;
	/**
	 * ...
	 * @author Olivier
	 */
	public class DuelCharacterDisplay extends MovieClip 
	{
		
		private var _view:DuelCharacterDispalyMC = new DuelCharacterDispalyMC();
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Basic Attributes
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private var _currentLife:int = 100;
		private var _maxLife:int = 100;
		//private var _icon:MovieClip;
		private var _currentMana:int = 100;
		private var _maxMana:int = 100;

		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Constructor
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function DuelCharacterDisplay(x:int = 0,y:int = 0) 
		{
			_view = new DuelCharacterDispalyMC();
			_view.x = x;
			_view.y = y

			_view.lifeLine_txt.text =Main.managers.Text.GetText(TextManager.HP);
			_view.manaLine_txt.text =Main.managers.Text.GetText(TextManager.MP);
			
			addChild(_view);
			
			_view.mouseChildren = false;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Setters and Gettes
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		public function set currentLife(value:int):void 
		{
			_currentLife = value;
			UpdateLifeDisplay();
		}
		
		public function set maxLife(value:int):void 
		{
			_maxLife = value;
			UpdateLifeDisplay();
		}
		
		public function set currentMana(value:int):void 
		{
			_currentMana = value;
			UpdateManaDisplay();
		}
		
		public function set maxMana(value:int):void 
		{
			_maxMana = value;
			UpdateManaDisplay();
		}
		
		public function get view():DuelCharacterDispalyMC 
		{
			return _view;
		}
		
		public function set view(value:DuelCharacterDispalyMC):void 
		{
			_view = value;
		}
		

		/*
		public function get icon():MovieClip 
		{
			return _icon;
		}
		
		public function set icon(value:MovieClip):void 
		{
			_icon = value;
		}
		*/
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Custom Function
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function DisplayIcon(c:Class):void
		{
			/*
			_view.removeChild(_view.blankIcon_mc);
			_view.blankIcon_mc = new c() as MovieClip;
			_view.blankIcon_mc.x = 5;
			_view.blankIcon_mc.y = 5;
			_view.blankIcon_mc.width = 80;
			_view.blankIcon_mc.height = 80;
			_view.addChild(_view.blankIcon_mc);
			*/
		}
		
		public function Update(character:Character):void
		{
			_maxLife = character.vitalsArray[Main.LIFE].maxValue;
			_maxMana = character.vitalsArray[Main.MANA].maxValue;
			_currentLife = character.vitalsArray[Main.LIFE].curValue;
			_currentMana = character.vitalsArray[Main.MANA].curValue;

			UpdateLifeDisplay();
			UpdateManaDisplay();
		}
		
		private function UpdateLifeDisplay():void
		{
			var s:String = _currentLife.toString() + "/" + _maxLife.toString();
			if (_view.lifeField_txt != null)
			{
				_view.lifeField_txt.text = s;
			}
			
			//TODO remove this AdjustBar function from the MC class for better encapsulation
			AdjustLifeBar(_maxLife, _currentLife);
		}
		
		private function UpdateManaDisplay():void
		{
			var s:String = _currentMana.toString() + "/" + _maxMana.toString();
			if (_view.manaField_txt != null)
			{
				_view.manaField_txt.text = s;
			}
			
			//TODO remove this AdjustBar function from the MC class for better encapsulation
			AdjustManaBar(_maxMana, _currentMana);
		}
		
		public function AdjustManaBar(maxRange:int, currentRange:int):void
		{
			_view.manaBar_mc.bar_core_mc.scaleX = currentRange / maxRange;
		}
		public function AdjustLifeBar(maxRange:int, currentRange:int):void
		{
			_view.lifeBar_mc.bar_core_mc.scaleX = currentRange / maxRange;
		}
		
	}

}