package codex.armies 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class ArmyAnimationHolder extends MovieClip 
	{
		public var view:MovieClip = new MovieClip();
		public var isOneShot:Boolean = false;
		private var maxCol:int = 8;
		private var divisor:int = 3;
		private var effectif:int;
		private var soldiersMC:Array = new Array();
		
		public function ArmyAnimationHolder(anim:Class , number:int) 
		{
			effectif = number;
			for (var i:int = 0; i < int(effectif / divisor); i++)
			{
				soldiersMC[i] = new anim();
				soldiersMC[i].width *= 0.5;
				soldiersMC[i].height *= 0.5;
				(soldiersMC[i] as MovieClip).x = int(i/maxCol) * ((soldiersMC[i] as MovieClip).width / 2) +  (i % maxCol) * ((soldiersMC[i] as MovieClip).width);
				(soldiersMC[i] as MovieClip).y = 0 + int(i/maxCol) * ((soldiersMC[i] as MovieClip).height);
				view.addChild(soldiersMC[i]);
			}
			
			addChild(view);
		}
		
	}

}