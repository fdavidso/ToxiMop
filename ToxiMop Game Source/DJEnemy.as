package  
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Digital Janitors
	 * Created: 09/09/2013
	 */
	public class DJEnemy extends GameObject 
	{
		private var animationSets_:AnimationSets = new AnimationSets;
		
		private var mAngleRadians:Number = Math.PI / 180;
		private var mTargetVec:Vector3D = new Vector3D();
		public var mIsHostile:Boolean = true;
		//public var mHealth:int = 5;
		private var mDropChance:Number = Math.random() * 100;
		private const mDropThreshold:Number = 20.0;
		public var mDrops:Boolean = false;
		
		public function DJEnemy() 
		{
			if ( stage )
				init();
			else
				addEventListener( Event.ADDED_TO_STAGE, init );
		}
		private function init( event:Event = null ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, init );
			
			mSpeed = 0.25;
			mMass = 1.0;
			determineIfDrops();
			
			var animSet:int = (int)( Math.random() * 3 ) + 1;
			switch( animSet )
			{
				case 1:
					mAnimArray = animationSets_.mEnemy1AnimSet;
					break;
				case 2:
					mAnimArray = animationSets_.mEnemy2AnimSet;
					break;
				case 3:
					mAnimArray = animationSets_.mEnemy3AnimSet;
					break;
					
			}
			mNumFrames = animationSets_.mEnemyAnimSpeed;
			this.addChild( sprite_ = new Bitmap( mAnimArray[ 0 ] ) );
	
			scale( 0.10, 0.10 );
			updateDimensions();
			
			resetOrigin( sprite_ );
		}
		private function determineIfDrops():void
		{
			
			if ( mDropChance < mDropThreshold )
				mDrops = true;
			
		}
		public function update():void
		{
			
			//animate(); 
			
			
			if ( !mHasCollided )
			{
				if ( !mIsHostile )
					animateOnce();
				
				updateVectors();
				updateMovement();
				updateRotation();
			}
			else
			{
				if ( mFramesUntilDestroy > 0 )
				{
					mFramesUntilDestroy--;
				}
				else
				{
					mRemove = true;
				}
			}
		}
		private function updateVectors():void
		{
			//TODO: Set target as a seperate entity. The values 1024 and 576 as below should be the width and height of the stage.
			mTargetVec.x = ( 1024 * 0.5 ) - mOrigin.x;
			mTargetVec.y = ( 576 * 0.5 ) - mOrigin.y;
			mTargetVec.normalize();
			
			mVelocity.x += ( mTargetVec.x * mSpeed );
			mVelocity.y += ( mTargetVec.y * mSpeed );
		}
		private function updateMovement():void
		{	
			mVelocity.scaleBy( RESISTANCE );
			move();
		}
		private function updateRotation():void
		{
			rotateAroundCenter( sprite_, -mRotation, mOrigin );
			resetOrigin( sprite_ );
			rotateAroundCenter( sprite_, mAngleRadians, mOrigin );
			mRotation = mAngleRadians;
		}
		public function changeHostility( b:Boolean ):void
		{
			if ( mIsHostile != b )
			{
				mIsHostile = b;
				setAnimFrame( 1 );
			}
		}
		public function closeDown():void
		{
			this.removeChild( sprite_ );
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
	}
}