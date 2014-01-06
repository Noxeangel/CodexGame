package displayable 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class ArmyChooser extends MovieClip 
	{
		public var view:ArmyChooserMC;
		public function ArmyChooser() 
		{
			view = new ArmyChooserMC();
			addChild(view);
			
			view.army1Icon_mc.buttonMode = true;
			view.army2Icon_mc.buttonMode = true;
			view.army3Icon_mc.buttonMode = true;
		}
		
	}

}