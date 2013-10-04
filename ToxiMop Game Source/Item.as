package  
{
	import flash.display.Bitmap;
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class Item extends GameObject 
	{
		private var animationSets_:AnimationSets = new AnimationSets;
		
		public const ITEM_TYPE_A:int = 1;
		public const ITEM_TYPE_B:int = 2;
		public const ITEM_TYPE_C:int = 3;
		public var mItemType:int;
		
		
		public function Item() 
		{
			if ( stage )
				init();
			else
				addEventListener( Event.ADDED_TO_STAGE, init );
		}
		private function init( event:Event = null ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, init );
			
			var dropchance:int = Math.random() * 100;
			
			if ( dropchance > 40 )
			{
				mItemType = ITEM_TYPE_A;
				mAnimArray = animationSets_.mItemRapidFireAnimSet;
			}
			else if ( (dropchance > 10) && ( dropchance <= 40 ) )
			{
				mItemType = ITEM_TYPE_C;
				mAnimArray = animationSets_.mItemRepairAnimSet;
			}
			else if ( dropchance <= 10 )
			{
				mItemType = ITEM_TYPE_B;
				mAnimArray = animationSets_.mItemNukeAnimSet;
			}
			
			
			mNumFrames = animationSets_.mItemAnimSpeed;
			this.addChild( sprite_ = new Bitmap( mAnimArray[ 0 ] ) );
	
			scale( 0.1, 0.1 );
			updateDimensions();
			
			resetOrigin( sprite_ );
		}
		public function update():void
		{
			animate(); 
			//alterScale();
		}
		public function closeDown():void
		{
			this.removeChild( sprite_ );
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
	}
}