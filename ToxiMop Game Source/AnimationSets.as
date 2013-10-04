package  
{
	import flash.display.Bitmap;
	//Animation Sets with frame numbers and speeds
	public class AnimationSets 
	{	
		[Embed(source = "../Assets/Art/player-idle(frame1).png")] private var PlayerIdle00png:Class;
		[Embed(source = "../Assets/Art/player-idle(frame2).png")] private var PlayerIdle01png:Class;
		[Embed(source = "../Assets/Art/player-idle(frame3).png")] private var PlayerIdle02png:Class;
		public var mPlayerIdleAnimSet:Array = new Array();
		public var mPlayerIdleSpeed:int = 2;
		
		[Embed(source = "../Assets/Art/player-attack.png")] private var PlayerAttack00png:Class;
		public var mPlayerAttackAnimSet:Array = new Array();
		public var mPlayerAttackAnimSpeed:int = 4;
		
	
		[Embed(source = "../Assets/Art/Bullet.png")]private var Bullet00png:Class;
		[Embed(source = "../Assets/Art/Explosion.png")]private var Bullet01png:Class;
		public var mBulletAnimSet:Array = new Array();
		public var mBulletIdleSpeed:int = 1;
		
		[Embed(source = "../Assets/Art/Start-Button.png")] private var StartNormalpng:Class;
		[Embed(source = "../Assets/Art/Start-Button-Hover.png")] private var StartHoverpng:Class;
		[Embed(source = "../Assets/Art/Start-Button-On-Click.png")] private var StartClickpng:Class;
		public var mStartAnimSet:Array = new Array();
		public var mStartAnimSpeed:int = 1;
		
		[Embed(source = "../Assets/Art/Credits-Button.png")] private var CreditsNormalpng:Class;
		[Embed(source = "../Assets/Art/Credits-Button-Hover.png")] private var CreditsHoverpng: Class;
		[Embed(source = "../Assets/Art/Credits-Button-On-Click.png")] private var CreditsClickpng:Class;
		public var mCreditsAnimSet:Array = new Array();
		public var mCreditsAnimSpeed:int = 1;
		
		
		[Embed(source = "../Assets/Art/HowTo-Button.png")] private var HowToNormalpng:Class;
		[Embed(source = "../Assets/Art/HowTo-Button-Hover.png")] private var HowToHoverpng: Class;
		[Embed(source = "../Assets/Art/HowTo-Button-On-Click.png")] private var HowToClickpng:Class;
		public var mHowToAnimSet:Array = new Array();
		public var mHowToAnimSpeed:int = 1;
		
		[Embed(source = "../Assets/Art/back-button.png")] private var BackButtonNormalpng:Class;
		[Embed(source = "../Assets/Art/back-button-hover.png")] private var BackButtonHoverpng:Class;
		[Embed(source = "../Assets/Art/back-button-click.png")] private var BackButtonClickpng:Class;
		public var mBackButtonAnimSet:Array = new Array();
		public var mBackButtonAnimSpeed:int = 1;
		
		[Embed(source = "../Assets/Art/retry-button.png")] private var RetryButtonNormalpng:Class;
		[Embed(source = "../Assets/Art/retry-button-hover.png")] private var RetryButtonHoverpng:Class;
		[Embed(source = "../Assets/Art/retry-button-click.png")] private var RetryButtonClickpng:Class;
		public var mRetryButtonAnimSet:Array = new Array();
		public var mRetryButtonAnimSpeed:int = 1;
		
		[Embed(source = "../Assets/Art/Main-menu-Button.png")] private var MainMenuButtonNormalpng:Class;
		[Embed(source = "../Assets/Art/Main-menu-Button-Hover.png")] private var MainMenuButtonHoverpng:Class;
		[Embed(source = "../Assets/Art/Main-menu-Button-click.png")] private var MainMenuButtonClickpng:Class;
		public var mMainMenuButtonAnimSet:Array = new Array();
		public var mMainMenuButtonAnimSpeed:int = 1;
		
		[Embed(source = "../Assets/Art/Rapid-1.png")]private var ItemRapidFire0png:Class;
		[Embed(source = "../Assets/Art/Rapid-2.png")]private var ItemRapidFire1png:Class;
		public var mItemRapidFireAnimSet:Array = new Array();
		
		[Embed(source = "../Assets/Art/Nuke-1.png")]private var ItemNuke0png:Class;
		[Embed(source = "../Assets/Art/Nuke-2.png")]private var ItemNuke1png:Class;
		public var mItemNukeAnimSet:Array = new Array();
		
		[Embed(source = "../Assets/Art/Repair-1.png")]private var ItemRepair0png:Class;
		[Embed(source = "../Assets/Art/Repair-2.png")]private var ItemRepair1png:Class;
		public var mItemRepairAnimSet:Array = new Array();
		
		public var mItemAnimSpeed:int = 8;

		[Embed(source = "../Assets/Art/Hostile_1.png")]private var Hostile1png:Class;
		[Embed(source = "../Assets/Art/Hostile_2.png")]private var Hostile2png:Class;
		[Embed(source = "../Assets/Art/Hostile_3.png")]private var Hostile3png:Class;
		[Embed(source = "../Assets/Art/Enemy Death.png")]private var EnemyDeathpng:Class;
		[Embed(source = "../Assets/Art/Neutral_1.png")]private var Neutral1png:Class;
		[Embed(source = "../Assets/Art/Neutral_2.png")]private var Neutral2png:Class;
		[Embed(source = "../Assets/Art/Neutral_3.png")]private var Neutral3png:Class;
		
		public var mEnemy1AnimSet:Array = new Array();
		public var mEnemy2AnimSet:Array = new Array();
		public var mEnemy3AnimSet:Array = new Array();
		public var mEnemyAnimSpeed:int = 8;
		
		
		[Embed(source = "../Assets/Art/ring-1.png")]private var Ring1png:Class;
		[Embed(source = "../Assets/Art/ring-2.png")]private var Ring2png:Class;
		[Embed(source = "../Assets/Art/ring-3.png")]private var Ring3png:Class;
		[Embed(source = "../Assets/Art/ring-4.png")]private var Ring4png:Class;
		[Embed(source = "../Assets/Art/ring-5.png")]private var Ring5png:Class;
		public var mCentralAreaAnimArray:Array = new Array();
		public var mCentralAreaAnimSpeed:int = 1;
		
		
		public function AnimationSets() 
		{
			mCentralAreaAnimArray.push( ( new Ring1png() as Bitmap ).bitmapData );
			mCentralAreaAnimArray.push( ( new Ring2png() as Bitmap ).bitmapData );
			mCentralAreaAnimArray.push( ( new Ring3png() as Bitmap ).bitmapData );
			mCentralAreaAnimArray.push( ( new Ring4png() as Bitmap ).bitmapData );
			mCentralAreaAnimArray.push( ( new Ring5png() as Bitmap ).bitmapData );
			
			mEnemy1AnimSet.push( ( new Hostile1png() as Bitmap ).bitmapData );
			mEnemy1AnimSet.push( ( new EnemyDeathpng() as Bitmap ).bitmapData );
			mEnemy1AnimSet.push( ( new Neutral1png() as Bitmap ).bitmapData );
			
			mEnemy2AnimSet.push( ( new Hostile2png() as Bitmap ).bitmapData );
			mEnemy2AnimSet.push( ( new EnemyDeathpng() as Bitmap ).bitmapData );
			mEnemy2AnimSet.push( ( new Neutral2png() as Bitmap ).bitmapData );
			
			mEnemy3AnimSet.push( ( new Hostile3png() as Bitmap ).bitmapData );
			mEnemy3AnimSet.push( ( new EnemyDeathpng() as Bitmap ).bitmapData );
			mEnemy3AnimSet.push( ( new Neutral3png() as Bitmap ).bitmapData );
			
			mItemRapidFireAnimSet.push( ( new ItemRapidFire0png() as Bitmap ).bitmapData );
			mItemRapidFireAnimSet.push( ( new ItemRapidFire1png() as Bitmap ).bitmapData );
			
			mItemNukeAnimSet.push( ( new ItemNuke0png() as Bitmap ).bitmapData );
			mItemNukeAnimSet.push( ( new ItemNuke1png() as Bitmap ).bitmapData );
			
			mItemRepairAnimSet.push( ( new ItemRepair0png() as Bitmap ).bitmapData );
			mItemRepairAnimSet.push( ( new ItemRepair1png() as Bitmap ).bitmapData );
			
			mPlayerIdleAnimSet.push( ( new PlayerIdle00png() as Bitmap ).bitmapData );
			mPlayerIdleAnimSet.push( ( new PlayerIdle01png() as Bitmap ).bitmapData );
			mPlayerIdleAnimSet.push( ( new PlayerIdle02png() as Bitmap ).bitmapData );
			mPlayerIdleAnimSet.push( ( new PlayerIdle01png() as Bitmap ).bitmapData );
			
			mPlayerAttackAnimSet.push( ( new PlayerAttack00png() as Bitmap ).bitmapData );
			
			mBulletAnimSet.push( ( new Bullet00png() as Bitmap ).bitmapData );
			mBulletAnimSet.push( ( new Bullet01png() as Bitmap ).bitmapData );
			
			mStartAnimSet.push( ( new StartNormalpng() as Bitmap ).bitmapData );
			mStartAnimSet.push( ( new StartHoverpng() as Bitmap ).bitmapData );
			mStartAnimSet.push( ( new StartClickpng() as Bitmap ).bitmapData );
			
			mCreditsAnimSet.push( ( new CreditsNormalpng() as Bitmap ).bitmapData );
			mCreditsAnimSet.push( ( new CreditsHoverpng() as Bitmap ).bitmapData );
			mCreditsAnimSet.push( ( new CreditsClickpng() as Bitmap ).bitmapData );
			
			mHowToAnimSet.push( ( new HowToNormalpng() as Bitmap ).bitmapData );
			mHowToAnimSet.push( ( new HowToHoverpng() as Bitmap ).bitmapData );
			mHowToAnimSet.push( ( new HowToClickpng() as Bitmap ).bitmapData );
			
			mBackButtonAnimSet.push( ( new BackButtonNormalpng() as Bitmap ).bitmapData );
			mBackButtonAnimSet.push( ( new BackButtonHoverpng() as Bitmap ).bitmapData );
			mBackButtonAnimSet.push( ( new BackButtonClickpng() as Bitmap ).bitmapData );
			
			mMainMenuButtonAnimSet.push( ( new MainMenuButtonNormalpng() as Bitmap ).bitmapData );
			mMainMenuButtonAnimSet.push( ( new MainMenuButtonHoverpng() as Bitmap ).bitmapData );
			mMainMenuButtonAnimSet.push( ( new MainMenuButtonClickpng() as Bitmap ).bitmapData );
			
			mRetryButtonAnimSet.push( ( new RetryButtonNormalpng() as Bitmap ).bitmapData );
			mRetryButtonAnimSet.push( ( new RetryButtonHoverpng() as Bitmap ).bitmapData );
			mRetryButtonAnimSet.push( ( new RetryButtonClickpng() as Bitmap ).bitmapData );
		}
		
	}

}