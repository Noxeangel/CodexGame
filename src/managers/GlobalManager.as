package managers 
{
	import events.ManagerEvent;
	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;

	/**
	 * ...
	 * @author Olivier
	 */
	public class GlobalManager extends MovieClip
	{
		private static var instance:GlobalManager;
		

		private var _Character:CharacterManager = new CharacterManager();
		private var _Item:ItemManager = new ItemManager();
		private var _Level:LevelManager = new LevelManager();
		private var _Talk:TalkManager = new TalkManager();
		private var _Duel:DuelManager = new DuelManager();
		private var _War:WarManager = new WarManager();
		private var _Save:SaveManager = new SaveManager();
		private var _SoundM:SoundManager = new SoundManager();
		private var _Text:TextManager = new TextManager();


		public function GlobalManager() 
		{
			if (instance != null)
			{
				throw new IllegalOperationError("GloabalManager class can't be instantiated because is a Singleton. Use getInstance() to retrieve a class reference");
			}
		}
		
		public static function getInstance():GlobalManager
		{
			if (instance == null)
			{
				instance = new GlobalManager();
			}
			return instance;
		}
		
		public function Init():void
		{
			
			trace("GlobalManager Init");
			_Character.Init();
			_Item.Init();
			_Level.Init();
			_Talk.Init();
			_Duel.Init();
			_War.Init();
			_Save.Init();
			_SoundM.Init();
			_Text.Init();
			
			
		}
		
		 public function get Character():CharacterManager 
		{
			return _Character;
		}

		 public function get Item():ItemManager 
		{
			return _Item;
		}

		 public function get Level():LevelManager 
		{
			return _Level;
		}

		 public function get Talk():TalkManager 
		{
			return _Talk;
		}
		
		 public function get Duel():DuelManager 
		{
			return _Duel;
		}
		
		 public function get War():WarManager 
		{
			return _War;
		}
		
		 public function get Save():SaveManager 
		{
			return _Save;
		}
		
		public function get SoundM():SoundManager 
		{
			return _SoundM;
		}
		
		public function get Text():TextManager 
		{
			return _Text;
		}
		

		
	}

}