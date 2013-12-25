package displayable 
{
	import codex.levels.Level;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class WorldMapMover extends MovieClip 
	{
		
		public var center_mc:WorldMapMoverCenterMC = new WorldMapMoverCenterMC();
		
		public var arrowTop_mc:WorldMapMoverArrowMC = new WorldMapMoverArrowMC();
		public var arrowBot_mc:WorldMapMoverArrowMC = new WorldMapMoverArrowMC();
		public var arrowLeft_mc:WorldMapMoverArrowMC = new WorldMapMoverArrowMC();
		public var arrowRight_mc:WorldMapMoverArrowMC = new WorldMapMoverArrowMC();
		
		private var _arrows_mc:Array = new Array(arrowTop_mc, arrowBot_mc, arrowLeft_mc, arrowRight_mc);
		
		public function WorldMapMover() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
		}
		
		private function _onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			center_mc.x = 0;
			center_mc.y = 0;
			
			var i:int;
			for (i = 0; i < _arrows_mc.length; i++)
			{
				_arrows_mc[i].x = 0;
				_arrows_mc[i].y = 0;
				_arrows_mc[i].rotation = 90 * i;
				center_mc.addChild(_arrows_mc[i]);
				this._arrows_mc[i].visible = false;
			}
			addChild(center_mc);
			this.center_mc.visible = false;
			
			
		}
		
		public function SetWorldMapMover(level:Level):void
		{
			var i:int;
			
			this.x = level.mapIcon.x ;
			this.y = level.mapIcon.y;
			for (i = 0; i < _arrows_mc.length; i++)
			{

				_arrows_mc[i].visible = false;
			}
			
			
			//center_mc.x = level.positionOnMapX;
			//center_mc.y = level.positionOnMapY;
			center_mc.visible = true;

			for (i = 0; i < level.neighbours.length; i++)
			{
				//_arrows_mc[i].x = level.positionOnMapX;
				//_arrows_mc[i].y = level.positionOnMapY;
				_arrows_mc[i].visible = true;
				var tmpLevel:Level = Main.managers.Level.getLevelByID(level.neighbours[i]);
				var dx:Number = (tmpLevel.positionOnMapX - level.positionOnMapX);
				var dy:Number = tmpLevel.positionOnMapY - level.positionOnMapY;
				var angle:Number =  (180 / Math.PI) * Math.atan2(dy, dx) + 90;
				_arrows_mc[i].rotation = angle;
			}
		}
		
		public function ResetWorldMapMover():void
		{
			removeChild(center_mc);
		}
		
		public function get arrows_mc():Array 
		{
			return _arrows_mc;
		}
		
		public function set arrows_mc(value:Array):void 
		{
			_arrows_mc = value;
		}
		
	}

}