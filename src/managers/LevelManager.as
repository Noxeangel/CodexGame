package managers
{
	import codex.levels.Level;
	import flash.display.MovieClip;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * ...
	 * @author Olivier
	 */
	public class LevelManager extends MovieClip
	{

		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Internal Variables of the manager
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public var Levels:Array = new Array();
		public var currentTurn:int;
		public var currentLocation:int;
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Basic Constructor
		///////////////////////////////////////////////////////////////////////////////////////////////////////	
		
		public function LevelManager()
		{
		
		}
		
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Init function, called by the init function of the global manager
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Init():void
		{
			Levels = new Array();
			currentTurn = 0;
			currentLocation = 0;
			processLevelXML();
		}

		private function processLevelXML():void 
		{

			var LevelsXMLFile:XML = Main.LevelsXMLFile;
			
			for each (var levelNode:XML in LevelsXMLFile.TOWN)
			{
				var tmpLevel:Level = new Level();
				tmpLevel.id = levelNode.@ID;
				tmpLevel.name = levelNode.NAME;
				tmpLevel.townIndex = (int)(levelNode.TOWNINDEX);
				tmpLevel.positionOnMapX = (Number)(levelNode.POSITIONONMAPX);
				tmpLevel.positionOnMapY = (Number)(levelNode.POSITIONONMAPY);
				
				
				if (levelNode.ISALLY == "0")
				{
					tmpLevel.isAlly = false;
					//tmpLevel.isAlly = true;
				}
				else
				{
					tmpLevel.isAlly = true;
				}
				
				tmpLevel.armyGrowth[Main.ARCHER] = (int)(levelNode.ARMYGROWTH.ARCHERS);
				tmpLevel.armyGrowth[Main.LANCER] = (int)(levelNode.ARMYGROWTH.LANCERS);
				tmpLevel.armyGrowth[Main.KNIGHT] = (int)(levelNode.ARMYGROWTH.KNIGHTS);
				
				tmpLevel.propaganda[Main.ARCHER] = (int)(levelNode.PROPAGANDA.ARCHERS);
				tmpLevel.propaganda[Main.LANCER] = (int)(levelNode.PROPAGANDA.LANCERS);
				tmpLevel.propaganda[Main.KNIGHT] = (int)(levelNode.PROPAGANDA.KNIGHTS);
				
				for each( var searchCNode:XML in levelNode.SEARCH.CONSUMABLES.ITEM)
				{
					tmpLevel.searchItem.consumables.push(Main.managers.Item.returnConsumable(searchCNode.*));
					////trace(searchNode.ITEM.*);
				}
				for each( var searchWNode:XML in levelNode.SEARCH.WEAPONS.ITEM)
				{
					tmpLevel.searchItem.weapons.push(Main.managers.Item.returnWeapon(searchWNode.*));
					////trace(searchNode.ITEM.*);
				}
				for each( var searchANode:XML in levelNode.SEARCH.ARMORS.ITEM)
				{
					tmpLevel.searchItem.armors.push(Main.managers.Item.returnArmor(searchANode.*));
					////trace(searchNode.ITEM.*);
				}
				for each( var searchCoNode:XML in levelNode.SEARCH.ACCESORIES.ITEM)
				{
					tmpLevel.searchItem.accesories.push(Main.managers.Item.returnAccessory(searchCoNode.*));
					//trace(searchCoNode.*);
				}
				//trace(levelNode.NEIGHBOURS.NEIGHBOUR);
				for each( var neighbourNode:XML in levelNode.NEIGHBOURS.NEIGHBOUR)
				{
					tmpLevel.neighbours.push(neighbourNode.*);
					//trace(neighbourNode.*);
				}
				
				Levels.push(tmpLevel);
			}
			LevelsXMLFile = null;
		}
		public function getIDByIndex(index:int):String
		{
			for each (var level:Level in Levels)
			{
				if (level.townIndex == index)
				{
					return level.id;
				}
			}
			return null;
		}
		
		public function getLevelByID(id:String):Level
		{
			for each (var level:Level in Levels)
			{
				if (level.id == id)
				{
					return level;
				}
			}
			return null;
		}
	
	}

}