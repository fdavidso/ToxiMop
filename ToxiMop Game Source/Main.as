package 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.ui.Mouse;

	/**
	 * ...
	 * @author DigitalJanitors
	 */
	
	[SWF(backgroundColor="#FFFFFF", width="1024", height="576", frameRate="24")]
	
	public class Main extends Sprite 
	{
		private var stateGame_:DJGame = new DJGame();
		private var stateMenu_:DJMenu = new DJMenu();
		private var stateCredits_:DJCredits = new DJCredits();
		private var stateHowTo_:DJHowTo = new DJHowTo();
		private var input_:Input = new Input();
		
		private var mGameRun:Boolean;
		private var mCreditsRun:Boolean;
		private var mHowToRun:Boolean;
		
		public function Main():void 
		{
			if ( stage ) 
				init();
			else 
				addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init( e:Event = null ):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, init );
			addEventListener( Event.ENTER_FRAME, update );
			this.addChild( input_ );
			this.addChild( stateMenu_  );
			
			mGameRun = false;
			mCreditsRun = false;
			mHowToRun = false;
		}
		
		private function update( event:Event ):void 
		{
			if ( mGameRun == true )
			{
				stateGame_.update();
				checkGame();
			}
			else if ( mCreditsRun == true )
			{
				stateCredits_.update();
				checkCredits();
			}
			else if ( mHowToRun == true )
			{
				stateHowTo_.update();
				checkHowTo();
			}
			else 
			{
				stateMenu_.update();
				checkMenu();
			}
		}
		
		private function checkMenu():void
		{
			
			switch ( stateMenu_.getButton() )
			{
				case 0:
					break;
				case 1:
					runGame();
					break;
				case 2:
					runHowTo();
					break;
				case 3:
					runCredits();
					break;
				default:
					break;
			}
		}
		
		private function checkGame():void
		{
			if ( stateGame_.getButton() == 1 )	// C
				exitGame();
		}
		
		private function checkHowTo():void
		{
			if ( stateHowTo_.getButton() == 1)
				exitHowTo();
		}
		
		private function checkCredits():void
		{
			if ( stateCredits_.getButton() == 1 )	// C
				exitCredits();
		}
		
		private function runGame():void
		{
			mGameRun = true;
			stateMenu_.onExit();
			this.removeChild( stateMenu_ );
			this.addChild( stateGame_ );
		}
		
		private function exitGame():void
		{
			mGameRun = false;
			stateGame_.onExit();
			this.removeChild( stateGame_ );
			this.addChild( stateMenu_ );
		}
		
		private function runHowTo():void
		{
			mHowToRun = true;
			stateMenu_.onExit();
			this.removeChild( stateMenu_ );
			this.addChild( stateHowTo_ );
		}
		
		private function exitHowTo():void
		{
			mHowToRun = false;
			stateHowTo_.onExit();
			this.removeChild( stateHowTo_ );
			this.addChild( stateMenu_ );
		}
		
		private function runCredits():void
		{
			mCreditsRun = true;
			stateMenu_.onExit();
			this.removeChild( stateMenu_ );
			this.addChild( stateCredits_ );
		}
		
		private function exitCredits():void
		{
			mCreditsRun = false;
			stateCredits_.onExit();
			this.removeChild( stateCredits_ );
			this.addChild( stateMenu_ );
		}
		
		
	}
}