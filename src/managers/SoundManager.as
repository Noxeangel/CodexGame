package managers
{
	import flash.display.MovieClip;
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

		private const MAX_TRACK:int = 16;
		//private var _tracks:Vector.<TransformedSound> = new Vector.<TransformedSound>(MAX_TRACK, true);
		private var _tracks:Array = new Array();

		// audio channel
		private var _channelBGM:SoundChannel = new SoundChannel;
		private var _channelSFX:SoundChannel = new SoundChannel;
		
		// 
		private var _currentBgmIdx:int = -1;

		private var _paused:Boolean = false;
		private var _position:Number = .0;


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

		public function addRessource(sound:Sound, idx:uint = Main.ACTION1):void
		{
			if ( idx < _tracks.length )
			{
				_tracks[idx] = sound;
				//trace(sound);
			}
			else
			{
				//throw new Error("ERROR: " + _tracks.length + " slots Max.");
			}
		}
		
		public function playSfx(idx:int = Main.ACTION1):void
		{
			/*
			var s:Sound = _tracks[idx];
			if (s == null)
			{
				//throw new Error("ERROR: No ressource for track " + idx);
			}
			else
			{
				_channelSFX.stop();
				_channelSFX = s.play();
				
			}
			*/
		}
		
		public function playBGM(idx:int = Main.BGM1, repeat:int = 999):void
		{
			/*
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
					_channelBGM = s.play(0, 999);					
				}
			}
			*/
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
