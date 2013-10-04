package  
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	
	/**
	 * Contains all methods and data to do with altering, 
	 * animating and updating sprites.
	 * @author DigitalJanitors
	 */
	
	 
	public class DJSprite extends MovieClip 
	{
		public var sprite_:Bitmap;
		
		public var mAnimArray:Array = new Array();
		
		public var mFinishedAnim:Boolean = false;
		
		public var mFrame		:int = 0;
		public var mNumFrames	:int = 1;
		public var mCurrentFrame:int = 0;
		
		public var mSpriteWidth	:int = 32;	// Need to have these variables because when an image is rotated,
		public var mSpriteHeight:int = 32;	// the incorporated width and height values alter for the space
											// vertical and horizontal space they occupy.
		public function DJSprite() 
		{
			
		}
		public function updateDimensions():void
		{
			mSpriteWidth = sprite_.width;
			mSpriteHeight = sprite_.height;
		}
		public function resetAnim():void
		{
			sprite_.bitmapData = mAnimArray[ 0 ]; 
			mFinishedAnim = false;
		}
		public function setAnimFrame( frame:int ):void
		{
			if ( ( frame >= 0 ) && ( frame <= mAnimArray.length ) )
			{
				sprite_.bitmapData = mAnimArray[ frame ]; 
				mCurrentFrame = frame;
			}
			else 
			{
				trace("Invalid frame! Please select a frame within the animation set.");
			}
		}
		public function animateOnce():void
		{
			if ( !mFinishedAnim )
			{
				if( ( mFrame++ ) % mNumFrames == 0 )
				{
					mCurrentFrame++;
					sprite_.bitmapData = mAnimArray[ mCurrentFrame - 1 ]; 
					if ( mCurrentFrame > mAnimArray.length - 1 )
					{
						mFinishedAnim = true;
					}
				}
			}
			
		}
		public function animate():void
		{	
			if( ( mFrame++ ) % mNumFrames == 0 )
			{
				mCurrentFrame++;
				sprite_.bitmapData = mAnimArray[ mCurrentFrame - 1 ]; 
				if ( mCurrentFrame > mAnimArray.length - 1 )
					mCurrentFrame = 0;
			}
		}
	}

}