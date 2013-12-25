package game
{
	import flash.net.SharedObject;
	
	/**
	 * ...
	 * @author YopSolo
	 */
	public class Config
	{
		public static const GAME_WIDTH:int = 1024;
		public static const GAME_HEIGHT:int = 768;
		public static const COOKIE_NAME:String = "Codex";
		
		public static function get cookie():Object 
		{
			return SharedObject.getLocal(Config.COOKIE_NAME).data;
		}
		
	}
}