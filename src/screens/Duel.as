package screens
{
	import codex.characters.Character;
	import codex.characters.General;
	import codex.characters.Skill;
	import displayable.CharacterDisplay;
	import displayable.Console;
	import displayable.DuelCharacterDisplay;
	import displayable.LtChooser;
	import displayable.SkillChooser;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
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
	/**
	 * ...
	 * @author Olivier
	 */
	public class Duel extends BaseScreen
	{
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Attributes
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		private var round:int = 0;
		private var step:int = 0;
		private var InitiativeArray:Array = null;
		private var timer:Timer;
		
		
		private var chosenSkill:Skill;
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Displayables
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private var heroDisplay:DuelCharacterDisplay;
		private var heroIcon:HeroIconMC;
		private var ltDisplay:DuelCharacterDisplay;
		private var ltIcon:MovieClip;
		//private var duelbg_mc:DuelBackgroundMC;
		private var console:Console;
		
		
		private var _ltChooser:LtChooser;
		private var _skillChooser:SkillChooser;
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Constructor of the WorldMap Screen
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Duel()
		{
			

			super(new DuelBackgroundMC); //Call the parent constructor
			//This array informs the ScreenFSM the legals screen that could be displayed after this one
			_switchTo = new Array("WorldMap","GameOver");
			
			//Name of the current screen (used by the FSM when it tries to switch to this screen
			_screenName = "Duel";

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
			timer = new Timer(1000 / 24, 0);
			timer.addEventListener(TimerEvent.TIMER, _update);
			timer.start();
			
			Main.managers.Duel.InitDuel();
			Main.managers.Duel.general = Main.managers.Character.hero;

			Main.managers.SoundM.playBGM(Main.BGM4);
			
			view.mouseEnabled = false;
			
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
			heroDisplay.Update(Main.managers.Duel.general);
			heroDisplay.DisplayIcon(HeroIconMC);
			heroIcon = new HeroIconMC();
			heroIcon.x = 7;
			heroIcon.y = 640;
			heroIcon.width = heroIcon.height = 60 ;

			ltDisplay = new DuelCharacterDisplay(0 , stage.stageHeight);

			Main.managers.Duel.general.animationMachine.x = 200;
			Main.managers.Duel.general.animationMachine.y = 500;

			Main.managers.Duel.enemy.animationMachine.x = 800;
			Main.managers.Duel.enemy.animationMachine.y = 500;
			Main.managers.Duel.enemy.animationMachine.scaleX = -1;

			_ltChooser = new LtChooser();
			_ltChooser.x = stage.stageWidth / 2;
			_ltChooser.y = stage.stageHeight / 2;
			_ltChooser.addEventListener(MouseEvent.CLICK, _onLtChoosed);
			
			_skillChooser = new SkillChooser();
			_skillChooser.x = 200;
			_skillChooser.y = 200;
			_skillChooser.visible = false;
			//Adding displayables to stage
			
			_view.addChild(console);
			_view.addChild(heroDisplay);
			_view.addChild(heroIcon);
			_view.addChild(Main.managers.Duel.general.animationMachine);
			_view.addChild(Main.managers.Duel.enemy.animationMachine);
			_view.addChild(_skillChooser);
			
			
			
			LtChoiceScreenGeneration();
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Core Functions (these functions manage the switch between initiative turns
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function LtChoiceScreenGeneration():void
		{
			
			view.addChild(_ltChooser);
			
		}
		
		private function _onLtChoosed(e:MouseEvent):void
		{
			trace (e.target);
			if (e.target == _ltChooser.view.lt1Icon_mc || e.target == _ltChooser.view.lt2Icon_mc || e.target == _ltChooser.view.lt3Icon_mc)
			{
				
				_ltChooser.removeEventListener(MouseEvent.CLICK, _onLtChoosed);
				view.removeChild(_ltChooser);
				
				
				switch(e.target)
				{
					case _ltChooser.view.lt1Icon_mc:
						Main.managers.Duel.lieutenant = Main.managers.Character.lt1;
						ltIcon = new Lt1IconMC;
						break;
					case _ltChooser.view.lt2Icon_mc:
						Main.managers.Duel.lieutenant = Main.managers.Character.lt2;
						ltIcon = new Lt2IconMC;
						break;
					case _ltChooser.view.lt3Icon_mc:
						Main.managers.Duel.lieutenant = Main.managers.Character.lt3;
						ltIcon = new Lt3IconMC;
						break;
				}
				
				Main.managers.Duel.lieutenant.SetSkillKnown();
				Main.managers.Duel.general.SetSkillKnown();
				Main.managers.Duel.enemy.SetSkillKnown();
				
				ltDisplay.Update(Main.managers.Duel.lieutenant);
				ltDisplay.DisplayIcon(HeroIconMC);
				ltDisplay.x = 0;
				ltDisplay.y = 0;
				
				view.addChild(ltDisplay);
				
				ltIcon.y = -ltDisplay.height + 5;
				ltIcon.x = 10;
				ltIcon.width = ltIcon.height = 60 ;
				ltDisplay.view.addChild(ltIcon);
				
				Main.managers.Duel.lieutenant.animationMachine.x = 150;
				Main.managers.Duel.lieutenant.animationMachine.y = 600;
				view.addChild(Main.managers.Duel.lieutenant.animationMachine);
				InitTurnManager();
			}
		}
		
		private function InitTurnManager():void
		{
			if (InitiativeArray == null)
			{
				InitiativeArray = Main.managers.Duel.calculateInitiativeArray();
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
			switch(getQualifiedClassName(InitiativeArray[step]))
			{
				case getQualifiedClassName(ChooseSkillGeneralState):
					GeneralSkillChoiceScreenGeneration();
					break;
				case getQualifiedClassName(ChooseSkillLieutenantState):
					LtSkillChoiceScreenGeneration();
					break;
				case getQualifiedClassName(ChooseSkillEnemyState):
					EnemySkillChoiceScreenGeneration();
					break;
			}
		}
		
		private function GeneralSkillChoiceScreenGeneration():void
		{
			trace("GeneralSkillChoiceScreenGeneration");
			_skillChooser.SetUp(Main.managers.Duel.general as Character);
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
					case _skillChooser.view.skillButton1_mc:
						chosenSkill = _skillChooser.skills[1];
						break;
					case _skillChooser.view.skillButton1_mc:
						chosenSkill = _skillChooser.skills[2];
						break;
				}
				Main.managers.Duel.general.removeMana(chosenSkill.cost);
				Main.managers.Duel.enemy.removeLife(chosenSkill.multiplicator * Main.managers.Duel.general.statsArray[chosenSkill.originStat]);
				chosenSkill.effectAnim.x = 200;
				chosenSkill.effectAnim.y = 200;
				view.addChild(chosenSkill.effectAnim);
				InitTurnManager();
			}
			
		}
		
		private function LtSkillChoiceScreenGeneration():void
		{
			trace("LtSkillChoiceScreenGeneration");
			_skillChooser.SetUp(Main.managers.Duel.lieutenant);
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
					case _skillChooser.view.skillButton1_mc:
						chosenSkill = _skillChooser.skills[1];
						break;
					case _skillChooser.view.skillButton1_mc:
						chosenSkill = _skillChooser.skills[2];
						break;
				}
				Main.managers.Duel.lieutenant.removeMana(chosenSkill.cost);
				Main.managers.Duel.enemy.removeLife(chosenSkill.multiplicator * Main.managers.Duel.lieutenant.statsArray[chosenSkill.originStat]);
				chosenSkill.effectAnim.x = 200;
				chosenSkill.effectAnim.y = 200;
				view.addChild(chosenSkill.effectAnim);
				InitTurnManager();
			}
		}
		
		private function EnemySkillChoiceScreenGeneration():void
		{
			trace("EnemySkillChoiceScreenGeneration");
			_skillChooser.SetUp(Main.managers.Duel.enemy as Character);
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
					case _skillChooser.view.skillButton1_mc:
						chosenSkill = _skillChooser.skills[1] ;
						break;
					case _skillChooser.view.skillButton1_mc:
						chosenSkill = _skillChooser.skills[2];
						break;
				}
				
				Main.managers.Duel.enemy.removeMana(chosenSkill.cost);
				Main.managers.Duel.general.removeLife(chosenSkill.multiplicator * Main.managers.Duel.enemy.statsArray[chosenSkill.originStat]);
				chosenSkill.effectAnim.x = 200;
				chosenSkill.effectAnim.y = 200;
				view.addChild(chosenSkill.effectAnim);
				InitTurnManager();
			}
		}
		
		private function WinScreenGeneration():void
		{
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
			heroDisplay.Update(Main.managers.Duel.general);
			if(Main.managers.Duel.lieutenant != null)
				ltDisplay.Update(Main.managers.Duel.lieutenant);
		}

		private function _onClickHandler(e:MouseEvent):void
		{
			dispatchEvent(new ScreenEvents(ScreenEvents.DESTROYED, "WorldMap", true, true));
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Helpers Functions
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function CheckWinOrLoose():Boolean
		{
			if ( (round == 3))
			{
				WinScreenGeneration();
				return true;
			}
			if (Main.managers.Duel.general.isDead)
			{
				return true;
			}
			return false;
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				called when _view is removed from stage
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function end():void
		{
			super.end();
		}

	}

}