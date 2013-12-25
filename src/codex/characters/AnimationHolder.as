package codex.characters 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class AnimationHolder extends MovieClip 
	{
		public var view:MovieClip;
		public var isOneShot:Boolean = false;
		
		
		public function AnimationHolder(anim:Class) 
		{
			view = new anim;
			addChild(view);
		}
		
	}

}