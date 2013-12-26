package displayable 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class TargetChooser extends MovieClip 
	{
		
		public var view:TargetlChooserMC = new TargetlChooserMC();
		
		public function TargetChooser() 
		{
			addChild(view);
		}
		
	}

}