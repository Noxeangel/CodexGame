package managers
{
	import flash.display.MovieClip;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import Main;
	/**
	 * ...
	 * @author YopSolo
	 *
	 */	
	
	public class SoundManager extends MovieClip
	{

		private const MAX_TRACK:int = 24;
		//private var _tracks:Vector.<TransformedSound> = new Vector.<TransformedSound>(MAX_TRACK, true);
		private var _tracks:Array = new Array();

		// audio channel
		private var _channelBGM:SoundChannel = new SoundChannel;
		private var _channelSFX:SoundChannel = new SoundChannel;
		
		
		// 
		private var _currentBgmIdx:int = -1;

		private var _paused:Boolean = false;
		private var _position:Number = .0;

		
		private var stBGM:SoundTransform = new SoundTransform();
		private var stSFX:SoundTransform = new SoundTransform();

		public function SoundManager()
		{

		}
	

		public function Init():void
		{
			var i:int;
			for (i = 0; i < MAX_TRACK ; i++)
			{
				_tracks.push(null);
			}
		}
		
		

		public function addRessource(sound:Sound, idx:uint = Main.SFX_HEAL):void
		{
			if ( idx < _tracks.length )
			{
				_tracks[idx] = sound;
			}
			else
			{
				//throw new Error("ERROR: " + _tracks.length + " slots Max.");
			}
		}
		
		public function playSfx(idx:int = Main.SFX_HEAL):void
		{
			stSFX.volume = Main.sfxVolume;
			var s:Sound = _tracks[idx];
			if (s == null)
			{
				//throw new Error("ERROR: No ressource for track " + idx);
			}
			else
			{
				//_channelSFX.stop();
				_channelSFX = s.play(0,1,stSFX);
				
			}
			
		}
	
		
		
		public function playBGM(idx:int = Main.BGM_MAIN_MENU, repeat:int = 999):void
		{
			stBGM.volume = Main.bgmVolume;
			var s:Sound = _tracks[idx];
			//trace( _tracks);
			if (s == null)
			{
				//throw new Error("ERROR: No ressource for track " + idx);
			}
			else
			{
				if (idx != _currentBgmIdx) 
				{
					_paused = false;
					_channelBGM.stop();					
					_currentBgmIdx = idx;
					
					_channelBGM = s.play(0, 999,stBGM);					
				}
			}
			
		}
		
		// PAUSE/RESUME BGM
		public function pauseBGM():void
		{
			if (!_paused && _currentBgmIdx > -1)
			{
				_position = _channelBGM.position;
				_channelBGM.stop();
				_paused = true;
			}
		}
		
		public function resumeBGM():void
		{
			if (_paused && _currentBgmIdx > -1)
			{
				_channelBGM = _tracks[_currentBgmIdx].play(_position, 999);
				_paused = false;
			}
		
		}
		

		
		// STOP (not pause) EVERY SOUNDS
		public function stopAllSounds():void
		{
			_paused = false;
			_currentBgmIdx = -1;
			_position = .0;
			SoundMixer.stopAll();
		}
		
	}

}
