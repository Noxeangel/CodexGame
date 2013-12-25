package displayable 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class HUDButton extends MovieClip 
	{

		private var view:HudBaseBTN;

		public function HUDButton() 
		{
			view = new HudBaseBTN();
			addChild(view);
			
		}
		
		public function SetUpButton(x:int = 0, y:int = 0, line:String = "bad instanciation"):void
		{
			view.x = x;
			view.y = y;
			((view.upState as DisplayObjectContainer).getChildAt(1) as TextField).text = line;
			//((view.downState as DisplayObjectContainer).getChildAt(1) as TextField).text = line;
			((view.upState as DisplayObjectContainer).getChildAt(1) as TextField).text = line;
			((view.overState as DisplayObjectContainer).getChildAt(1) as TextField).text = line;
			((view.hitTestState as DisplayObjectContainer).getChildAt(1) as TextField).text = line;
		}
		
	}

}