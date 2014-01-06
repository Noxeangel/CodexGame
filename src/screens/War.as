package screens
{
	import codex.armies.Army;
	import codex.characters.Character;
	import codex.characters.General;
	import codex.characters.Skill;
	import displayable.ArmyChooser;
	import displayable.CharacterDisplay;
	import displayable.Console;
	import displayable.DuelCharacterDisplay;
	import displayable.FadingText;
	import displayable.LtChooser;
	import displayable.SkillChooser;
	import displayable.TargetChooser;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import events.AnimStateEvent;
	import events.ScreenEvents;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import screens.FSM.DuelFSM.ChooseSkillEnemyState;
	import screens.FSM.DuelFSM.ChooseSkillGeneralState;
	import screens.FSM.DuelFSM.ChooseSkillLieutenantState;
	import flash.ui.Keyboard;

	/**
	 * ...
	 * @author Olivier
	 */
	public class War extends BaseScreen
	{
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Attributes
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		private var round:int = 0;
		private var step:int = 0;
		private var InitiativeArray:Array = null;
		private var timer:Timer;
		
		private var chosenSkill:Skill;
		private var chosenTarget:Character;
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Displayables
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private var heroDisplay:DuelCharacterDisplay;
		private var heroIcon:HeroIconMC;
		private var ltDisplay:DuelCharacterDisplay;
		private var ltIcon:MovieClip;
		private var console:Console;
		
		
		private var _ltChooser:LtChooser;
		private var _armyChooser:ArmyChooser;
		private var _skillChooser:SkillChooser;
		private var _targetChooser:TargetChooser;
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Protagonists
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private var hero:General;
		private var lieutenant:Character;
		private var enemy:General;
		
		private var allyArmy:Army;
		private var enemyArmy:Army;
		
		private var selectedAllyArmyCorp:int;
		private var selectedEnemyArmyCorp:int;
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Constructor of the WorldMap Screen
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function War()
		{
			super(new DuelBackgroundMC); //Call the parent constructor
			//This array informs the ScreenFSM the legals screen that could be displayed after this one
			_switchTo = new Array("Duel","GameOver");
			
			//Name of the current screen (used by the FSM when it tries to switch to this screen
			_screenName = "War";
			
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Getter of the _view (BG of the screen)
		///////////////////////////////////////////////////////////////////////////////////////////////////////

		public function get view():DuelBackgroundMC
		{
			return _view as DuelBackgroundMC;
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Called when _view is added to screen
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override protected function onViewReady(e:Event):void
		{
			super.onViewReady(e);
			Init();
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Initialization of all the screen related variables (non displayables variables only)
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Init():void
		{
			//Init the protagonists by copying characters from the Character Manager
			hero = Main.managers.Character.hero;
			
			if ( Main.managers.Character.returnGeneralFromLevel(Main.managers.Level.getIDByIndex(Main.managers.Level.currentLocation)) != null)
			{
				enemy = Main.managers.Character.returnGeneralFromLevel(Main.managers.Level.getIDByIndex(Main.managers.Level.currentLocation));
			}
			else
			{
				throw new Error("No ennemy in this level, consult Enemies.XML for more details");
			}
			
			allyArmy = Main.managers.Character.army;
			enemyArmy = Main.managers.Character.returnEnemyArmyFromLevel(Main.managers.Level.getIDByIndex(Main.managers.Level.currentLocation));
			
			//init the Timer which will call the _update function
			timer = new Timer(1000 / 24, 0);
			timer.addEventListener(TimerEvent.TIMER, _update);
			timer.start();
			
			//Launch the BGM
			Main.managers.SoundM.playBGM(Main.BGM_DUEL);
			
			//
			view.mouseEnabled = false;
			
			//DEBUG
			stage.addEventListener(KeyboardEvent.KEY_UP, _onDebugSkip);
			
			
			GenerateScreen();
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Set up and add to stage the dynamic displayable objects
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function GenerateScreen():void
		{
			console = new Console();
			console.x = (stage.stageWidth  ) / 2;
			console.y = stage.stageHeight;

			heroDisplay = new DuelCharacterDisplay(0, stage.stageHeight - 65);
			heroDisplay.Update(hero);
			heroDisplay.DisplayIcon(HeroIconMC);
			heroIcon = new HeroIconMC();
			heroIcon.x = 7;
			heroIcon.y = 640;
			heroIcon.width = heroIcon.height = 60 ;

			ltDisplay = new DuelCharacterDisplay(0 , stage.stageHeight);

			hero.animationMachine.x = 300;
			hero.animationMachine.y = 500;
			hero.animationMachine.scaleX = hero.animationMachine.scaleY = 0.5;
			
			enemy.animationMachine.x = 700;
			enemy.animationMachine.y = 500;
			enemy.animationMachine.scaleX = enemy.animationMachine.scaleY = 0.5;
			enemy.animationMachine.scaleX = -0.5;

			_ltChooser = new LtChooser();
			_ltChooser.x = stage.stageWidth / 2;
			_ltChooser.y = 100;
			_ltChooser.addEventListener(MouseEvent.CLICK, _onLtChoosed);
			
			_armyChooser = new ArmyChooser();
			_armyChooser.x = stage.stageWidth / 2;
			_armyChooser.y = 100;
			_armyChooser.addEventListener(MouseEvent.CLICK, _armyChoosed);
			
			_skillChooser = new SkillChooser();
			_skillChooser.x = 0;
			_skillChooser.y = stage.stageHeight - 2* heroDisplay.height - _skillChooser.height;
			_skillChooser.visible = false;
			
			_targetChooser = new TargetChooser();
			_targetChooser.x = _skillChooser.width;
			_targetChooser.y = stage.stageHeight - 2 * heroDisplay.height - _targetChooser.height;
			_targetChooser.visible = false;
			
			//Adding displayables to stage
			_view.addChild(console);
			_view.addChild(heroDisplay);
			_view.addChild(heroIcon);
			_view.addChild(hero.animationMachine);
			_view.addChild(enemy.animationMachine);
			_view.addChild(_skillChooser);
			_view.addChild(_targetChooser);
			
			//DEBUG TUTO
			_view.addChild(new FadingText("DEBUG: War system is not fonctional at all \n Press Enter to go to Duel Screen", stage.stageWidth / 2, stage.stageHeight / 2 - 200, 15, 20, 0xFF0000));
			
			
			LtChoiceScreenGeneration();
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Lieutenant choice functions (appends once at the begining of the Duel)
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function LtChoiceScreenGeneration():void
		{
			
			view.addChild(_ltChooser);
			
		}
		
		private function _onLtChoosed(e:MouseEvent):void
		{
			//trace (e.target);
			if (e.target == _ltChooser.view.lt1Icon_mc || e.target == _ltChooser.view.lt2Icon_mc || e.target == _ltChooser.view.lt3Icon_mc)
			{
				
				_ltChooser.removeEventListener(MouseEvent.CLICK, _onLtChoosed);
				view.removeChild(_ltChooser);
				
				
				switch(e.target)
				{
					case _ltChooser.view.lt1Icon_mc:
						lieutenant = Main.managers.Character.lt1;
						ltIcon = new Lt1IconMC;
						break;
					case _ltChooser.view.lt2Icon_mc:
						lieutenant = Main.managers.Character.lt2;
						ltIcon = new Lt2IconMC;
						break;
					case _ltChooser.view.lt3Icon_mc:
						lieutenant = Main.managers.Character.lt3;
						ltIcon = new Lt3IconMC;
						break;
				}
				
				lieutenant.SetSkillKnown();
				hero.SetSkillKnown();
				enemy.SetSkillKnown();
				
				ltDisplay.Update(lieutenant);
				ltDisplay.DisplayIcon(HeroIconMC);
				ltDisplay.x = 0;
				ltDisplay.y = 0;
				
				view.addChild(ltDisplay);
				
				ltIcon.y = -ltDisplay.height + 5;
				ltIcon.x = 10;
				ltIcon.width = ltIcon.height = 60 ;
				ltDisplay.view.addChild(ltIcon);
				
				lieutenant.animationMachine.x = 150;
				lieutenant.animationMachine.y = 500;
				lieutenant.animationMachine.scaleX = lieutenant.animationMachine.scaleY = 0.5;
				
				view.addChild(lieutenant.animationMachine);
				ArmyChoiceScreenGeneration();
			}
		}
		
		private function ArmyChoiceScreenGeneration():void
		{
			
			view.addChild(_armyChooser);
			
		}
		
		private function _armyChoosed(e:MouseEvent):void
		{
			//trace (e.target);
			if (e.target == _armyChooser.view.army1Icon_mc || e.target == _armyChooser.view.army2Icon_mc || e.target == _armyChooser.view.army3Icon_mc)
			{
				
				_armyChooser.removeEventListener(MouseEvent.CLICK, _onLtChoosed);
				view.removeChild(_armyChooser);
				if ( allyArmy.retrunCorpByID(selectedAllyArmyCorp).animationMachine.parent )
				{
					view.removeChild(allyArmy.retrunCorpByID(selectedAllyArmyCorp).animationMachine);
				}
				
				switch(e.target)
				{
					case _armyChooser.view.army1Icon_mc:
						selectedAllyArmyCorp = Main.LANCER;
						break;
					case _armyChooser.view.army2Icon_mc:
						selectedAllyArmyCorp = Main.ARCHER;
						break;
					case _armyChooser.view.army3Icon_mc:
						selectedAllyArmyCorp = Main.KNIGHT;
						break;
				}
				allyArmy.retrunCorpByID(selectedAllyArmyCorp).animationMachine.x = 300;
				allyArmy.retrunCorpByID(selectedAllyArmyCorp).animationMachine.y = 400;
				allyArmy.retrunCorpByID(selectedAllyArmyCorp).animationMachine.Init(2, allyArmy.retrunCorpByID(selectedAllyArmyCorp).currentNumber);
				view.addChild(allyArmy.retrunCorpByID(selectedAllyArmyCorp).animationMachine);
				InitTurnManager();
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Core of the initiative turn process
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function InitTurnManager():void
		{
			if (InitiativeArray == null)
			{
				InitiativeArray = Main.managers.War.calculateInitiativeArray();
			}
			
			if (CheckWinOrLoose())
			{
				return;
			}
			
			step ++;
			if ( step >= InitiativeArray.length)
			{
				step = 0;
				round ++;
			}
			switch(InitiativeArray[step])
			{
				case "allyArmy":
					ArmyChoiceScreenGeneration();
					break;
				case "general":
					GeneralSkillChoiceScreenGeneration();
					break;
				case "lieutenant":
					LtSkillChoiceScreenGeneration();
					break;
				case "enemyArmy":
					EnemeyArmyScreenGeneration();
					break
				case "enemy":
					EnemySkillChoiceScreenGeneration();
					break;
			}
		}
		
		private function EnemeyArmyScreenGeneration():void 
		{
			InitTurnManager();
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Hero turn managing functions
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function GeneralSkillChoiceScreenGeneration():void
		{
			chosenSkill = null;
			chosenTarget = null;
			//trace("GeneralSkillChoiceScreenGeneration");
			_skillChooser.SetUp(hero as Character);
			_skillChooser.visible = true;
			_skillChooser.addEventListener(MouseEvent.CLICK, _onGeneralSkillChoosed);
		}
		
		private function _onGeneralSkillChoosed(e:MouseEvent):void
		{
			if (e.target == _skillChooser.view.skillButton1_mc || e.target == _skillChooser.view.skillButton2_mc || e.target == _skillChooser.view.skillButton3_mc)
			{
				_skillChooser.visible = false;
				_skillChooser.removeEventListener(MouseEvent.CLICK, _onGeneralSkillChoosed);
				
				
				switch(e.target)
				{
					case _skillChooser.view.skillButton1_mc:
						chosenSkill = _skillChooser.skills[0] ;
						break;
					case _skillChooser.view.skillButton2_mc:
						chosenSkill = _skillChooser.skills[1];
						break;
					case _skillChooser.view.skillButton3_mc:
						chosenSkill = _skillChooser.skills[2];
						break;
				}
				_targetChooser.SetUp(hero,lieutenant,enemy);
				_targetChooser.visible = true;
				_targetChooser.addEventListener(MouseEvent.CLICK, _onGeneralTargetChoosed);
				
			}
			
		}
		private function _onGeneralTargetChoosed(e:MouseEvent):void
		{
			if (e.target == _targetChooser.view.skillButton1_mc || e.target == _targetChooser.view.skillButton2_mc || e.target == _targetChooser.view.skillButton3_mc)
			{
			
				_targetChooser.visible = false;
				_targetChooser.removeEventListener(MouseEvent.CLICK, _onGeneralTargetChoosed);
				
				
				switch(e.target)
				{
					case _targetChooser.view.skillButton1_mc:
						chosenTarget = enemy;
						break;
					case _targetChooser.view.skillButton2_mc:
						chosenTarget = hero;
						break;
					case _targetChooser.view.skillButton3_mc:
						chosenTarget = lieutenant;
						break;
				}
				
				Main.managers.Duel.ApplyAction(hero, chosenTarget, chosenSkill,view);
				
				chosenSkill.effectAnim.x = chosenTarget.animationMachine.x;
				chosenSkill.effectAnim.y = chosenTarget.animationMachine.y;
				chosenSkill.effectAnim.gotoAndPlay(1);
				view.addChild(chosenSkill.effectAnim);
				
				InitTurnManager();
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Lieutenant turn managing functions
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function LtSkillChoiceScreenGeneration():void
		{
			chosenSkill = null;
			chosenTarget = null;
			//trace("LtSkillChoiceScreenGeneration");
			_skillChooser.SetUp(lieutenant);
			_skillChooser.visible = true;
			_skillChooser.addEventListener(MouseEvent.CLICK, _onLtSkillChoosed);
		}
		
		private function _onLtSkillChoosed(e:MouseEvent):void
		{
			
			if (e.target == _skillChooser.view.skillButton1_mc || e.target == _skillChooser.view.skillButton2_mc || e.target == _skillChooser.view.skillButton3_mc)
			{
				_skillChooser.visible = false;
				_skillChooser.removeEventListener(MouseEvent.CLICK, _onLtSkillChoosed);
				
				
				switch(e.target)
				{
					case _skillChooser.view.skillButton1_mc:
						chosenSkill = _skillChooser.skills[0];
						break;
					case _skillChooser.view.skillButton2_mc:
						chosenSkill = _skillChooser.skills[1];
						break;
					case _skillChooser.view.skillButton3_mc:
						chosenSkill = _skillChooser.skills[2];
						break;
				}
				_targetChooser.SetUp(hero,lieutenant,enemy);
				_targetChooser.visible = true;
				_targetChooser.addEventListener(MouseEvent.CLICK, _onLtTargetChoosed);
			}
		}
		
		private function _onLtTargetChoosed(e:MouseEvent):void
		{
			if (e.target == _targetChooser.view.skillButton1_mc || e.target == _targetChooser.view.skillButton2_mc || e.target == _targetChooser.view.skillButton3_mc)
			{
			
				_targetChooser.visible = false;
				_targetChooser.removeEventListener(MouseEvent.CLICK, _onLtTargetChoosed);
				
				
				switch(e.target)
				{
					case _targetChooser.view.skillButton1_mc:
						chosenTarget = enemy;
						break;
					case _targetChooser.view.skillButton2_mc:
						chosenTarget = hero;
						break;
					case _targetChooser.view.skillButton3_mc:
						chosenTarget = lieutenant;
						break;
				}
				
				Main.managers.Duel.ApplyAction(lieutenant, chosenTarget, chosenSkill,view);
				
				chosenSkill.effectAnim.x = chosenTarget.animationMachine.x;
				chosenSkill.effectAnim.y = chosenTarget.animationMachine.y;
				chosenSkill.effectAnim.gotoAndPlay(1);
				view.addChild(chosenSkill.effectAnim);
				InitTurnManager();
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Enemy turn managing functions
		//				TODO: Create a basic IA system
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function EnemySkillChoiceScreenGeneration():void
		{
			chosenSkill = null;
			chosenTarget = null;
			//trace("EnemySkillChoiceScreenGeneration");
			_skillChooser.SetUp(enemy as Character);
			_skillChooser.visible = true;
			_skillChooser.addEventListener(MouseEvent.CLICK, _onEnemySkillChoosed);
		}
		
		private function _onEnemySkillChoosed(e:MouseEvent):void
		{
			
			if (e.target == _skillChooser.view.skillButton1_mc || e.target == _skillChooser.view.skillButton2_mc || e.target == _skillChooser.view.skillButton3_mc)
			{
				_skillChooser.visible = false;
				_skillChooser.removeEventListener(MouseEvent.CLICK, _onEnemySkillChoosed);
				
				
				switch(e.target)
				{
					case _skillChooser.view.skillButton1_mc:
						chosenSkill = _skillChooser.skills[0];
						break;
					case _skillChooser.view.skillButton2_mc:
						chosenSkill = _skillChooser.skills[1] ;
						break;
					case _skillChooser.view.skillButton3_mc:
						chosenSkill = _skillChooser.skills[2];
						break;
				}
				_targetChooser.SetUp(hero,lieutenant,enemy);
				_targetChooser.visible = true;
				_targetChooser.addEventListener(MouseEvent.CLICK, _onLtTargetChoosed);
				
			}
		}
		private function _onEnemyTargetChoosed(e:MouseEvent):void
		{
			if (e.target == _targetChooser.view.skillButton1_mc || e.target == _targetChooser.view.skillButton2_mc || e.target == _targetChooser.view.skillButton3_mc)
			{
			
				_targetChooser.visible = false;
				_targetChooser.removeEventListener(MouseEvent.CLICK, _onEnemyTargetChoosed);
				
				
				switch(e.target)
				{
					case _targetChooser.view.skillButton1_mc:
						chosenTarget = enemy;
						break;
					case _targetChooser.view.skillButton2_mc:
						chosenTarget = hero;
						break;
					case _targetChooser.view.skillButton3_mc:
						chosenTarget = lieutenant;
						break;
				}
				
				Main.managers.Duel.ApplyAction(enemy, chosenTarget, chosenSkill,view);
				
				chosenSkill.effectAnim.x = chosenTarget.animationMachine.x;
				chosenSkill.effectAnim.y = chosenTarget.animationMachine.y;
				chosenSkill.effectAnim.gotoAndPlay(1);
				view.addChild(chosenSkill.effectAnim);
				InitTurnManager();
			}
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Win and Loose screens
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function WinScreenGeneration():void
		{
			hero.LevelUp();
			lieutenant.LevelUp();
			dispatchEvent(new ScreenEvents(ScreenEvents.DESTROYED, "WorldMap", true, true));
		}
		
		private function LooseScreenGeneration():void
		{
			dispatchEvent(new ScreenEvents(ScreenEvents.DESTROYED, "GameOver", true, true));
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Event Handlers
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function _update(e:TimerEvent):void
		{
			if ( hero != null)
			{
				heroDisplay.Update(hero);
			}
			if (lieutenant != null)
			{
				ltDisplay.Update(lieutenant);
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Helpers Functions
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function CheckWinOrLoose():Boolean
		{
			if ( enemy.isDead)
			{
				WinScreenGeneration();
				
				return true;
			}
			if (hero.isDead)
			{
				LooseScreenGeneration();
				return true;
			}
			return false;
		}

		private function AskSurrender():void
		{
			
		}
		
		private function _onDebugSkip(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.SPACE)
			{
				//stage.removeEventListener(KeyboardEvent.KEY_UP, _onDebugSkip);
				
				dispatchEvent(new ScreenEvents(ScreenEvents.DESTROYED, "Duel", true, true));
			}
			
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				called when _view is removed from stage
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function end():void
		{
			Main.managers.Character.hero = hero;
			
			if (lieutenant != null)
			{
				switch (lieutenant.name)
				{
					case (Main.managers.Character.lt1.name):
						Main.managers.Character.lt1 = lieutenant;
						break;
					case (Main.managers.Character.lt2.name):
						Main.managers.Character.lt2 = lieutenant;
						break;
					case (Main.managers.Character.lt3.name):
						Main.managers.Character.lt3 = lieutenant;
						break;	
				}
			}
			
			timer.removeEventListener(TimerEvent.TIMER, _update);
			super.end();
		}

	}

}