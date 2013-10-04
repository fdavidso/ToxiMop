package  
{
	import flash.display.Bitmap;
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class DJCentralArea extends GameObject 
	{
		private const SCREEN_WIDTH:int = 1024;
		private const SCREEN_HEIGHT:int = 576;	
		
		private var animationSets_:AnimationSets = new AnimationSets;
		
		public var collisionArea:GameObject = new GameObject();
		public var collisionAreaOuter:GameObject = new GameObject();
		
		
		public const MAX_HEALTH:int = 5;
		public var mHealth:int;
		private var input_:Input = new Input();
		
		public function DJCentralArea() 
		{
			if ( stage )
				init();
			else
				addEventListener( Event.ADDED_TO_STAGE, init );
		}
		private function init( event:Event = null ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, init );
				
			mAnimArray = animationSets_.mCentralAreaAnimArray;
			mNumFrames = animationSets_.mCentralAreaAnimSpeed;
			this.addChild( sprite_ = new Bitmap( mAnimArray[ 0 ] ) );
			
			collisionArea.mSpriteWidth = 1;
			collisionArea.mSpriteHeight = 1;
			collisionArea.mOrigin.x = SCREEN_WIDTH * 0.5;
			collisionArea.mOrigin.y = SCREEN_HEIGHT * 0.5;
			this.addChild( collisionArea );
			mHealth = MAX_HEALTH;
			collisionAreaOuter.mSpriteWidth = 150;
			collisionAreaOuter.mSpriteHeight = 150;
			collisionAreaOuter.mOrigin.x = SCREEN_WIDTH * 0.5;
			collisionAreaOuter.mOrigin.y = SCREEN_HEIGHT * 0.5;
			this.addChild( collisionAreaOuter );
			
			this.addChild( input_ );
			
			scale( 0.5, 0.5 );
			updateDimensions();
			translate( ( SCREEN_WIDTH - mSpriteWidth ) * 0.5, ( SCREEN_HEIGHT - mSpriteHeight ) * 0.5  );
			resetOrigin( sprite_ );

		}
		public function update():void
		{
			alterScale();	
			if ( mHealth >= 0 )
			{
				switch( mHealth )
				{
					case 5:
						setAnimFrame(0);
						break;
					case 4:
						setAnimFrame(1);
						break;
					case 3:
						setAnimFrame(2);
						break;
					case 2:
						setAnimFrame(3);
						break;
					case 1:
						setAnimFrame(4);
						break;
					case 0:
						mIsDead = true;
						break
				}
			}
		}
		
	}

}