package codex.characters 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer;
	import events.AnimStateEvent;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author Olivier
	 */
	public class AnimationMachine extends MovieClip
	{
		
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Attributes of the Class
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private var _currentState:int = Main.IDLE;										//Current animation index in animationArray
		private var _nextState:int = Main.ANIM_NONE;									//New animation index (if value is 666, it means: no next state)
		
		private var _currentAnim:AnimationHolder;										//Current animation
		
		//List of the animations
		private var _idle:AnimationHolder;
		private var _attack:AnimationHolder;
		private var _spell:AnimationHolder;
		private var _damaged:AnimationHolder;
		private var _dead:AnimationHolder;
		private var _victory:AnimationHolder;

		//Array used to store the animations
		private var _animationArray:Array = new Array();
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Constructor
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function AnimationMachine() 
		{
			Init();
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Initialization function
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Init(archetypeName:String = "General"):void 
		{
			_idle = null;
			_attack = null;
			_spell = null;
			_damaged = null;
			_dead = null;
			_victory = null;
			
			while (this.numChildren != 0)
			{
				this.removeChildAt(0);
			}
			
			_animationArray.length = 0;
			
			switch(archetypeName)
			{
				case "General":
					_idle = new AnimationHolder(HeroIdleAnimMC);
					_attack = new AnimationHolder(HeroAttackAnimMC);
					_attack.isOneShot = true;
					_spell = new AnimationHolder(HeroIdleAnimMC);
					_spell.isOneShot = true;
					_damaged = new AnimationHolder(HeroIdleAnimMC);
					_damaged.isOneShot = true;
					_dead = new AnimationHolder(HeroIdleAnimMC);
					_victory = new AnimationHolder(HeroIdleAnimMC);
					break;
				case "Priest":
					trace("AnimationMachine of priest init");
					_idle = new AnimationHolder(PriestIdleAnimMC);
					_attack = new AnimationHolder(PriestIdleAnimMC);
					_attack.isOneShot = true;
					_spell = new AnimationHolder(PriestIdleAnimMC);
					_spell.isOneShot = true;
					_damaged = new AnimationHolder(PriestIdleAnimMC);
					_damaged.isOneShot = true;
					_dead = new AnimationHolder(PriestIdleAnimMC);
					_victory = new AnimationHolder(PriestIdleAnimMC);
					trace(getQualifiedClassName(_idle.view));
					break;
				case "Assassin":
					_idle = new AnimationHolder(AssassinAnimIdleMC);
					_attack = new AnimationHolder(AssassinAnimIdleMC);
					_attack.isOneShot = true;
					_spell = new AnimationHolder(AssassinAnimIdleMC);
					_spell.isOneShot = true;
					_damaged = new AnimationHolder(AssassinAnimIdleMC);
					_damaged.isOneShot = true;
					_dead = new AnimationHolder(AssassinAnimIdleMC);
					_victory = new AnimationHolder(AssassinAnimIdleMC);
					break;	
				case "Wizzard":
					_idle = new AnimationHolder(WizzardIdleAnimMC);
					_attack = new AnimationHolder(WizzardIdleAnimMC);
					_attack.isOneShot = true;
					_spell = new AnimationHolder(WizzardIdleAnimMC);
					_spell.isOneShot = true;
					_damaged = new AnimationHolder(WizzardIdleAnimMC);
					_damaged.isOneShot = true;
					_dead = new AnimationHolder(WizzardIdleAnimMC);
					_victory = new AnimationHolder(WizzardIdleAnimMC);
					break;	
				default:
					_idle = new AnimationHolder(EnemyIdleAnimMC);
					_attack = new AnimationHolder(EnemyIdleAnimMC);
					_attack.isOneShot = true;
					_spell = new AnimationHolder(EnemyIdleAnimMC);
					_spell.isOneShot = true;
					_damaged = new AnimationHolder(EnemyIdleAnimMC);
					_damaged.isOneShot = true;
					_dead = new AnimationHolder(EnemyIdleAnimMC);
					_victory = new AnimationHolder(EnemyIdleAnimMC);
					break;
			}
			
			
			this.addEventListener(Event.ENTER_FRAME, _update);				//event listener of the update function

			_animationArray.push(_idle);
			_animationArray.push(_attack);
			_animationArray.push(_spell);
			_animationArray.push(_damaged);
			_animationArray.push(_dead);
			_animationArray.push(_victory);
			
			for each(var tmp:MovieClip in _animationArray)
			{
				tmp.scaleX = -1.5;
				tmp.scaleY = 1.5;
				this.addChild(tmp);
			}
			
			HideAllAnims();
			_currentAnim = _animationArray[_currentState];						//set the current state
			_animationArray[_currentState].view.visible = true;
			
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				update Event Handler
		//	if the current animation is finished and if there is a next animation called, switch between animations
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function _update(e:Event):void 
		{
			//trace("Animation machine updated");
			if (_nextState == Main.ANIM_NONE)
			{
								return;
			}
			else
			{
				
				if (_currentAnim.view.currentFrame != _currentAnim.view.totalFrames)
				{
					return;
				}
				else
				{
					dispatchEvent(new AnimStateEvent(AnimStateEvent.OVER, 0, 0, true, true));
					
					HideAllAnims();
					removeChild(_animationArray[_currentState]);
					_currentState = _nextState;
					_nextState = Main.ANIM_NONE;
					_currentAnim = _animationArray[_currentState];
					_animationArray[_currentState].view.visible = true;
					addChild(_animationArray[_currentState]);
					_animationArray[_currentState].view.play();
					
				}
			}
			
			if (_currentAnim.isOneShot)
			{
				_nextState = Main.IDLE;
			}

		}
		
		
		private function HideAllAnims():void
		{
			for each( var tmp:AnimationHolder in _animationArray)
			{
				tmp.view.visible = false
			}
		}
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Getters And Setters
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function get currentAnim():MovieClip 
		{
			return _currentAnim;
		}
		
		public function set nextState(value:int):void 
		{
			_nextState = value;
		}
		
		public function get currentState():int 
		{
			return _currentState;
		}
		
		
		
	}

}