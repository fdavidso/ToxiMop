package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Digital Janitors
	 */
	
	public class Bullet extends GameObject
	{	
		public const DAMAGE:int = 10;
		private const SCREEN_WIDTH:int = 1024;
		private const SCREEN_HEIGHT:int = 576;
		private var animationSets_:AnimationSets = new AnimationSets;
		
		public function Bullet() 
		{
			if ( stage )
				init();
			else
				addEventListener( Event.ADDED_TO_STAGE, init );
		}
		private function init( event:Event = null ):void
		{
			mSpeed = 10;
			mMass = 5;
			mAnimArray = animationSets_.mBulletAnimSet;
			mNumFrames = animationSets_.mBulletIdleSpeed;
			this.addChild( sprite_ = new Bitmap( mAnimArray[ 0 ] ) );
			updateDimensions();
			
		}
		public function update():void
		{
			if ( !mHasCollided )
			{
				move();
			}
			else
			{
				if ( mFramesUntilDestroy > 0 )
				{
					setAnimFrame( 1 );
					mFramesUntilDestroy--;
				}
				else
				{
					mRemove = true;
				}
			}
			//if ( ( mOrigin.x  < 0 ) || ( mOrigin.x > SCREEN_WIDTH ) || ( mOrigin.y  < 0 ) || ( mOrigin.y > SCREEN_HEIGHT ))
			//	mRemove = true;
		}
	}
}