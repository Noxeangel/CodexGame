package managers
{
	import codex.armies.Army;
	import codex.characters.Archetype;
	import codex.characters.General;
	import codex.characters.Character
	import codex.characters.Skill;
	import events.ManagerEvent;
	import flash.display.MovieClip;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author Olivier
	 * @usage this class holds all the methods related to the characters (mostly the constructor) and the CharacterObjects of the hero and its lieutenants and armies
	 * @usage created once in the Global Manager singleton class
	 */
	
	public class CharacterManager extends MovieClip
	{

		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Basic Constants
		///////////////////////////////////////////////////////////////////////////////////////////////////////

		private const GENERAL:int = 0; //These constants simplifies the use of the indexes of the archList Array
		private const PRIEST:int = 1; //These constants simplifies the use of the indexes of the archList Array
		private const ASSASSIN:int = 2; //These constants simplifies the use of the indexes of the archList Array
		private const WIZZARD:int = 3; //These constants simplifies the use of the indexes of the archList Array

		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Skills Array where duel skills and war skills are stored after loading of the XML Data
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public var duelSkillsArray:Array = new Array();
		public var warSkillsArray:Array = new Array();
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Archetypes and Array where the archetypes are stored after loading of the XML Data
		///////////////////////////////////////////////////////////////////////////////////////////////////////

		private var archList:Array = new Array();
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Hero, Lieutenants and Army Corps
		///////////////////////////////////////////////////////////////////////////////////////////////////////										
		
		private var _hero:General = new General();
		
		private var _lt1:Character = new Character();
		private var _lt2:Character = new Character();
		private var _lt3:Character = new Character();
		
		private var _army:Army = new Army();
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Ennemies and enemy Army Corps
		///////////////////////////////////////////////////////////////////////////////////////////////////////	
		
		public var enemies:Array = new Array(); //Array of arrays : first item = general Character object, second item = Army Object
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Basic Constructor
		///////////////////////////////////////////////////////////////////////////////////////////////////////	
		
		public function CharacterManager()
		{
		
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Init function, called by the init function of the global manager
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Init():void
		{
			archList = new Array();
			_hero = new General();
			_lt1 = new Character();
			_lt2 = new Character();
			_lt3 = new Character();
			
			_army = new Army();
			enemies = new Array();
			
			processArchetypeXML();
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Archetypes XML Data Loading Function
		///////////////////////////////////////////////////////////////////////////////////////////////////////	

		private function processArchetypeXML():void
		{

			var ArchetypeXMLFile:XML = Main.ArchetypeXMLFile;
			
			var i:int = 0;
			
			for each(var archNode:XML in ArchetypeXMLFile.ARCHETYPE)	
			{	
				var tmpArch:Archetype = new Archetype("tmp");
				
				tmpArch.id =  archNode.@ID;
				tmpArch.name = archNode.NAME;
				
				tmpArch.vitalsMult[Main.LIFE] = archNode.LIFEMULT;
				tmpArch.vitalsMult[Main.MANA] = archNode.MANAMULT;
				
				tmpArch.statMult[Main.STRENGTH] = archNode.STRMULT;
				tmpArch.statMult[Main.CONSTITUTION] = archNode.CONMULT;
				tmpArch.statMult[Main.WILLPOWER] = archNode.WILMULT;
				tmpArch.statMult[Main.INTELLIGENCE] = archNode.INTMULT;
				tmpArch.statMult[Main.CHARISMA] = archNode.CHAMULT;
				tmpArch.statMult[Main.AGILITY] = archNode.AGIMULT;
				
				tmpArch.hasPhyFightWithTroops = (archNode.PHYTROOPSATTACK) == "1" ? true : false;
				tmpArch.hasMagFightWithTroops = (archNode.MAGTROOPSATTACK) == "1" ? true : false;
				tmpArch.hasTalkTroops = (archNode.TALKTROOPS) == "1" ? true : false;
				tmpArch.hasHealTroops = (archNode.HEALTROOPS) == "1" ? true : false;
				tmpArch.hasKillGeneral = (archNode.KILLGENERAL) == "1" ? true : false;
				tmpArch.hasSpellTroops = (archNode.SPELLTROOPS) == "1" ? true : false;
				
				tmpArch.hasPhyAttack = (archNode.PHYATTACK) == "1" ? true : false;
				tmpArch.hasMagAttack = (archNode.MAGATTACK) == "1" ? true : false;
				tmpArch.hasSpecialTech = (archNode.SPECIALTECH) == "1" ? true : false;
				tmpArch.hasObjectUse = (archNode.OBJECTUSE) == "1" ? true : false;
				tmpArch.hasHeal = (archNode.HEAL) == "1" ? true : false;
				tmpArch.hasProtect = (archNode.PROTECT) == "1" ? true : false;
				tmpArch.hasMagic = (archNode.MAGIC) == "1" ? true : false;
				//trace(tmpArch.name);
				archList[i] = tmpArch;
				//(archList[i] as Archetype).DebugTrace();
				i++;
				
				//archList.push(tmpArch);
			}
			processSkillXML();
			ArchetypeXMLFile.length = 0;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Skill XML Data Loading Function
		///////////////////////////////////////////////////////////////////////////////////////////////////////	

		private function processSkillXML():void
		{
			var SkillXMLFile:XML = Main.SkillXMLFile;
			
			var i:int;
			for each (var skillNode:XML in SkillXMLFile.SKILL)
			{
				var skill:Skill = new Skill();
				
				
				skill.name = skillNode.NAME;
				
				if (skillNode.ISWARSKILL == "0")
				{
					skill.isWarSkill = false;
				}
				else
				{
					skill.isWarSkill = true;
				}
				
				var classDef:Class = getDefinitionByName(SkillXMLFile.SKILL[i].EFFECTCLASS) as Class
				
				if ((classDef))
				{
					
					 skill.effectAnim = new classDef();
				}
				else
				{
					skill.effectAnim = new MovieClip();
				}
				
				skill.targetedVital = (int)(skillNode.TARGETEDVITAL);
				skill.multiplicator = (int)(skillNode.MULTIPLICATOR);
				skill.originStat = (int)(skillNode.ORIGINSTAT);
				
				if (skillNode.HASCOST == "0")
				{
					skill.hasCost = false;
				}
				else
				{
					skill.hasCost = true;
				}
				
				skill.cost = (int)(skillNode.COST);
				skill.costVital = (int)(skillNode.COSTVITAL);
				if (skill.isWarSkill)
				{
					warSkillsArray.push(skill);
				}
				else
				{
					duelSkillsArray.push(skill);
				}
			}

			processEnemyXML();
			SkillXMLFile = null;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Ennemies XML Data Loading Function
		///////////////////////////////////////////////////////////////////////////////////////////////////////	

		private function processEnemyXML():void
		{

			var EnemyXMLFile:XML = Main.EnemyXMLFile;
			
			for each (var enemy:XML in EnemyXMLFile.ENEMY)
			{
				var tmpArray:Array = new Array();
				var tmpGeneral:General = new General();
				var tmpArmy:Army = new Army();
				
				tmpGeneral.id = enemy.GENERAL.ID;
				tmpGeneral.name = enemy.GENERAL.NAME;
				tmpGeneral.level = (int)(enemy.GENERAL.LEVEL) - 1;
				
				tmpGeneral.archetype = archList[Main.GENERAL];
				tmpGeneral.duelSkillArray = duelSkillsArray;
				tmpGeneral.warSkillArray = warSkillsArray;
				tmpGeneral.LevelUp();
				
				tmpArmy.archers.SetUpCorp(Main.ARCHER, (int)(enemy.ARCHERS));
				tmpArmy.lancers.SetUpCorp(Main.LANCER, (int)(enemy.LANCERS));
				tmpArmy.knights.SetUpCorp(Main.KNIGHT, (int)(enemy.KNIGHTS));
				
				tmpArray[0] = tmpGeneral;
				tmpArray[1] = tmpArmy;
				tmpArray[2] = enemy.POSITION;
				
				enemies.push(tmpArray);
			}
			
			InitCharacters();
			EnemyXMLFile = null;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Init Characters and Armies
		///////////////////////////////////////////////////////////////////////////////////////////////////////	
		
		public function InitCharacters():void
		{
			_hero.name = "HERO";
			_hero.id = "001";
			_hero.level = 0;
			_hero.archetype = archList[Main.GENERAL];
			_hero.duelSkillArray = duelSkillsArray;
			_hero.warSkillArray = warSkillsArray;
			_hero.LevelUp();
			_hero.characterIcon = new HeroIconMC();
			_hero.SetSkillKnown();
			_hero.currentPosition = 0;
			
			_lt1.name = "PRIEST";
			_lt1.id = "002";
			_lt1.level = 0;
			_lt1.archetype = archList[Main.PRIEST];
			_lt1.duelSkillArray = duelSkillsArray;
			_lt1.warSkillArray = warSkillsArray;
			_lt1.LevelUp();
			_lt1.characterIcon = new Lt1IconMC;
			_lt1.SetSkillKnown();
			
			_lt2.name = "ASSASSIN";
			_lt2.id = "003";
			_lt2.level = 0;
			_lt2.archetype = archList[Main.ASSASSIN];
			trace (_lt2.archetype.name);
			_lt2.duelSkillArray = duelSkillsArray;
			_lt2.warSkillArray = warSkillsArray;
			_lt2.LevelUp();
			_lt2.characterIcon = new Lt2IconMC;
			_lt2.SetSkillKnown();
			
			_lt3.name = "WIZZARD";
			_lt3.id = "004";
			_lt3.level = 0;
			_lt3.archetype = archList[Main.WIZZARD];
			_lt3.duelSkillArray = duelSkillsArray;
			_lt3.duelSkillArray = duelSkillsArray;
			_lt3.LevelUp();
			_lt3.characterIcon = new Lt3IconMC;
			_lt3.SetSkillKnown();
			
			InitArmy();
		}
		
		public function InitArmy():void
		{
			army.SetArmyCorps(50, 30, 50);
			
			
		}
		
		
		public function returnGeneralFromLevel(id:String):General
		{
			for each (var tmpGeneralArray:Array in enemies)
			{
				if ( tmpGeneralArray[2] == id)
				{
					return tmpGeneralArray[0];
				}
			}
			return null;
		}
		
		public function get hero():General 
		{
			return _hero;
		}
		
		public function set hero(value:General):void 
		{
			_hero = value;
		}
		
		public function get lt1():Character 
		{
			return _lt1;
		}
		
		public function set lt1(value:Character):void 
		{
			_lt1 = value;
		}
		
		public function get lt2():Character 
		{
			return _lt2;
		}
		
		public function set lt2(value:Character):void 
		{
			_lt2 = value;
		}
		
		public function get lt3():Character 
		{
			return _lt3;
		}
		
		public function set lt3(value:Character):void 
		{
			_lt3 = value;
		}
		
		public function get army():Army 
		{
			return _army;
		}
		
		public function set army(value:Army):void 
		{
			_army = value;
		}
	}

}