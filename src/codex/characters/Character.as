package codex.characters
{
	import codex.items.Accessory;
	import codex.items.Armor;
	import codex.items.Item;
	import codex.items.Weapon;
	import codex.characters.Skill;
	import flash.display.MovieClip;
	import codex.characters.AnimationMachine;
	import int;
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class Character
	{
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Basic Attributes of the class
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private var _characterIcon:MovieClip; //MovieClip icon of a character
		
		private var _animationMachine:AnimationMachine; //Animation Class to display the character durong Duel States and Battle States
		
		private var _isDead:Boolean; //flase if the character is alive
		
		private var _id:String; //ID of the character in the XML save Files
		private var _name:String; //NAme of the character
		
		private var _level:int; //Current Level of the character
		
		private var _archetype:Archetype; //Archetype of he character 
		
		private var _vitalsArray:Array //New version of an holder of all the vitals
		
		private var _statsArray:Array; //New Version of an holder of all the stats
		
		private var _duelSkillArray:Array; //Array thats holds the duel skill known by the character
		private var _warSkillArray:Array; //Array thats holds the war skill known by the character
		
		private var _weaponEquipped:Weapon; //Current Weapon Equipped, can be null
		private var _armorEquipped:Armor; //Current Armor Equipped, can be null
		private var _accesoryEquipped:Accessory; //Current Accessory Equipped, can be null
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Basic Constructor
		//		The constructor is void. The real constructor is in the Character Manager Class
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Character()
		{
			var i:int; //simple counter for for loops
			//Init the Stats
			_statsArray = new Array();
			for (i = 0; i < Main.STATS_NUMBER; i++)
			{
				_statsArray.push(new BaseStat(Main.STATS_NAMES[i]));
			}
			//Init the Vitals
			_vitalsArray = new Array();
			for (i = 0; i < Main.VITALS_NUMBER; i++)
			{
				_vitalsArray.push(new Vital(Main.VITALS_NAMES[i], new BaseStat("empty")));
			}
			_animationMachine = new AnimationMachine();
			
			_duelSkillArray = new Array();
			_warSkillArray = new Array();
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Basic Setters and Getters
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function get characterIcon():MovieClip
		{
			return _characterIcon;
		}
		
		public function set characterIcon(value:MovieClip):void
		{
			_characterIcon = value;
		}
		
		public function get animationMachine():AnimationMachine
		{
			return _animationMachine;
		}
		
		public function set animationMachine(value:AnimationMachine):void
		{
			_animationMachine = value;
		}
		
		public function get isDead():Boolean
		{
			return _isDead;
		}
		
		public function set isDead(value:Boolean):void
		{
			_isDead = value;
		}
		
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
		
		public function get archetype():Archetype
		{
			return _archetype;
		}
		
		public function set archetype(value:Archetype):void
		{
			_archetype = value;
			var i:int;
			for (i = 0; i < Main.STATS_NUMBER; i++)
			{
				_statsArray[i].mult = _archetype.statMult[i];
			}
			for (i = 0; i < Main.VITALS_NUMBER; i++)
			{
				_vitalsArray[i].statMult = _archetype.vitalsMult[i];
			}
			SetSkillKnown();
			SetStats();
		}
		
		public function get level():int
		{
			return _level;
		}
		
		public function set level(value:int):void
		{
			_level = value;
		}
		
		public function get weaponEquipped():Weapon
		{
			return _weaponEquipped;
		}
		
		public function get armorEquipped():Armor
		{
			return _armorEquipped;
		}
		
		public function get accesoryEquipped():Accessory
		{
			return _accesoryEquipped;
		}
		
		public function get vitalsArray():Array
		{
			return _vitalsArray;
		}
		
		public function set vitalsArray(value:Array):void
		{
			_vitalsArray = value;
		}
		
		public function get statsArray():Array
		{
			return _statsArray;
		}
		
		public function set statsArray(value:Array):void
		{
			_statsArray = value;
		}
		
		public function get duelSkillArray():Array
		{
			return _duelSkillArray;
		}
		
		public function set duelSkillArray(value:Array):void
		{
			_duelSkillArray = value;
			SetSkillKnown();
		}
		
		public function get warSkillArray():Array
		{
			return _warSkillArray;
		}
		
		public function set warSkillArray(value:Array):void
		{
			_warSkillArray = value;
			SetSkillKnown();
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Custom Functions
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		//This function is called after each battles and during the cunstruction of a Character Object to set up the attributes based on its Archetype
		public function LevelUp():void
		{
			_level++;
			
			SetStats();
			SetCurVitalsToMaxVitals();
		}
		
		//This function set up the stats according to the multiplicator of the Archetype and of the current modificators (skills or items)
		public function SetStats():void
		{
			
			var i:int;
			for (i = 0; i < Main.STATS_NUMBER; i++)
			{
				_statsArray[i].LevelUp(_level);
			}
			
			_vitalsArray[Main.LIFE].SetVital(_statsArray[Main.CONSTITUTION]);
			_vitalsArray[Main.MANA].SetVital(_statsArray[Main.WILLPOWER]);
		
		}
		
		public function SetCurVitalsToMaxVitals():void
		{
			var i:int;
			
			for (i = 0; i < Main.VITALS_NUMBER; i++)
			{
				_vitalsArray[i].curValue = _vitalsArray[i].maxValue;
			}
		}
		
		public function rest():void
		{
			_vitalsArray[Main.LIFE].curValue = _vitalsArray[Main.LIFE].maxValue;
			_vitalsArray[Main.MANA].curValue = _vitalsArray[Main.MANA].maxValue;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Equipment functions (called when the player changes one piece of equipment
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function ChangeWeapon(item:Weapon):void
		{
			if (item == _weaponEquipped)
			{
				return;
			}
			
			var i:int; //simple counter for for loops
			
			if (_weaponEquipped != null)
			{
				for (i = 0; i < Main.STATS_NUMBER; i++)
				{
					_statsArray[i].mod -= _weaponEquipped.statMods[i];
				}
			}
			_weaponEquipped = item;
			for (i = 0; i < Main.STATS_NUMBER; i++)
			{
				_statsArray[i].mod += _weaponEquipped.statMods[i];
			}
			
			SetStats();
		
		}
		
		public function ChangeAccessory(item:Accessory):void
		{
			if (item == _accesoryEquipped)
			{
				return;
			}
			var i:int; //simple counter for for loops
			if (_accesoryEquipped != null)
			{
				for (i = 0; i < Main.STATS_NUMBER; i++)
				{
					_statsArray[i].mod -= _accesoryEquipped.statMods[i];
				}
			}
			_accesoryEquipped = item;
			for (i = 0; i < Main.STATS_NUMBER; i++)
			{
				_statsArray[i].mod += _accesoryEquipped.statMods[i];
			}
			SetStats();
		
		}
		
		public function ChangeArmor(item:Armor):void
		{
			if (item == _armorEquipped)
			{
				return;
			}
			var i:int; //simple counter for for loops
			if (_armorEquipped != null)
			{
				for (i = 0; i < Main.STATS_NUMBER; i++)
				{
					_statsArray[i].mod -= _armorEquipped.statMods[i];
				}
			}
			_armorEquipped = item;
			for (i = 0; i < Main.STATS_NUMBER; i++)
			{
				_statsArray[i].mod += _armorEquipped.statMods[i];
			}
			SetStats();
		}
		
		public function GetDuelSkillNumber():int
		{
			var i:int = 0;
			for each (var skill:Skill in _duelSkillArray)
			{
				if (skill.isKnown)
				{
					i++;
				}
			}
			return i;
		}
		
		public function GetWarSkillNumber():int
		{
			var i:int = 0;
			for each (var skill:Skill in _warSkillArray)
			{
				if (skill.isKnown)
				{
					i++;
				}
			}
			return i;
		}
		
		public function removeLife(ammount:int):void
		{
			
			(vitalsArray[Main.LIFE] as Vital).curValue -= ammount;
			
			if ((vitalsArray[Main.LIFE] as Vital).curValue <= 0)
			{
				(vitalsArray[Main.LIFE] as Vital).curValue = 0
				isDead = true;
			}
			if ((vitalsArray[Main.LIFE] as Vital).curValue >= (vitalsArray[Main.LIFE] as Vital).maxValue)
			{
				(vitalsArray[Main.LIFE] as Vital).curValue = (vitalsArray[Main.LIFE] as Vital).maxValue;
			}
		}
		
		public function removeMana(ammount:int):void
		{
			
			(vitalsArray[Main.MANA] as Vital).curValue -= ammount;
			
			if ((vitalsArray[Main.MANA] as Vital).curValue <= 0)
			{
				(vitalsArray[Main.MANA] as Vital).curValue = 0
				
			}
			if ((vitalsArray[Main.MANA] as Vital).curValue >= (vitalsArray[Main.MANA] as Vital).maxValue)
			{
				(vitalsArray[Main.MANA] as Vital).curValue = (vitalsArray[Main.MANA] as Vital).maxValue;
			}
		}
		
		public function SetSkillKnown():void
		{
			for each( var tmpSkill:Skill in duelSkillArray)
			{
				switch (tmpSkill.name)
				{
					case "Physical Attack":
						tmpSkill.isKnown = archetype.hasPhyAttack;
						break;
					case "Magical Attack":
						tmpSkill.isKnown = archetype.hasMagAttack;
						break;
					case "Special Technique":
						tmpSkill.isKnown = archetype.hasSpecialTech;
						break;
					case "Object Use":
						tmpSkill.isKnown = archetype.hasObjectUse;
						break;
					case "Heal":
						tmpSkill.isKnown = archetype.hasHeal;
						break;
					case "Protect":
						tmpSkill.isKnown = archetype.hasProtect;
						break;
					case "Magic":
						tmpSkill.isKnown = archetype.hasMagic;
						break;
				}
			}
		}
		
		public function Trace():void
		{
			trace("=======================================");
			trace("=======================================");
			trace("| " + name);
			trace("=======================================");
			trace("| " + vitalsArray[Main.LIFE].name + " " + vitalsArray[Main.LIFE].curValue + "/" + vitalsArray[Main.LIFE].maxValue);
			trace("| " + vitalsArray[Main.MANA].name + " " + vitalsArray[Main.MANA].curValue + "/" + vitalsArray[Main.MANA].maxValue);
			trace("=======================================");
			trace("| " + statsArray[Main.STRENGTH].name +" : "+ statsArray[Main.STRENGTH].finalAmmount);
			trace("| " + statsArray[Main.CONSTITUTION].name +" : "+ statsArray[Main.CONSTITUTION].finalAmmount);
			trace("| " + statsArray[Main.INTELLIGENCE].name +" : "+ statsArray[Main.INTELLIGENCE].finalAmmount);
			trace("| " + statsArray[Main.WILLPOWER].name +" : "+ statsArray[Main.WILLPOWER].finalAmmount);
			trace("| " + statsArray[Main.CHARISMA].name +" : "+ statsArray[Main.CHARISMA].finalAmmount);
			trace("| " + statsArray[Main.AGILITY].name +" : "+ statsArray[Main.AGILITY].finalAmmount);
			trace("=======================================");
			for each(var skill:Skill in duelSkillArray)
			{
				trace("| " + skill.name + " is known? = " + skill.isKnown);
			}
			trace("=======================================");
			archetype.DebugTrace();
			trace("=======================================");
			trace("=======================================");
			trace("***************************************");
		}
		
		public function DebugString():String
		{
			var tmpStr:String = new String();
			for each(var skill:Skill in duelSkillArray)
			{
				tmpStr += ("| " + skill.name + " is known? = " + skill.isKnown);
				tmpStr += '\n';
			}
			return tmpStr;
		}
	
	}

}