package  
{
	import flash.display.Bitmap;
	import flash.display.MovieClip
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.ui.Mouse;
	
	/**
	 * ...
	 * @author Digital Janitors
	 */
	public class DJHowTo extends Sprite 
	{
		[Embed(source = "../Assets/Audio/ui_click_down.mp3")]
		private var uiClickDown:Class;
		private var uiClickDownSound:Sound;
		[Embed(source = "../Assets/Audio/ui_click_up.mp3")]
		private var uiClickUp:Class;
		private var uiClickUpSound:Sound;
		
		[Embed(source = "../Assets/Art/How-To-Screen-Final.png")] private var HowToScreenImage:Class;
		private var howToScreen_:Bitmap = new Bitmap;
		
		[Embed(source="../Assets/Art/Cursor.png")] private var CursorImage:Class;
		private var cursor_:Bitmap = new Bitmap;
		
		private var buttonBack_:GameObject = new GameObject;
		
		private const SCALING_FACTOR:Number = 0.533;
		private const BUTTON_UP:int = 0;
		private const BUTTON_HOVER:int = 1;
		private const BUTTON_DOWN:int = 2;
		private const CURSOR_SCALE:Number = 0.33;
		private var mButtonClickedID:int;
		private var mTarget:Boolean = false;
		private var input_:Input = new Input();
		private var animationSets_:AnimationSets = new AnimationSets();
		
		public function DJHowTo() 
		{
		
			if ( stage )
				init();
			else
				addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init( event:Event = null ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, init );	
			
			setupScreen();
			this.addChild( input_ );
			mButtonClickedID = 0;
			Mouse.hide();
			
			uiClickDownSound = new uiClickDown;
			uiClickUpSound = new uiClickUp;
			
			addEventListener( MouseEvent.MOUSE_DOWN, mouseDownEvent );
			addEventListener( MouseEvent.MOUSE_UP, mouseUpEvent );
			
		}
		
		public function onExit():void
		{	
			this.removeChild( input_ );
			this.removeChild( howToScreen_ );
			this.removeChild( buttonBack_.sprite_ );
			removeEventListener( MouseEvent.MOUSE_DOWN, mouseDownEvent );
			removeEventListener( MouseEvent.MOUSE_UP, mouseUpEvent );	
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		public function update():void
		{
			cursor_.x = mouseX - cursor_.width / 2;
			cursor_.y = mouseY - cursor_.height / 2;
			
			if ( !mTarget )
			{
				buttonBack_.setAnimFrame( BUTTON_UP );
				UpdateHover();
			}
			
		}
		
		private function setupScreen():void
		{
			howToScreen_ = new HowToScreenImage();
			this.addChild( howToScreen_ );
			howToScreen_.width *= SCALING_FACTOR;
			howToScreen_.height *= SCALING_FACTOR;
			
			buttonBack_.mAnimArray = animationSets_.mBackButtonAnimSet;
			this.addChild( buttonBack_.sprite_ = new Bitmap( buttonBack_.mAnimArray[0] ) );
			buttonBack_.scale( CURSOR_SCALE/4, CURSOR_SCALE/4 );
			buttonBack_.translate( 15, 15 );
			
			cursor_ = new CursorImage();
			cursor_.width *= CURSOR_SCALE;
			cursor_.height *= CURSOR_SCALE;
			this.addChild ( cursor_ );
		}
		
		public function getButton():int
		{
			return mButtonClickedID;
		}
		
		private function mouseDownEvent( event:MouseEvent ):void
		{
			mTarget = false;
			if ( cursor_.hitTestObject( buttonBack_.sprite_ ) )
			{
				mTarget = true;
				buttonBack_.setAnimFrame( BUTTON_DOWN );
				uiClickDownSound.play();
			}
		}
		
		private function mouseUpEvent( event:MouseEvent ):void
		{
			mTarget = false;
			if ( cursor_.hitTestObject( buttonBack_.sprite_ ) )
			{
				mButtonClickedID = 1;
				uiClickUpSound.play();
			}
			
		}
		
		private function UpdateHover():void
		{
			if ( cursor_.hitTestObject( buttonBack_.sprite_ ) )
				buttonBack_.setAnimFrame( BUTTON_HOVER );
		}
		
		
	}

}