package screens 
{
	import codex.characters.Character;
	import codex.items.Accessory;
	import codex.items.Armor;
	import codex.items.Item;
	import displayable.ActionPointsCounter;
	import displayable.ArmyDisplay;
	import displayable.CharacterDisplay;
	import displayable.Console;
	import displayable.HUDButton;
	import displayable.InventoryPanel;
	import displayable.PaperButtonLeft;
	import displayable.StatusPanel;
	import displayable.TalkConsole;
	import displayable.TalkScreen;
	import displayable.TurnCounter;
	import displayable.WorldMapMover;
	import codex.items.Consumable;
	import codex.items.Weapon;
	import codex.levels.Level;
	import events.InventoryEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import Main;
	import managers.GlobalManager;
	import managers.TextManager;
	import events.ScreenEvents;
	import events.CharacterDisplayEvent;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author Olivier
	 */
	public class WorldMap extends BaseScreen 
	{
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Attributes of the Screen
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		//Current Location of the Hero (index in the townsData_arr Array)
		private var heroCurrentLocation:int = 0;

		//Action Points 
		private var maxActionPoints:int = 4;
		private var currentActionPoints:int;
		
		//which screen to display after the end of all the out animations
		private var _goToScreen:String = "";
		
		//===================================================
		//	Multiple Data Storage
		//===================================================
		
		//position on the screen of the character displays
		private var characterDisplaysData_arr:Array = new Array();
		
		//position on the screen of the army displays
		private var armyDisplaysData_arr:Array = new Array();
		
		//Positions and texts of the buttons of the in-game menu
		private var buttonsData_arr:Array;	

		//===================================================
		//	Triggers
		//===================================================
		
		//Used to trigger the display of StatusPanle
		private var isheroStatusDisplayed:Boolean = false;
		private var islt1StatusDisplayed:Boolean = false;
		private var islt2StatusDisplayed:Boolean = false;
		private var islt3StatusDisplayed:Boolean = false;
		
		//Used to trigger the display of InventoryPanel
		private var isInventoryPanelDisplayed:Boolean = false;
		
		//===================================================
		//	Displayables
		//===================================================
		//World Map Background
		private var worldMapBackground:WorldMapBackgroundMC = new WorldMapBackgroundMC();
		//buttons of the in-game Menu
		private var buttons_arr:Array = new Array();
		//Status Panel
		private var statusPanel:StatusPanel;
		//Console
		private var console:Console;
		//Inventory Panel
		private var inventory:InventoryPanel;
		//Characters Display
		private var characterDisplays_arr:Array = new Array();
		//Army Display
		private var armyDisplays_arr:Array = new Array();
		//Player icon on world Map
		private var playerIconOnMap:WorldMapPlayerMC = new WorldMapPlayerMC();
		//Action points counter
		private var actionCounter:ActionPointsCounter;
		//Turn counter
		private var turnCounter:TurnCounter;
		private var mover:WorldMapMover;
		//Talk screen
		public var talkScreen:TalkScreen = new TalkScreen();
		public var isTalkScreenDisplayed:Boolean = false;
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Constructor of the WorldMap Screen
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function WorldMap() 
		{
			super(new WorldMapMC);	//Call the parent constructor
			
			//This array informs the FSM the legals screen that could be displayed after this one
			_switchTo = new Array(	"Duel",
									"War",
									"GameOver",
									"MainMenu"
									);
			//Name of the current screen (used by the FSM when it tries to switch to this screen)
			_screenName = "WorldMap";

		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Getter of the _view (BG of the screen)
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function get view():WorldMapMC 
		{
			return _view as WorldMapMC;
		}		
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Called when _view is added to screen
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override protected function onViewReady(e:Event):void
		{
			super.onViewReady(e);
			//trace("WorldMap on viewReady");
			Init();
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Initialization of all the screen related variables (non displayables variables only)
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function Init():void
		{
			//Simple counter variable for the for loops
			var i:int;
			
			addEventListener(InventoryEvent.ACCESSORY_SELECTED, Equip);
			addEventListener(InventoryEvent.WEAPON_SELECTED, Equip);
			addEventListener(InventoryEvent.ARMOR_SELECTED, Equip);
			addEventListener(InventoryEvent.CONSUMABLE_SELECTED, Equip);
			
			//Global click listener of the view
			view.addEventListener(MouseEvent.CLICK, _onClickHandler);
			
			view.addEventListener(CharacterDisplayEvent.DISPLAY, _onDisplayStatusPanel);
			view.addEventListener(CharacterDisplayEvent.HIDE, _onDisplayStatusPanel);

			talkScreen.addEventListener(MouseEvent.CLICK, _onTalkScreenClicked);
			
			//Initializing the console
			console = new Console();
			console.x = (stage.stageWidth  ) / 2;
			console.y = stage.stageHeight;
			
			//Initializing action counter
			actionCounter = new ActionPointsCounter();
			actionCounter.x = 0;
			actionCounter.y = stage.stageHeight;
			
			//Initializing turn counter
			turnCounter = new TurnCounter();
			turnCounter.x = stage.stageWidth;
			turnCounter.y = stage.stageHeight;
			turnCounter.addEventListener(MouseEvent.CLICK, _onClickHandler);
			
			//Set the current number of action points
			currentActionPoints = maxActionPoints   ;
			RemoveActionPoints(0);
			
			//Set the current turn number
			SetTurn();
			
			mover = new WorldMapMover();
			
			//Initialization of the Status Panel
			statusPanel = new StatusPanel();
			statusPanel.x = - statusPanel.width;
			statusPanel.y = - statusPanel.height;
			
			
			//Initialization of the Inventory Panel
			inventory = new InventoryPanel();
			inventory.SetInventoryPanel(Main.managers.Item.partyInventory.ReturnItemArray());
			inventory.x = 95;
			inventory.y = 0;
			
			//Initialize characterDisplays
			characterDisplaysData_arr = new Array(	[stage.stageWidth, 2],
													[stage.stageWidth, 92],
													[stage.stageWidth, 182],
													[stage.stageWidth, 272]			
			);
			
			
			for (i = 0; i < characterDisplaysData_arr.length; i++)
			{
				characterDisplays_arr.push(new CharacterDisplay(characterDisplaysData_arr[i][0], characterDisplaysData_arr[i][1]));
				characterDisplays_arr[i].addEventListener(MouseEvent.CLICK, _onClickHandler);
			}
			
			characterDisplays_arr[Main.GENERAL].DisplayIcon(HeroIconMC);
			characterDisplays_arr[Main.PRIEST].DisplayIcon(Lt1IconMC);
			characterDisplays_arr[Main.ASSASSIN].DisplayIcon(Lt2IconMC);
			characterDisplays_arr[Main.WIZZARD].DisplayIcon(Lt3IconMC);
			
			//Initialize armyDisplays
			armyDisplaysData_arr = new Array(		[stage.stageWidth, 372],
													[stage.stageWidth, 462],
													[stage.stageWidth, 552]		
			);
			for (i = 0; i < armyDisplaysData_arr.length; i++)
			{
				armyDisplays_arr.push(new ArmyDisplay(armyDisplaysData_arr[i][0], armyDisplaysData_arr[i][1]));
				armyDisplays_arr[i].Update(Main.managers.Character.army.retrunCorpByID(i));
			}
			armyDisplays_arr[Main.LANCER].DisplayIcon(Army1IconMC);
			armyDisplays_arr[Main.ARCHER].DisplayIcon(Army2IconMC);
			armyDisplays_arr[Main.KNIGHT].DisplayIcon(Army3IconMC);

			
			//Initialize in-game Menu Buttons
			buttonsData_arr = new Array(
											[0, 2 , Main.managers.Text.GetText(TextManager.MOVE),1,MoveIconMC],
											[0, 82,  Main.managers.Text.GetText(TextManager.SEARCH),1,SearchIconMC],
											[0, 162, Main.managers.Text.GetText(TextManager.CAMP),1,CampIconMC],
											[0,242, Main.managers.Text.GetText(TextManager.PROPAGANDA),1,PropagandaIconMC],
											[0,322, Main.managers.Text.GetText(TextManager.INVENTORY),9999,InventoryIconMC],
											[0,402, Main.managers.Text.GetText(TextManager.EQUIP),9999,EquipIconMC],
											[0,482, Main.managers.Text.GetText(TextManager.TALK),9999,TalkIconMC],
											[0,562, Main.managers.Text.GetText(TextManager.MENU),9999,MenuIconMC]
			);

			for (i = 0; i < buttonsData_arr.length; i++ )
			{
				var tmp:PaperButtonLeft = new PaperButtonLeft();
				buttons_arr.push(tmp);
				buttons_arr[i].x = buttonsData_arr[i][0];
				buttons_arr[i].y = buttonsData_arr[i][1];
				buttons_arr[i].SetPaperButton(buttonsData_arr[i][2], buttonsData_arr[i][3],buttonsData_arr[i][4]);
				buttons_arr[i].addEventListener(MouseEvent.CLICK , _onClickInGameMenuHandler);
			}
			
			
			//inititalize World Map Background and add it to stage
			worldMapBackground.x = stage.stageWidth / 2;
			worldMapBackground.y = stage.stageHeight / 2;

			//Play World Map BGM
			Main.managers.SoundM.playBGM(Main.BGM_WORLD_MAP);
			
			//Add the WorldMap Bg to view;
			view.addChildAt(worldMapBackground,1);
			worldMapBackground.addEventListener(Event.ENTER_FRAME, _Update);
		}
		
		
		
		
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Set up and add to stage the dynamic displayable objects
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function GenerateScreen():void
		{
			//Simple counter variable for the for loops
			var i:int;
			
			//Add character display to stage
			for (i = characterDisplays_arr.length - 1; i >= 0 ; i--)
			{
				view.addChildAt(characterDisplays_arr[i],view.numChildren);
			}
			UpdateCharacterDisplays();
			
			//Add army display to stage
			for (i = armyDisplaysData_arr.length - 1; i >= 0 ; i--)
			{
				view.addChildAt(armyDisplays_arr[i],view.numChildren);
			}
			UpdateArmyDisplays();
			
			view.addChild(console);
			view.addChild(actionCounter);
			view.addChild(turnCounter);
			
			//Add status panel to stage
			view.addChild(statusPanel);
			
			//Add buttons to stage
			for (i = buttonsData_arr.length - 1; i >= 0 ; i-- )
			{
				view.addChildAt(buttons_arr[i],view.numChildren);
			}
			
			
			//Add talks screen to stage and hide it
			view.addChild(talkScreen);
			talkScreen.visible = false;
			
			
			//Add inventory to stage and hide it
			view.addChildAt(inventory, 15);
			inventory.visible = isInventoryPanelDisplayed;
			

			playerIconOnMap.x = Main.managers.Level.Levels[Main.managers.Level.currentLocation ].positionOnMapX;
			playerIconOnMap.y = Main.managers.Level.Levels[Main.managers.Level.currentLocation  ].positionOnMapY;

			for (i = 0; i < Main.managers.Level.Levels.length ; i++)
			{
				//trace(" townData_ar init step: " + i); 
				Main.managers.Level.Levels[i].mapIcon.x = Main.managers.Level.Levels[i].positionOnMapX ;
				Main.managers.Level.Levels[i].mapIcon.y = Main.managers.Level.Levels[i].positionOnMapY   - 38;
				Main.managers.Level.Levels[i].mapIcon.addEventListener(MouseEvent.CLICK, _onClickHandler);
				if (!Main.managers.Level.Levels[i].isAlly)
				{
					Main.managers.Level.Levels[i].mapIcon.gotoAndStop(2);
					
				}
				worldMapBackground.addChild(Main.managers.Level.Levels[i].mapIcon);
			}

			worldMapBackground.addChild(mover);
			worldMapBackground.addChild(playerIconOnMap);
			
			playerIconOnMap.x = Main.managers.Level.Levels[Main.managers.Level.currentLocation ].mapIcon.x;
			playerIconOnMap.y = Main.managers.Level.Levels[Main.managers.Level.currentLocation ].mapIcon.y  ;
			mover.SetWorldMapMover(Main.managers.Level.Levels[Main.managers.Level.currentLocation]);
			
			//trace("Current location on WorldMap Screen generation : "+Main.managers.Level.currentLocation);
			HideWorldMapIcons();
			
			stage.addEventListener(KeyboardEvent.KEY_UP, _onDebugSkip);
		}

		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				called when _view is removed from stage
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function end():void
		{
			//trace("Current location on WorldMap Screen ending : "+Main.managers.Level.currentLocation);
			_view.removeEventListener(MouseEvent.CLICK, _onClickHandler); 
			//_view.removeChild(inventory);
			//_view.removeChild(statusPanel);
			
			for (var i:int = 0; i < Main.managers.Level.Levels.length ; i++)
			{
				Main.managers.Level.Levels[i].mapIcon.removeEventListener(MouseEvent.CLICK, _onClickHandler);
			}
			
			while (worldMapBackground.numChildren) worldMapBackground.removeChildAt(0);
			//while (view.numChildren) view.removeChildAt(0);
			
			super.end();
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Event Handlers
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		private function _onDebugSkip(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.SPACE)
			{
				//stage.removeEventListener(KeyboardEvent.KEY_UP, _onDebugSkip);
				_goToScreen = "GameOver";
				worldMapBackground.gotoAndPlay(26);
				HideWorldMapIcons();
				HideBottom();
			}
			if (e.keyCode == Keyboard.S)
			{
				Main.managers.Save.Save(1);
			}
			if (e.keyCode == Keyboard.L)
			{
				Main.managers.Save.Load(1);
			}
		}
		private function _Update(e:Event):void 
		{
			
			if (worldMapBackground.currentFrame == 24)
			{
				GenerateScreen();
			}
			if (worldMapBackground.currentFrame == 27)
			{
				playerIconOnMap.visible = false;
			}
			if (worldMapBackground.currentFrame == worldMapBackground.totalFrames)
			{
				
				switch( _goToScreen)
				{
					case "MainMenu":
						dispatchEvent(new ScreenEvents(ScreenEvents.DESTROYED, "MainMenu", true, true));
						break;
					case "War":
						dispatchEvent(new ScreenEvents(ScreenEvents.DESTROYED, "War", true, true));
						break;
					case "Duel":
						dispatchEvent(new ScreenEvents(ScreenEvents.DESTROYED, "Duel", true, true));
						break;
					case "GameOver":
						dispatchEvent(new ScreenEvents(ScreenEvents.DESTROYED, "GameOver", true, true));
						break;
				}
				
			}
		}
		
		private function _onClickInGameMenuHandler(e:MouseEvent):void 
		{
			switch(e.currentTarget)
			{
				case (buttons_arr[0]):
						if (currentActionPoints >= 1)
						{
							Main.managers.SoundM.playSfx(Main.SFX_SELECT);
							ShowWorldMapIcons();
						}
						else
						{
							Main.managers.SoundM.playSfx(Main.SFX_NO);
							console.DisplayOnConsole("Pas assez de points d'action");
						}
						break;	
				case (buttons_arr[1]):
					if (currentActionPoints >= 1)
					{
						Main.managers.SoundM.playSfx(Main.SFX_SELECT);
						searchFunction(Main.managers.Level.currentLocation);
					}
					else
					{
						Main.managers.SoundM.playSfx(Main.SFX_NO);
						console.DisplayOnConsole("Pas assez de points d'action");
					}
					break;	
				case (buttons_arr[2]):
					if (currentActionPoints >= 1)
					{
						Main.managers.SoundM.playSfx(Main.SFX_SELECT);
						campFunction(Main.managers.Level.currentLocation);
					}
					else
					{
						Main.managers.SoundM.playSfx(Main.SFX_NO);
						console.DisplayOnConsole("Pas assez de points d'action");
					}
					break;	
				case (buttons_arr[3]):
					if (currentActionPoints >= 3)
					{
						Main.managers.SoundM.playSfx(Main.SFX_SELECT);
						propagandaFunction(Main.managers.Level.currentLocation);
					}
					else
					{
						Main.managers.SoundM.playSfx(Main.SFX_NO);
						console.DisplayOnConsole("Pas assez de points d'action");
					}
					break;	
				case (buttons_arr[4]):
					if (isInventoryPanelDisplayed)
					{
						Main.managers.SoundM.playSfx(Main.SFX_SELECT);
						isInventoryPanelDisplayed = false;
						inventory.visible = isInventoryPanelDisplayed;
					}else
					{
						Main.managers.SoundM.playSfx(Main.SFX_SELECT);
						isInventoryPanelDisplayed = true;
						inventory.visible = isInventoryPanelDisplayed;
					}
					break;	
				case (buttons_arr[5]):
					Main.managers.SoundM.playSfx(Main.SFX_SELECT);
					Main.managers.Character.hero.ChangeWeapon(Main.managers.Item.returnWeapon("W005"));
					Main.managers.Character.hero.ChangeArmor(Main.managers.Item.returnArmor("A003"));
					Main.managers.Character.hero.ChangeAccessory(Main.managers.Item.returnAccessory("C015"));

					break;
				case(buttons_arr[6]):
					Main.managers.SoundM.playSfx(Main.SFX_SELECT);
					if (!isTalkScreenDisplayed)
					{
						isTalkScreenDisplayed = true;
						talkScreen.visible = true;
						talkFunction();
					}else
					{
						
						isTalkScreenDisplayed = false;
						talkScreen.visible = false;
					}
					
					break;	
				case(buttons_arr[7]):
					Main.managers.SoundM.playSfx(Main.SFX_SELECT);
					_goToScreen = "MainMenu";
					worldMapBackground.gotoAndPlay(26);
					HideWorldMapIcons();
					HideBottom();
					break;
			}
			
			UpdateCharacterDisplays();
		}
		
		private function _onClickHandler(e:MouseEvent):void
		{
			for (var i:int = 0; i < Main.managers.Level.Levels.length; i++)
			{
				if ( e.currentTarget == Main.managers.Level.Levels[i].mapIcon)
				{
					moveFunction(i);
					HideWorldMapIcons();
				}
			}
			if (e.currentTarget == turnCounter)
			{
				ChangeTurn();
			}
			UpdateCharacterDisplays();
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Custom function: show/hide status panel
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		private function _onDisplayStatusPanel(e:CharacterDisplayEvent):void 
		{
			e.stopImmediatePropagation();
			
			statusPanel.x = e.posX;
			statusPanel.y = e.posY;
			
			if (e.type == CharacterDisplayEvent.DISPLAY)
			{
				statusPanel.visible = true;
				
				switch(e.target)
				{
					case characterDisplays_arr[Main.GENERAL]:
						SetStatusPanel(Main.GENERAL);
						break;
					case characterDisplays_arr[Main.PRIEST]:
						SetStatusPanel(Main.PRIEST);
						break;
					case characterDisplays_arr[Main.ASSASSIN]:
						SetStatusPanel(Main.ASSASSIN);
						break;
					case characterDisplays_arr[Main.WIZZARD]:
						SetStatusPanel(Main.WIZZARD);
						break;
				}
			}
			else
			{
				statusPanel.visible = false;
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Custom function: hide bottom displays
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		private function HideBottom():void
		{
			console.out();
			actionCounter.out();
			turnCounter.out();
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Custom function: remove the action points and display the new value
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function RemoveActionPoints(ammount:int):void
		{
			//calculate remaining action points
			currentActionPoints -= ammount;
			if (currentActionPoints < 0)
			{
				currentActionPoints = 0;
			}
			//displaying it
			var tmp:String = currentActionPoints.toString() + " / " + maxActionPoints.toString();
			actionCounter.view.actionField_txt.text = tmp;
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Custom function: next turn
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		private function ChangeTurn():void
		{
			Main.managers.Level.currentTurn ++;
			currentActionPoints = maxActionPoints;
			RemoveActionPoints(0);
			SetTurn();
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Custom function: display current turn
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		private function SetTurn():void
		{
			turnCounter.view.turnField_txt.text = Main.managers.Level.currentTurn.toString();
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Custom function: manage click on towns icons
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		private function checkValidMove(index:int):Boolean
		{
			for each(var id:String in (Main.managers.Level.Levels[Main.managers.Level.currentLocation] as Level).neighbours)
			{
				if ( id == Main.managers.Level.Levels[index].id)
				{
					return true;
				}
			}
			return false;
		}
		
		private function moveFunction(index:int):void
		{
			if ( checkValidMove(index))
			{
				Main.managers.SoundM.playSfx(Main.SFX_OK);
				Main.managers.Level.currentLocation = Main.managers.Level.Levels[index].townIndex;
			
				playerIconOnMap.x = Main.managers.Level.Levels[Main.managers.Level.currentLocation ].mapIcon.x;
				playerIconOnMap.y = Main.managers.Level.Levels[Main.managers.Level.currentLocation ].mapIcon.y  ;
				mover.SetWorldMapMover(Main.managers.Level.Levels[index]);
				
				
				if (Main.managers.Level.Levels[index].isAlly)
				{
					console.DisplayOnConsole(new String("Vous vous déplacez vers " + Main.managers.Level.Levels[index].name));
					RemoveActionPoints(1);
					
				}
				else
				{

					Main.managers.Level.Levels[index].isAlly = true;
					Main.managers.Level.Levels[index].mapIcon.gotoAndStop(1);
					_goToScreen = "War";
					worldMapBackground.gotoAndPlay(26);
					HideWorldMapIcons();
					HideBottom();
				}
			}
			else
			{
				Main.managers.SoundM.playSfx(Main.SFX_NO);
				console.DisplayOnConsole(new String("Vous ne pouvez pas vous déplacer vers " + Main.managers.Level.Levels[index].name));
			}
			

		}
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Custom function: manage propaganda button click
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		private function propagandaFunction(index:int):void
		{
			if (Main.managers.Level.Levels[index].isPropagandaDone)
			{
				Main.managers.SoundM.playSfx(Main.SFX_NO);
				console.DisplayOnConsole(new String("Vous ne pouvez plus recruter ici "));
			}
			else
			{
				
				Main.managers.Level.Levels[index].isPropagandaDone = true;
				RemoveActionPoints(3);
				Main.managers.Character.army.archers.addMaxTroops(Main.managers.Level.Levels[index].propaganda[Main.ARCHER]);
				Main.managers.Character.army.lancers.addMaxTroops(Main.managers.Level.Levels[index].propaganda[Main.LANCER]);
				Main.managers.Character.army.knights.addMaxTroops(Main.managers.Level.Levels[index].propaganda[Main.KNIGHT]);
				UpdateArmyDisplays();
				console.DisplayOnConsole(new String("Vous Haranguez les habitants de " + Main.managers.Level.Levels[index].name));
			}
			
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Custom function: manage search button click
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		private function searchFunction(index:int):void
		{
			if (Main.managers.Level.Levels[index].isSearchDone)
			{
				Main.managers.SoundM.playSfx(Main.SFX_NO);
				console.DisplayOnConsole(new String("Vous ne pouvez plus fouiller ici "));
			}
			else
			{
				
				Main.managers.Level.Levels[index].isSearchDone = true;
				RemoveActionPoints(1);
				Main.managers.Item.partyInventory.AddInventory(Main.managers.Level.Levels[index].searchItem);
				//inventory.ResetInventory();
				inventory.SetInventoryPanel(Main.managers.Item.partyInventory.ReturnItemArray());
				console.DisplayOnConsole(new String("Vous fouillez le champs de bataille de " + Main.managers.Level.Levels[index].name));
			}
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Custom function: manage camp button click
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		private function campFunction(index:int):void
		{
			RemoveActionPoints(1);
			Main.managers.Character.army.rest();
			Main.managers.Character.hero.rest();
			Main.managers.Character.lt1.rest();
			Main.managers.Character.lt2.rest();
			Main.managers.Character.lt3.rest();
			console.DisplayOnConsole(new String("Vous campez aux environs de " + Main.managers.Level.Levels[index].name));
			UpdateArmyDisplays();
			ChangeTurn();
			UpdateCharacterDisplays();
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Custom function: manage inventory button click
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		private function Equip(e:InventoryEvent):void
		{
			
			e.stopImmediatePropagation();
			
			trace(Main.managers.Item.partyInventory.ReturnItemArray().length);
			Main.managers.Item.partyInventory.RemoveItem(e.selectedItem);
			trace(Main.managers.Item.partyInventory.ReturnItemArray().length);
			switch (e.selectedItem)
			{
				case typeof(Consumable):
					
					break;
				case typeof(Weapon):
					Main.managers.Item.partyInventory.AddItem(Main.managers.Character.hero.weaponEquipped);
					Main.managers.Character.hero.ChangeWeapon(e.selectedItem as Weapon) ;
					break;
				case typeof(Armor):
					Main.managers.Item.partyInventory.AddItem(Main.managers.Character.hero.armorEquipped);
					Main.managers.Character.hero.ChangeArmor(e.selectedItem as Armor) ;
					break;
				case typeof(Accessory):
					Main.managers.Item.partyInventory.AddItem(Main.managers.Character.hero.accesoryEquipped);
					Main.managers.Character.hero.ChangeAccessory(e.selectedItem as Accessory) ;
					break;
			}
			UpdateCharacterDisplays();
			inventory.SetInventoryPanel(Main.managers.Item.partyInventory.ReturnItemArray());
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Custom function: manage talk button click
		//				DEBUG
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function talkFunction():void
		{
			talkScreen.Init(Main.managers.Talk.units[0]);

		}
		private function _onTalkScreenClicked(e:MouseEvent):void 
		{
			if (e.target == talkScreen.view.quit_mc)
			{
				talkScreen.End();
				isTalkScreenDisplayed = false;
				talkScreen.visible = false;
			}
			
		}
		
		
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Custom function: update the CharacterDisplays
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function UpdateCharacterDisplays():void
		{
			characterDisplays_arr[Main.GENERAL ].Update(Main.managers.Character.hero);
			characterDisplays_arr[Main.PRIEST ].Update(Main.managers.Character.lt1);
			characterDisplays_arr[Main.ASSASSIN ].Update(Main.managers.Character.lt2);
			characterDisplays_arr[Main.WIZZARD ].Update(Main.managers.Character.lt3);
		}
		
		
		private function UpdateArmyDisplays():void
		{
			armyDisplays_arr[Main.ARCHER].Update(Main.managers.Character.army.archers);
			armyDisplays_arr[Main.LANCER].Update(Main.managers.Character.army.lancers);
			armyDisplays_arr[Main.KNIGHT].Update(Main.managers.Character.army.knights);
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Custom function: set the status panel when the player click on a character icon
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function SetStatusPanel(character:int):void
		{
			var tmpCharacter:Character;
			
			switch (character)
			{
				case Main.GENERAL:
					statusPanel.Display(Main.managers.Character.hero as Character);
					statusPanel.x = characterDisplays_arr[Main.GENERAL].view.x - 110 - statusPanel.width;
					statusPanel.y = characterDisplays_arr[Main.GENERAL].view.y;
					break;
				case Main.PRIEST:
					tmpCharacter = Main.managers.Character.lt1 as Character;
					statusPanel.Display(Main.managers.Character.lt1 as Character);
					statusPanel.x = characterDisplays_arr[Main.PRIEST].view.x - 110 - statusPanel.width;
					statusPanel.y = characterDisplays_arr[Main.PRIEST].view.y;
					break;
				case Main.ASSASSIN:
					statusPanel.Display(Main.managers.Character.lt2 as Character);
					statusPanel.x = characterDisplays_arr[Main.ASSASSIN].view.x - 110 - statusPanel.width;
					statusPanel.y = characterDisplays_arr[Main.ASSASSIN].view.y;
					break;
				case Main.WIZZARD:
					statusPanel.Display(Main.managers.Character.lt3 as Character);
					statusPanel.x = characterDisplays_arr[Main.WIZZARD].view.x - 110 - statusPanel.width;
					statusPanel.y = characterDisplays_arr[Main.WIZZARD].view.y;
					break;
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Custom function: show and hide towns icons and character icon from mapBG
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function HideWorldMapIcons():void
		{
			
			var i:int;
			for (i = 0; i < Main.managers.Level.Levels.length ; i++)
			{
				Main.managers.Level.Levels[i].mapIcon.visible = false;
				
			}
			mover.visible = false;
			
		}
		
		private function ShowWorldMapIcons():void
		{
			var i:int;
			for (i = 0; i < Main.managers.Level.Levels.length ; i++)
			{
				Main.managers.Level.Levels[i].mapIcon.visible = true;
				
			}
			mover.visible = true;
		}
		
	}

}