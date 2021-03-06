package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.SecurityErrorEvent;
	import flash.media.Sound;
	import flash.net.LocalConnection;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.System;
	import screens.*;
	import events.ScreenEvents;
	import managers.GlobalManager;
	import events.ManagerEvent;
	import flash.utils.getQualifiedClassName;
	import flash.system.Security;
	import flash.net.*
	/**
	 * ...
	 * @author Olivier
	 */
	public class Main extends Sprite
	{
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Global Options Variables
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public static var isKeyboard:int = 0; //Is Input keyboeard or mouse if 0 = mouse
		public static var language:int = 0; //Language set to French if 1 or english if 0
		public static var isTutorial:int = 0; //Is tutorials displayed if 0 false
		public static var bgmVolume:Number = 0.1;	//Voluime of the music
		public static var sfxVolume:Number = 0.1;	//Volume of the effects
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Global Constants used as an enum match a name with an int
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		//===================================================
		//	Vitals Type
		//===================================================
		public static const LIFE:int = 0;
		public static const MANA:int = 1;
		public static const VITALS_NUMBER:int = 2;
		
		public static const VITALS_NAMES:Array = new Array("Life", "Mana");
		
		//===================================================
		//	Stats Type
		//===================================================
		public static const STRENGTH:int = 0;
		public static const CONSTITUTION:int = 1;
		public static const INTELLIGENCE:int = 2;
		public static const WILLPOWER:int = 3;
		public static const CHARISMA:int = 4;
		public static const AGILITY:int = 5;
		public static const STATS_NUMBER:int = 6;
		
		public static const STATS_NAMES:Array = new Array("Strength", "Constitution", "Intelligence", "Willpower", "Charisma", "Agility");
		
		//===================================================
		//	Character Type and Reserved type of an object
		//===================================================
		
		public static const GENERAL:int = 0;
		public static const PRIEST:int = 1;
		public static const ASSASSIN:int = 2;
		public static const WIZZARD:int = 3;
		public static const TROUPS:int = 4;
		public static const ALL:int = 5; //Everybody except troops
		
		//===================================================
		//	Army Corps
		//===================================================
		public static const LANCER:int = 0;
		public static const ARCHER:int = 1;
		public static const KNIGHT:int = 2;
		
		//===================================================
		//	Item Types
		//===================================================
		public static const CONSUMABLE:int = 0;
		public static const WEAPON:int = 1;
		public static const ARMOR:int = 2;
		public static const ACCESSORY:int = 3;
		
		//===================================================
		//	Animation Types
		//===================================================
		
		public static const IDLE:int = 0;
		public static const ATTACK:int = 1;
		public static const SPELL:int = 2;
		public static const DAMAGED:int = 3;
		public static const DEAD:int = 4;
		public static const VICTORY:int = 5;
		public static const ANIM_NUMBER:int = 6;
		public static const ANIM_NONE:int = 666;
		
		//===================================================
		//	War Skills Types
		//===================================================
		public static const PHYSICAL_ATTACK_WITH_TROOPS:int = 0;
		public static const MAGICAL_ATTACK_WITH_TROOPS:int = 1;
		public static const TALK_TO_TROOPS:int = 2;
		public static const HEAL_TROOPS:int = 3;
		public static const KILL_GENERAL:int = 4;
		public static const SPELL_TROOPS:int = 5;
		
		//===================================================
		//	Duel Skills Types
		//===================================================
		
		public static const PHYSICAL_ATTACK:int = 0;
		public static const MAGICAL_ATTACK:int = 1;
		public static const SPECIAL_TECHNIQUE:int = 2;
		public static const OBJECT_USE:int = 3;
		public static const HEAL:int = 4;
		public static const PROTECT:int = 5;
		public static const CAST_SPELL:int = 6;
		
		//===================================================
		//	Sound Manager Tracks id
		//===================================================
		public static const BIP:int = 0;
		
		public static const BGM_MAIN_MENU:int = 1;
		public static const BGM_WORLD_MAP:int = 2;
		public static const BGM_DUEL:int = 3;
		public static const BGM_WAR:int = 4;
		public static const BGM_GAME_OVER:int = 5;
		

		public static const BONUS3:int = 6;
		public static const BONUS4:int = 7;
		
		public static const SFX_HEAL:int = 8;
		public static const ACTION2:int = 9;
		public static const ACTION3:int = 10;
		public static const ACTION4:int = 11;
		
		public static const SFX_SELECT:int = 12;
		public static const SFX_OK:int = 13;
		public static const SFX_NO:int = 14;
		public static const SPECIAL4:int = 15;
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Sound And Music
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		private var req1:URLRequest = new URLRequest("assets/sound/MainMenu.mp3");
		private var mainMenu_bgm:Sound =  new Sound(req1);
		

		private var req2:URLRequest = new URLRequest("assets/sound/Duel.mp3");
		private var duel_bgm:Sound =  new Sound(req2);
		

		private var req3:URLRequest = new URLRequest("assets/sound/War.mp3");
		private var war_bgm:Sound =  new Sound(req3);
		

		private var req4:URLRequest = new URLRequest("assets/sound/WorldMap.mp3");
		private var worldMap_bgm:Sound =  new Sound(req4);
		
		private var req5:URLRequest = new URLRequest("assets/sound/PaperSound.mp3");
		private var Paper_sfx:Sound =  new Sound(req5);
		
		private var req6:URLRequest = new URLRequest("assets/sound/GameOver.mp3");
		private var gameOver_bgm:Sound =  new Sound(req6);
		
		private var req7:URLRequest = new URLRequest("assets/sound/Select.mp3");
		private var select_sfx:Sound =  new Sound(req7);
		
		private var req8:URLRequest = new URLRequest("assets/sound/OK.mp3");
		private var ok_sfx:Sound =  new Sound(req8);
		
		private var req9:URLRequest = new URLRequest("assets/sound/No.mp3");
		private var no_sfx:Sound =  new Sound(req9);
		
		private var req10:URLRequest = new URLRequest("assets/sound/Heal.mp3");
		private var heal_sfx:Sound =  new Sound(req10);
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Global XML Files that store the datas
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public static var ItemXMLFile:XML;
		private const ITEM_XML_FILE_PATH:String = "assets/data/XML/Item.xml";
		
		public static var LevelsXMLFile:XML;
		private const LEVELS_XML_FILE_PATH:String = "assets/data/XML/Levels.xml"; //Path of the xml file which contains the data of the levels		
		
		private const ARCHETYPE_XML_FILE_PATH:String = "assets/data/XML/Archetypes.xml"; //Path of the xml file which contains the data of the archetypes
		public static var ArchetypeXMLFile:XML;
		
		private const SKILLS_XML_FILE_PATH:String = "assets/data/XML/Skills.xml"; //Path to the xml file which contains the data of the skills
		public static var SkillXMLFile:XML;
		
		private const ENEMIES_XML_FILE_PATH:String = "assets/data/XML/Enemies.xml"; //Path to the xml file which contains the data of the enemies
		public static var EnemyXMLFile:XML;
		
		private const TALK_XML_FILE_PATH:String = "assets/data/XML/Talk.xml"; //Path to the xml file which contains the data of the dialogs
		public static var TalkXMLFile:XML;
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Access Point to Manager Singleton
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public static var managers:GlobalManager;
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Current Screen Displayed by the FSM
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private var currentScreen:BaseScreen;
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Constructor
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Main():void
		{
			Security.loadPolicyFile("http://running-panda.fr/flash/codex/pf.xml");
			managers = GlobalManager.getInstance();
			
			if (stage)
			{
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Initialization function
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function init(e:Event = null):void
		{
			
			removeEventListener(Event.ADDED_TO_STAGE, init);

			// config stage
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//stage.quality = StageQuality.LOW;
			stage.stageFocusRect = false;
			stage.tabChildren = false;
			
			addEventListener(ScreenEvents.DESTROYED, _onNextScreen);
				
			currentScreen = new MainMenu();
			addChild(currentScreen);
			
			LoadArchetypeXML();
		}
		public function LoadArchetypeXML():void
		{
			var loader:URLLoader = new URLLoader();
			loader.load(new URLRequest(ARCHETYPE_XML_FILE_PATH));
			loader.addEventListener(Event.COMPLETE, LoadSkillXML);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
			//trace("begin init");
		}
		
		private function onError(e:SecurityErrorEvent):void 
		{
			throw new Error(e.errorID, e.errorID);
		}
		
		public function LoadSkillXML(e:Event):void
		{
			if (e.target.data != null)
			{
				ArchetypeXMLFile = new XML(e.target.data);
			}
			else
			{
				throw new Error("#No data in ArchetypeXMLFile", "#0001");
				return;
			}
			var loader:URLLoader = new URLLoader();
			loader.load(new URLRequest(SKILLS_XML_FILE_PATH));
			loader.addEventListener(Event.COMPLETE, LoadEnnemiesXML);
		}
		public function LoadEnnemiesXML(e:Event):void
		{
			if (e.target.data != null)
			{
				SkillXMLFile = new XML(e.target.data);
			}
			else
			{
				throw new Error("#No data in SkillXMLFile", "#0001");
				return;
			}
			var loader:URLLoader = new URLLoader();
			loader.load(new URLRequest(ENEMIES_XML_FILE_PATH));
			loader.addEventListener(Event.COMPLETE, LoadItemXML);
		}
		public function LoadItemXML(e:Event):void
		{
			if (e.target.data != null)
			{
				EnemyXMLFile = new XML(e.target.data);
			}
			else
			{
				throw new Error("#No data in EnemyXMLFile", "#0001");
				return;
			}
			var loader:URLLoader = new URLLoader();
			loader.load(new URLRequest(ITEM_XML_FILE_PATH));
			loader.addEventListener(Event.COMPLETE, LoadLevels);
		}
		public function LoadLevels(e:Event):void
		{
			
			if (e.target.data != null)
			{
				ItemXMLFile = new XML(e.target.data);
			}
			else
			{
				throw new Error("#No data in ItemXMLFile", "#0001");
				return;
			}
			var loader:URLLoader = new URLLoader();
			loader.load(new URLRequest(LEVELS_XML_FILE_PATH));
			loader.addEventListener(Event.COMPLETE, LoadDialogs);
		}
		private function LoadDialogs(e:Event):void
		{
			if (e.target.data != null)
			{
				LevelsXMLFile = new XML(e.target.data);
			}
			else
			{
				throw new Error("#No data in LevelsXMLFile", "#0001");
				return;
			}
			var loader:URLLoader = new URLLoader();
			loader.load(new URLRequest(TALK_XML_FILE_PATH));
			loader.addEventListener(Event.COMPLETE, InitManagers);
		}
		private function InitManagers(e:Event):void 
		{
			if (e.target.data != null)
			{
				TalkXMLFile = new XML(e.target.data);
			}
			else
			{
				throw new Error("#No data in TalkXMLFile", "#0001");
				return;
			}
			Main.managers.Init();

			Main.managers.SoundM.addRessource(worldMap_bgm, Main.BGM_WORLD_MAP);
			Main.managers.SoundM.addRessource(mainMenu_bgm, Main.BGM_MAIN_MENU);
			Main.managers.SoundM.addRessource(duel_bgm, Main.BGM_DUEL);
			Main.managers.SoundM.addRessource(war_bgm, Main.BGM_WAR);
			Main.managers.SoundM.addRessource(gameOver_bgm, Main.BGM_GAME_OVER);
			Main.managers.SoundM.addRessource(Paper_sfx, Main.BIP);
			Main.managers.SoundM.addRessource(ok_sfx, Main.SFX_OK);
			Main.managers.SoundM.addRessource(no_sfx, Main.SFX_NO);
			Main.managers.SoundM.addRessource(select_sfx, Main.SFX_SELECT);
			Main.managers.SoundM.addRessource(heal_sfx, Main.SFX_HEAL);
			_onInitComplete();
		}
		
		private function _onInitComplete():void 
		{
			addEventListener(ScreenEvents.DESTROYED, _onNextScreen);
			
			currentScreen = new MainMenu();
			addChild(currentScreen);
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Core of the Screen Manager FSM
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function _onNextScreen(e:ScreenEvents):void
		{
			e.stopImmediatePropagation();
			
			if (e.targetScreen != null)
			{
				if (currentScreen.IsSwitchable(e.targetScreen))
				{
					if (currentScreen.stage)
					{
						currentScreen.end();
						removeChild(currentScreen);
						//trace( getQualifiedClassName( currentScreen) + " is removed from stage");
					}
					switch (e.targetScreen)
					{
						case "Intro": 
							currentScreen = new Intro();
							break;
						case "MainMenu": 
							currentScreen = new MainMenu();
							break;
						case "War": 
							currentScreen = new War();
							break;
						case "Duel": 
							currentScreen = new Duel();
							break;
						case "GameOver": 
							currentScreen = new GameOver();
							break;
						case "WorldMap": 
							currentScreen = new WorldMap();
							break;
					}
				}
				else
				{
					throw new Error("#Can't switch to: " + e.targetScreen + " from : " + currentScreen.screenName, "#0001");
				}
			}
			else
			{
				throw new Error("#No next Screen", "#0001");
			}
			
			addChild(currentScreen);
		}
	
	}

}