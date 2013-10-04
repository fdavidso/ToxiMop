package  
{
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author DigitalJanitors
	 */
	public class GameObject extends DJSprite 
	{
		public var mOrigin:Point = new Point();
		public var mVelocity:Vector3D = new Vector3D();
		
		public var mRotation:Number	= 0;
		public const ACCELERATION:Number = 1.0;
		public const RESISTANCE:Number = 0.9;
		
		public var mSlowing:Boolean = false;
		public var mClipValue:Number = 0.01;
		
		public var mSpeed:Number = 1.0;
		
		public var mMass:Number = 1.0;
		public var mIsDead:Boolean = false;
		public var mRemove:Boolean = false;
		public var mDamageInflict:int = 1;
		
		
		public var mHasCollided:Boolean = false;
		public var mFramesUntilDestroy:int = 8;
		
		private var mFrameMax:Number = 1.0;
		private var mFrameMin:Number = 0.7;
		private var mFrameCount:Number = mFrameMin;
		
		private var mFrameIncrement:Number = 0.0125;
		
		
		public function GameObject() 
		{
			
		}
		public function rotateAroundCenter ( ob:*, angleRadians:Number, p:Point ):void
		{
			var m:Matrix = ob.transform.matrix;
			
			m.translate( -p.x, -p.y );
			m.rotate( angleRadians );
			m.translate( p.x, p.y );
			
			ob.transform.matrix = m;
		}
		public function clipVelocity():void
		{
			if ( ( mVelocity.x < mClipValue ) && ( mVelocity.x > -mClipValue ) )
				mVelocity.x = 0;
		
			if ( ( mVelocity.y < mClipValue ) && ( mVelocity.y > -mClipValue ) )
				mVelocity.y = 0;
		}
		public function setRotation( angleDegrees:Number ):void
		{
			sprite_.rotation = angleDegrees;
		}
		public function resetOrigin(ob: *):void
		{
			mOrigin.x = ob.x + ob.width / 2;
			mOrigin.y = ob.y + ob.height / 2;
		}
		public function translate( _x:int, _y:int ):void
		{
			sprite_.x = _x;
			sprite_.y = _y;
		}
		public function setVelocity( velX:int, velY:int ):void
		{
			mVelocity.x = velX;
			mVelocity.y = velY;
		}
		public function scale( scaleX:Number, scaleY:Number ):void
		{
			sprite_.width *= scaleX;
			sprite_.height *= scaleY;
		}
		public function move():void
		{
			sprite_.x += mVelocity.x;
			sprite_.y += mVelocity.y;
			mOrigin.x += mVelocity.x;
			mOrigin.y += mVelocity.y;
		}
		
		public function alterScale():void
		{
			mFrameCount += mFrameIncrement;
			
			if ( ( mFrameCount > mFrameMax ) || ( mFrameCount < mFrameMin ) )
			{
				mFrameIncrement *= -1;
			}
			sprite_.width = mSpriteWidth * mFrameCount;
			sprite_.height = mSpriteHeight * mFrameCount;
			
			//not sure what the 0.5 is for :(
			translate( mOrigin.x - sprite_.width/2 + 0.5, mOrigin.y - sprite_.height/2  + 0.5 );
			resetOrigin( sprite_ );
			
			
			
		}
	}


}