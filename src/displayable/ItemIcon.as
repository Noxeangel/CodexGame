package displayable 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.utils.getDefinitionByName;
	//import Acces15_Icon;
	/**
	 * ...
	 * @author Olivier
	 */
	public class ItemIcon extends MovieClip 
	{
		
	
		private var loadedImage:Bitmap;
		
		public function ItemIcon(name:String = "Sword1_Icon") 
		{
			displayImage(name);
			
		}
		
		public function displayImage(name:String = "Sword1_Icon"):void
		{
			var iconClass:Class = getDefinitionByName(name) as Class
			var iconImage:BitmapData = new iconClass;
			
			loadedImage = new Bitmap(iconImage);
			loadedImage.scaleX = loadedImage.scaleY = 2;
			
			addChild(loadedImage);
		}
		
		/*
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//			DO NOT MODIFY : BEGIN
		//				Compiler Helper Variable
		//		The following variables have for only purpose to manage dummy instance
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private var forCompiler101:Life_Icon;
		private var forCompiler102:Mana_Icon;
		
		private var forCompiler201:Sword1_Icon;
		private var forCompiler202:Sword2_Icon;
		private var forCompiler203:Sword3_Icon;
		private var forCompiler204:Sword4_Icon;
		private var forCompiler205:Sword5_Icon;
		
		private var forCompiler211:Dagger1_Icon;
		private var forCompiler212:Dagger2_Icon;
		private var forCompiler213:Dagger3_Icon;
		private var forCompiler214:Dagger4_Icon;
		private var forCompiler215:Dagger5_Icon;
		
		private var forCompiler221:Mage2_Icon;
		private var forCompiler222:Mage3_Icon;
		private var forCompiler223:Mage4_Icon;
		private var forCompiler224:Mage5_Icon;
		private var forCompiler225:Mage1_Icon;
		
		private var forCompiler231:Priest1_Icon;
		private var forCompiler232:Priest2_Icon;
		private var forCompiler233:Priest3_Icon;
		private var forCompiler234:Priest4_Icon;
		private var forCompiler235:Priest5_Icon;
		
		private var forCompiler301:Armor1_Icon;
		private var forCompiler302:Armor2_Icon;
		private var forCompiler303:Armor3_Icon;
		
		private var forCompiler401:Acces1_Icon;
		private var forCompiler402:Acces2_Icon;
		private var forCompiler403:Acces3_Icon;
		private var forCompiler404:Acces4_Icon;
		private var forCompiler405:Acces5_Icon;
		private var forCompiler406:Acces6_Icon;
		private var forCompiler407:Acces7_Icon;
		private var forCompiler408:Acces8_Icon;
		private var forCompiler409:Acces9_Icon;
		private var forCompiler410:Acces10_Icon;
		private var forCompiler411:Acces11_Icon;
		private var forCompiler412:Acces12_Icon;
		private var forCompiler413:Acces13_Icon;
		private var forCompiler414:Acces14_Icon;
		private var forCompiler415:Acces15_Icon;
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//			DO NOT MODIFY : END
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		*/
		
	}

}