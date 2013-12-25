package screens.FSM 
{
	
	/**
	 * ...
	 * @author Olivier
	 */
	public interface IState
	{
		function Init():void;
		
		function Update(t:int):void;
		
		function End():void;
	}
	
}