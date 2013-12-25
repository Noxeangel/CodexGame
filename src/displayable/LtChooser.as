package displayable 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class LtChooser extends MovieClip 
	{
		public var view:LtChooserMC;
		public function LtChooser() 
		{
			view = new LtChooserMC();
			addChild(view);
			
			view.lt1Icon_mc.buttonMode = true;
			view.lt2Icon_mc.buttonMode = true;
			view.lt3Icon_mc.buttonMode = true;
		}
		
	}

}