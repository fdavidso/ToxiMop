package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * Manages input and behaviour of the main player.
	 * @author DigitalJanitors
	 */
	
	
	public class Player extends GameObject 
	{	
		private const MIN_FRAMES_PER_SHOT:int = 4;
		
		private var mFramesPerShot:int = 24;
		private var mFrameCount:int = 0;
		
		private var input_:Input = new Input();
		private var animationSets_:AnimationSets = new AnimationSets;
		private var mCanShoot:Boolean = false;
		private const SCREEN_WIDTH:int = 1024;
		private const SCREEN_HEIGHT:int = 576;
	
		public function Player() 
		{
			if ( stage )
				init();
			else
				addEventListener( Event.ADDED_TO_STAGE, init );
		}
		private function init( event:Event = null ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, init );
			mMass = 20.0;
			this.addChild( input_ );
			mAnimArray = animationSets_.mPlayerIdleAnimSet;
			mNumFrames = animationSets_.mPlayerIdleSpeed;
			this.addChild( sprite_ = new Bitmap( mAnimArray[ 0 ] ) );
			
			scale( 0.20, 0.20 );
			updateDimensions();
			translate( ( SCREEN_WIDTH - mSpriteWidth ) * 0.5, ( SCREEN_HEIGHT - mSpriteHeight ) * 0.5  );
			resetOrigin( sprite_ );
			
		}
		public function powerUp():void
		{
			mFramesPerShot -= 4;
			if ( mFramesPerShot < MIN_FRAMES_PER_SHOT )
				mFramesPerShot = MIN_FRAMES_PER_SHOT;
				
		}
		public function update():void
		{
			handleInput();
			updateMovement();
			updateRotation();
			animate();
			doShooting();
		}
		private function doShooting():void
		{
			if ( input_.mMouseDown )
			{
				mAnimArray = animationSets_.mPlayerAttackAnimSet;
				setAnimFrame(0);
			}
			else
			{
				mAnimArray = animationSets_.mPlayerIdleAnimSet;
			}
			
			if ( mCanShoot )
			{
				if ( input_.mMouseDown )
				{
					mCanShoot = false;
					
					var shooting:Event = new Event( "playerHasFired" );
					stage.dispatchEvent( shooting );
				}
			}
			else if ( ( mFrameCount++ ) % mFramesPerShot == 0 )
			{
				mCanShoot = true;
			}
		}
		private function handleInput():void 
		{
			mSlowing = true;
			
			if ( input_.mKeys[ 65 ] == true )	// A
			{
				mVelocity.x -= ACCELERATION;
				mSlowing = false;
			}
			if ( input_.mKeys[ 68 ] == true ) 	// D
			{
				mVelocity.x += ACCELERATION;
				mSlowing = false;
			}
			if ( input_.mKeys[ 87 ] == true )	// W
			{
				mVelocity.y -= ACCELERATION;
				mSlowing = false;
			}
			if ( input_.mKeys[ 83 ] == true )	// S
			{
				mVelocity.y += ACCELERATION;
				mSlowing = false;
			}
		}
		private function updateMovement():void
		{
			mVelocity.scaleBy( RESISTANCE );
			
			if ( mSlowing )	
				clipVelocity();
			
			boundaryChecks();
			move();
			
		}
		private function updateRotation():void
		{
			var angleRadians:Number = Math.atan2( ( stage.mouseY - mOrigin.y ), ( stage.mouseX - mOrigin.x ) ) - ( Math.PI / 2 );
			
			rotateAroundCenter( sprite_, -mRotation, mOrigin );
			
			resetOrigin( sprite_ );
			
			rotateAroundCenter( sprite_, angleRadians, mOrigin );
			
			mRotation = angleRadians;
		}
		
		public function closeDown():void
		{
			this.removeChild( input_ );
			this.removeChild( sprite_ );
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function boundaryChecks(): void
		{	
			if ( ( ( mOrigin.x + sprite_.width/2 ) < 0) && ( mVelocity.x < 0 ) )
			{
				sprite_.x += ( SCREEN_WIDTH + sprite_.width );
				mOrigin.x += ( SCREEN_WIDTH + sprite_.width );
			}
			if ( ( ( mOrigin.x - sprite_.width/2 ) > SCREEN_WIDTH ) && ( mVelocity.x > 0 ) )
			{
				sprite_.x -= ( SCREEN_WIDTH + sprite_.width );
				mOrigin.x -= ( SCREEN_WIDTH + sprite_.width );
			}
			if ( ( ( mOrigin.y + sprite_.height/2 ) < 0) && ( mVelocity.y < 0 ) )
			{
				sprite_.y += ( SCREEN_HEIGHT + sprite_.height );
				mOrigin.y += ( SCREEN_HEIGHT + sprite_.height );
			}
			if ( ( ( mOrigin.y - sprite_.height/2 ) > SCREEN_HEIGHT ) && ( mVelocity.y > 0 ) )
			{
				sprite_.y -= ( SCREEN_HEIGHT + sprite_.height );
				mOrigin.y -= ( SCREEN_HEIGHT + sprite_.height );
			}
		
		}	
	}

}