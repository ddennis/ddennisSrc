package com.ddennis.sound {

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;

	/**
	 * Playback MP3-Loop (gapless)	 *
	 * This source code enable sample exact looping of MP3.	 * 
	 * http://blog.andre-michelle.com/2010/playback-mp3-loop-gapless/	 *
	 * Tested with samplingrate 44.1 KHz	 *
	 * <code>MAGIC_DELAY</code> does not change on different bitrates.
	 * Value was found by comparision of encoded and original audio file.	 *
	 * @author andre.michelle@audiotool.com (04/2010)
	 */
	
	 
	public final class MP3Loop extends Sprite {
		
		// hvis det er flash selv der komprimere fra wavw til MP3, så er det ikke nødvendigt at bruge MAGIC_DELAY.
		public const MAGIC_DELAY:Number = 500; // LAME 3.98.2 + flash.media.Sound Delay

		private const bufferSize: int = 3000; // Stable playback
		
		// kan hentes ved at 44000 *  ( Math.round ( theSound.length  ) / 1000  ) 
		public var samplesTotal:int // original amount of sample before encoding (change it to your loop)

		public var mp3: Sound = new Sound(); // Use for decoding
		public const out: Sound = new Sound(); // Use for output stream

		private var samplesPosition: int = 0;

		public var enabled: Boolean = false;		
		public var posMiliseconds:Number;
		
		public var isActive:Boolean 
		public static const PLAYING_STREAM:String = "playingStream"
		private var playingEvent:Event = new Event(MP3Loop.PLAYING_STREAM);
		
		public var loop:int = 0
		

		public function MP3Loop()	{
						
		}
				
	
		public function startPlayback():void {	
			
			out.addEventListener( SampleDataEvent.SAMPLE_DATA, sampleData );
			
			if (!isActive) {
				out.play();	
			}
			
			
		}

		
		
		
		
		public function cleanUp():void {	
			
			out.removeEventListener( SampleDataEvent.SAMPLE_DATA, sampleData );		
			
		}
		
		
		
		private function sampleData( event:SampleDataEvent ):void	{
		//	trace ("MP3Loop.as > sampleData  = ")
			if( enabled )			{
				extract( event.data, bufferSize );
			}
			else	{
				silent( event.data, bufferSize );
			}
		}

		/**
		 * This methods extracts audio data from the mp3 and wraps it automatically with respect to encoder delay
		 *
		 * @param target The ByteArray where to write the audio data
		 * @param length The amount of samples to be read
		 */
		private function extract( target: ByteArray, length:int ):void
		{
			while ( 0 < length )	{
							
				if( samplesPosition + length > samplesTotal ){
					var read: int = samplesTotal - samplesPosition;

					mp3.extract( target, read, samplesPosition  );

					samplesPosition += read;
					length -= read;
					
				
				}else {
					
					
					mp3.extract( target, length, samplesPosition  );
					samplesPosition += length;					
					length = 0;
					
				}

				if( samplesPosition == samplesTotal ) // END OF LOOP > WRAP
				{
					
					
					loop ++
					
					if (loop == 4) {
						loop = 0
					}
					
					
					samplesPosition = 0;
				}
				
				
				//var k =  ( target.position / target.length  ) 
				//var k =   ( samplesPosition   /samplesTotal  ) 
				//var k =  ( 44100/ (  samplesTotal / samplesPosition   )  ) /1000
				
				posMiliseconds  =   ( samplesPosition / 44000  ) * 1000								
				dispatchEvent(playingEvent)
				
			}
		}
		

		private function silent( target:ByteArray, length:int ):void		{
			target.position = 0;

			while( length-- )
			{
				target.writeFloat( 0.0 );
				target.writeFloat( 0.0 );
			}
		}
	

		public override function toString():String
		{
			return '[SandboxMP3Cycle]';
		}
	}
}