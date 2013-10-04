package  
{	                                                                                   
	import flash.display.Bitmap;
	import flash.display.MovieClip
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.ui.Mouse;
	
	import flash.text.TextFieldAutoSize;
	import flash.text.TextField;
	import flash.text.TextFormat;

	
	/**
	 * ...
	 * @author Digital Janitors
	 */
	public class DJMenu extends Sprite 
	{
		private var myChannel:SoundChannel;
		private var myTransform:SoundTransform;
		
		[Embed(source = "../Assets/Audio/ui_click_down.mp3")]
		private var uiClickDown:Class;
		private var uiClickDownSound:Sound;
		[Embed(source = "../Assets/Audio/ui_click_up.mp3")]
		private var uiClickUp:Class;
		private var uiClickUpSound:Sound;
		
		[Embed(source = "../Assets/Audio/The_Lovely_Moon_-_02_-_And_We_Danced_Into_The_Night.mp3")]
		private var menuAmbientAudio:Class;
		
		[Embed(source = "../Assets/Art/Title.png")] private var TitleScreenImage:Class;
		private var titleScreen_:Bitmap = new Bitmap;
		
		[Embed(source="../Assets/Art/Cursor.png")] private var CursorImage:Class;
		private var cursor_:Bitmap = new Bitmap;
		
		private var mySound:Sound = new menuAmbientAudio;
		
		private var animationSets_:AnimationSets = new AnimationSets();
		private var input_:Input = new Input();
		private var buttonStart_:GameObject = new GameObject;
		private var buttonHowTo_:GameObject = new GameObject;
		private var buttonCredits_:GameObject = new GameObject;
		
		private const SCALING_FACTOR:Number = 0.533;

		private const BUTTON_UP:int = 0;
		private const BUTTON_HOVER:int = 1;
		private const BUTTON_DOWN:int = 2;
		
		private const START_BUTTON_X:int = 50;
		private const START_BUTTON_Y:int = 300;
		
		private const HOW_TO_BUTTON_X:int = 700;
		private const HOW_TO_BUTTON_Y:int = 385;
		
		private const CREDITS_BUTTON_X:int = 805;
		private const CREDITS_BUTTON_Y:int = 455;
		
		private const CURSOR_SCALE:Number = 0.33;
		
		private var mButtonClicked:int;
		//Used to stop UpdateHover function dominating the mouse events
		private var mTarget:Boolean = false;
		
		
		private var txt :TextField = new TextField();
		
		public function DJMenu() 
		{
			if ( stage )
				init();
			else
				addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init(event:Event = null ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, init );	
		
			setupScreen();
			mButtonClicked = 0;
			this.addChild( input_ );
			Mouse.hide();
			addEventListener( MouseEvent.MOUSE_DOWN, mouseDownEvent );
			addEventListener( MouseEvent.MOUSE_UP, mouseUpEvent );	
			
			uiClickDownSound = new uiClickDown;
			uiClickUpSound = new uiClickUp;
			
			myChannel = new SoundChannel();
			myTransform = new SoundTransform();
			myChannel = mySound.play();
			myTransform.volume = 0.1;
			myChannel.soundTransform = myTransform;
		}
		
		public function onExit():void
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
			this.removeChild( input_ );
			this.removeChild( cursor_ );
			this.removeChild( titleScreen_ );
			this.removeChild( buttonStart_.sprite_ );
			this.removeChild( buttonHowTo_.sprite_ );
			this.removeChild( buttonCredits_.sprite_ );
			removeEventListener( MouseEvent.MOUSE_DOWN, mouseDownEvent );
			removeEventListener( MouseEvent.MOUSE_UP, mouseUpEvent );	
			
			myChannel.stop();
		}
		
		public function update():void
		{
			if ( !mTarget )
			{
				buttonStart_.setAnimFrame( BUTTON_UP );
				buttonHowTo_.setAnimFrame( BUTTON_UP );
				buttonCredits_.setAnimFrame( BUTTON_UP );
				updateHover();
			}
			cursor_.x = mouseX - cursor_.width / 2;
			cursor_.y = mouseY - cursor_.height / 2;
			
		}
		
		private function setupScreen():void
		{
			titleScreen_ = new TitleScreenImage();
			this.addChild( titleScreen_ );
			titleScreen_.width *= SCALING_FACTOR;
			titleScreen_.height *= SCALING_FACTOR;
			
			buttonStart_.mAnimArray = animationSets_.mStartAnimSet;
			this.addChild( buttonStart_.sprite_ = new Bitmap( buttonStart_.mAnimArray[0] ) );
			buttonStart_.scale( SCALING_FACTOR, SCALING_FACTOR );
			buttonStart_.translate( START_BUTTON_X, START_BUTTON_Y );
		
			buttonHowTo_.mAnimArray = animationSets_.mHowToAnimSet;
			this.addChild( buttonHowTo_.sprite_ = new Bitmap( buttonHowTo_.mAnimArray[0] ) );
			buttonHowTo_.scale( SCALING_FACTOR, SCALING_FACTOR );
			buttonHowTo_.translate( HOW_TO_BUTTON_X, HOW_TO_BUTTON_Y );
			
			buttonCredits_.mAnimArray = animationSets_.mCreditsAnimSet;
			this.addChild( buttonCredits_.sprite_ = new Bitmap( buttonCredits_.mAnimArray[0] ) );
			buttonCredits_.scale( SCALING_FACTOR, SCALING_FACTOR );
			buttonCredits_.translate( CREDITS_BUTTON_X, CREDITS_BUTTON_Y );
			
			cursor_ = new CursorImage();
			cursor_.width *= CURSOR_SCALE;
			cursor_.height *= CURSOR_SCALE;
			this.addChild ( cursor_ );
		}
		
		private function mouseDownEvent( event:MouseEvent ):void
		{
			mTarget = false;
			if ( cursor_.hitTestObject( buttonStart_.sprite_ ) )
			{
				mTarget = true;
				buttonStart_.setAnimFrame( BUTTON_DOWN );
				uiClickDownSound.play();
			}
			
			if ( cursor_.hitTestObject( buttonHowTo_.sprite_ ) )
			{
				mTarget = true;
				buttonHowTo_.setAnimFrame( BUTTON_DOWN );
				uiClickDownSound.play();
			}
			
			if ( cursor_.hitTestObject( buttonCredits_.sprite_ ) )
			{
				mTarget = true;
				buttonCredits_.setAnimFrame( BUTTON_DOWN );
				uiClickDownSound.play();
			}	
		}
		
		private function mouseUpEvent( event:MouseEvent ):void
		{
			mTarget = false;
			if ( cursor_.hitTestObject( buttonStart_.sprite_ ) )
			{
				mButtonClicked = 1;
				uiClickUpSound.play();
			}
			
			if ( cursor_.hitTestObject( buttonHowTo_.sprite_ ) )
			{
				mButtonClicked = 2;
				uiClickUpSound.play();
			}
			
			if ( cursor_.hitTestObject( buttonCredits_.sprite_ ) )
			{
				mButtonClicked = 3;
				uiClickUpSound.play();
			}
		}
		
		private function updateHover():void
		{
			if ( cursor_.hitTestObject( buttonStart_.sprite_ ) )
				buttonStart_.setAnimFrame( BUTTON_HOVER );
			
			if ( cursor_.hitTestObject( buttonHowTo_.sprite_ ) )
				buttonHowTo_.setAnimFrame( BUTTON_HOVER );
			
			if ( cursor_.hitTestObject( buttonCredits_.sprite_ ) )
				buttonCredits_.setAnimFrame( BUTTON_HOVER );
		}
		
		public function getButton():int
		{
			return mButtonClicked;
		}
		
	}
}