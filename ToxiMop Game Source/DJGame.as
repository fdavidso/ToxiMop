package  
{
	import flash.display.Bitmap;
	import flash.display.MovieClip
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TextEvent;
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
	public class DJGame extends Sprite 
	{
		private var myChannel:SoundChannel;
		private var myTransform:SoundTransform;
		
		[Embed(source = "../Assets/Audio/shoot_00.mp3")] 
		private var shoot00:Class;
		[Embed(source = "../Assets/Audio/shoot_01.mp3")] 
		private var shoot01:Class;
		[Embed(source = "../Assets/Audio/shoot_02.mp3")] 
		private var shoot02:Class;
		
		private var bulletSoundArray:Array = new Array;
		
		[Embed(source = "../Assets/Audio/enemy_pop_00.mp3")]
		private var enemyPop00:Class;
		[Embed(source = "../Assets/Audio/enemy_pop_01.mp3")]
		private var enemyPop01:Class;
		[Embed(source = "../Assets/Audio/enemy_pop_02.mp3")]
		private var enemyPop02:Class;
		
		private var enemyPopSoundArray:Array = new Array;
		
		[Embed(source = "../Assets/Audio/pick_up_nuke.mp3")]
		private var pickUpNuke:Class;
		[Embed(source = "../Assets/Audio/pick_up_rapid_fire.mp3")]
		private var pickUpRapidFire:Class;
		[Embed(source = "../Assets/Audio/pick_up_repair.mp3")]
		private var pickUpRepair:Class;
		
		[Embed(source = "../Assets/Audio/Everlone_-_01_-_Flying_Alaska_V2.mp3")] private var gameAmbientAudio:Class;
		
		
		[Embed(source = "../Assets/Art/Background-Art-No-UI.png")] private var BackgroundImage:Class;
		private var background_:Bitmap = new Bitmap;
		
		[Embed(source = "../Assets/Art/dish.png")] private var PetrieDishImage:Class;
		private var petrieDish_:Bitmap = new Bitmap;
		
		[Embed(source="../Assets/Art/Cursor.png")] private var CursorImage:Class;
		private var cursor_:Bitmap;
		
		[Embed(source = "../Assets/Art/UI-only-revised.png")] private var UIImage:Class;
		private var userInterface_:Bitmap;
		
		[Embed(source = "../Assets/Art/Enemy-Ring-2.png")] private var BuletRingpng:Class;
		public var bulletRing_:Bitmap;
		
		[Embed(source = "../Assets/Art/game-over.png")] private var GameOverpng:Class;
		public var gameOver_:Bitmap;
		
		[Embed(source="../Assets/Font/Franchise-Bold.ttf", 
                fontName = "myFont", 
                mimeType = "application/x-font", 
                fontWeight="normal", 
                fontStyle="normal", 
                unicodeRange="U+0020-U+007E", 
                advancedAntiAliasing="true", 
                embedAsCFF="false")]
		private var FranchiseBold:Class;
		
		
		private var pickUpNukeSound:Sound = new pickUpNuke;
		private	var pickUpRapidFireSound:Sound = new pickUpRapidFire;
		private var	pickUpRepairSound:Sound = new pickUpRepair;
		private var mySound:Sound = new gameAmbientAudio;
		
		private var buttonRetry_:GameObject = new GameObject;
		private var buttonMainMenu_:GameObject = new GameObject;
		private var animationSets_:AnimationSets = new AnimationSets;
		private var player_:Player;
		
		private var input_:Input = new Input();
		
		private var centralArea_:DJCentralArea; 
		
		private var mBulletArray:Array = new Array();
		private var mEnemyArray:Array = new Array();
		private var mItemArray:Array = new Array();
		private var physicsHandler_:DJPhysicsHandler = new DJPhysicsHandler();
		
		private var mScalingFactor:Number = 0.533;
		private var mButtonClickedID:int;
		
		private var introCounter:int = 0;
		private var introFinished:Boolean = false;
		private const INTRO_SPEED:int = 20;
		
		private const SCREEN_WIDTH:int = 1024;
		private const SCREEN_HEIGHT:int = 576;
		
		private const CURSOR_SCALE:Number = 0.33;
		
		private const MAX_SCORE:int = 999999;
		private const BASE_SCORE:int = 100;
		private const MAX_BONUS:int = 32;
		private const SCORE_WIDTH:int = 220;
		private const SCORE_HEIGHT:int = 100;
		private const SCALING_FACTOR:Number = 0.533;
		private const BUTTON_UP:int = 0;
		private const BUTTON_HOVER:int = 1;
		private const BUTTON_DOWN:int = 2;
		
		private var scoreText:TextField = new TextField();
		private var bonusText:TextField = new TextField();
		private var finalScoreText:TextField = new TextField();
		
		private const FRAMES_PER_SECOND:int = 24;
		private var mFrameCounter:int;
		private const mSecondsUntilSpawn:int = 7;
		private var mMaxEnemies:int;
		private var mEnemySpawnIncrement:int = 1;
		private var mgameOver:Boolean = false;
		
		private var mButtonClicked:int;
		private var mTarget:Boolean = false;
		
		public var score:int = 0;
		public var bonus:Number = 1.0;
		
		public function DJGame() 
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
			this.addChild( physicsHandler_ );
			mButtonClickedID = 0;
			score = 0;
			bonus = 1.0;
			mFrameCounter = 0;
			mMaxEnemies = 0;
			mgameOver = false;
			introCounter = 0;
			introFinished = false;
			stage.addEventListener( "playerHasFired", shootBullet );	
			
			
			myChannel = new SoundChannel();
			myTransform = new SoundTransform();
			myChannel = mySound.play();
			myTransform.volume = 0.1;
			myChannel.soundTransform = myTransform;
			
			var shoot00Sound:Sound = new shoot00;
			var shoot01Sound:Sound = new shoot01;
			var shoot02Sound:Sound = new shoot02;
			bulletSoundArray.push(shoot00Sound);
			bulletSoundArray.push(shoot01Sound);
			bulletSoundArray.push(shoot02Sound);
			
			
			var enemyPop00Sound:Sound = new enemyPop00;
			var enemyPop01Sound:Sound = new enemyPop01;
			var enemyPop02Sound:Sound = new enemyPop02;
			enemyPopSoundArray.push( enemyPop00Sound );
			enemyPopSoundArray.push( enemyPop01Sound );
			enemyPopSoundArray.push( enemyPop02Sound );
			
			
		}
		
		public function onExit():void
		{
			stage.removeEventListener( "playerHasFired", shootBullet );
			while ( mBulletArray.length > 0 )
			{
				this.removeChild( mBulletArray.pop() );
			}
			while ( mEnemyArray.length > 0 )
			{
				this.removeChild( mEnemyArray.pop() );
			}
			while ( animationSets_.mPlayerIdleAnimSet.length > 0 )
			{
				animationSets_.mPlayerIdleAnimSet.pop();
			}
			
			player_.closeDown();
			this.removeChild( player_ );
			this.removeChild( input_ );
			this.removeChild( physicsHandler_ ); 
			this.removeChild( cursor_ );
			this.removeChild( petrieDish_ );
			this.removeChild( userInterface_ );
			this.removeChild( scoreText );
			this.removeChild( bonusText );
			this.removeChild( centralArea_ );	
			if (mgameOver)
			{
				this.removeChild( buttonRetry_.sprite_ );
				this.removeChild( buttonMainMenu_.sprite_ );
				this.removeChild( gameOver_ );
				this.removeChild( finalScoreText );
				removeEventListener( MouseEvent.MOUSE_DOWN, mouseDownEvent );
				removeEventListener( MouseEvent.MOUSE_UP, mouseUpEvent );	
			}
			addEventListener( Event.ADDED_TO_STAGE, init );
			
			myChannel.stop();
		}
		private function addEnemies( num:int, radius:Number ):void
		{
			var i:int;
			for ( i = 0; i < num; i++ )
			{
				var enemy:DJEnemy = new DJEnemy;
				this.addChild( enemy );
				if ( userInterface_ )
				{
					this.setChildIndex( enemy, this.getChildIndex( bulletRing_ ) );
				}
				// calculate a random point on a circle of a set radius
				var angle:Number = Math.random() * Math.PI * 2;
				enemy.translate( ( 1024 * 0.5 ) + Math.cos( angle ) * radius, ( 576 * 0.5 ) + Math.sin( angle ) * radius )
				
				enemy.resetOrigin( enemy.sprite_ );
				mEnemyArray.push( enemy );	
			}
		}
		private function shootBullet( e:Event = null ):void 
		{
			mBulletArray.push( createBullet() );
			var i:int = (int)(Math.random() * 3);
			bulletSoundArray[i].play();
			
		}
		private function createBullet():Bullet
		{
			var bullet:Bullet = new Bullet;
			this.addChild( bullet );
			if( userInterface_ )
					this.setChildIndex( bullet, this.getChildIndex( userInterface_ ) );
			bullet.translate( player_.mOrigin.x - bullet.mSpriteWidth/2, player_.mOrigin.y - bullet.mSpriteHeight/2 );
			bullet.setVelocity( stage.mouseX - player_.mOrigin.x, stage.mouseY - player_.mOrigin.y );
			bullet.mVelocity.normalize();
			bullet.translate( ( player_.mOrigin.x - bullet.mSpriteWidth / 2 ) + ( bullet.mVelocity.x * 20), ( player_.mOrigin.y - bullet.mSpriteHeight / 2 ) + ( bullet.mVelocity.y * 20) ),
			bullet.mVelocity.scaleBy( bullet.mSpeed );
			bullet.resetOrigin( bullet.sprite_ );
			bullet.rotateAroundCenter( bullet.sprite_, player_.mRotation, bullet.mOrigin );
			return bullet;
		}
		
		public function update():void
		{
			if (!introFinished)
			{
				introSequence();
			}
			else
			{
				cursor_.x = mouseX - cursor_.width / 2;
				cursor_.y = mouseY - cursor_.height / 2;
				if (!mgameOver)
				{
					if ( score >= MAX_SCORE )
					{
						score = MAX_SCORE;
					}
					if ( bonus >= MAX_BONUS )
					{
						bonus = MAX_BONUS;
					}
					bonusText.text = "x" + bonus;
					scoreText.text = "" + score;
	
					if ( mBulletArray.length > 0 )
					{
						var currentBullet:Bullet;
						for ( var i:int = 0; i < mBulletArray.length; i++ )
						{
							currentBullet = mBulletArray[ i ];
							currentBullet.update();
							if ( currentBullet.mRemove )
							{
								this.removeChild( currentBullet );
								mBulletArray.splice( i, 1 );
								break;
							}
						}
					}
					
					if ( mEnemyArray.length > 0 )
					{
						var currentEnemy:DJEnemy;
						for ( var j:int = 0; j < mEnemyArray.length; j++ )
						{
							currentEnemy = mEnemyArray[ j ];
							currentEnemy.update();
							if ( currentEnemy.mRemove )
							{
								if ( currentEnemy.mIsHostile )
								{
									centralArea_.mHealth -= currentEnemy.mDamageInflict;
									bonus = 1;
								}
								else
								{
									bonus += 0.5;
								}
								this.removeChild( currentEnemy );
								mEnemyArray.splice( j, 1 );
								break;
							}
						}
					}
					if ( mItemArray.length > 0 )
					{
						var currentItem:Item;
						for ( var l:int = 0; l < mItemArray.length; l++ )
						{
							currentItem = mItemArray[ l ]
							currentItem.update();
						}
					}
					if ( player_ ) 
						player_.update();
						
					if ( input_.mKeys[ 27 ] == true )	// Esc
						mButtonClickedID = 1;
						
					collisionsEnemyBullets();
					collisionsPlayerItems();
					collisionEnemyCentre();
					collisionBulletCentre();
					spawnEnemies();
					centralArea_.update();
					if (centralArea_.mIsDead)
						gameOver();
						
				}
				else
				{
					
					if ( !mTarget )
					{
						buttonRetry_.setAnimFrame( BUTTON_UP );
						buttonMainMenu_.setAnimFrame( BUTTON_UP );
						UpdateHover();
					}
					
				}
				
			}
		}
		
		private function collisionsPlayerItems():void
		{
			var currentItem:Item;
			for ( var i:int = 0; i < mItemArray.length; i++ )
			{
				currentItem = mItemArray[ i ];
				if ( physicsHandler_.circleCollision( player_, currentItem ) )
				{
					if ( currentItem.mItemType == currentItem.ITEM_TYPE_A )
					{
						player_.powerUp();
						pickUpRapidFireSound.play();
					}
					else if ( currentItem.mItemType == currentItem.ITEM_TYPE_B )
					{
						pickUpNukeSound.play();
						var currentEnemy:DJEnemy;
						for ( var l:int = 0; l < mEnemyArray.length; l++ )
						{
							currentEnemy = mEnemyArray[ l ];
							if ( currentEnemy.mIsHostile )
							{
								currentEnemy.changeHostility( false );
								score += ( BASE_SCORE * bonus );
								
							}
							
						}
					}
					else if ( currentItem.mItemType == currentItem.ITEM_TYPE_C )
					{
						pickUpRepairSound.play();
						if ( centralArea_.mHealth < centralArea_.MAX_HEALTH )
						{
							centralArea_.mHealth++;
						}
						else
						{
							score += ( BASE_SCORE * centralArea_.MAX_HEALTH * bonus );	
						}
					}
					
					this.removeChild( currentItem ); 
					mItemArray.splice( i, 1 ); 
					
				}
			}
		}
		private function collisionBulletCentre():void
		{
			var curentBullet:Bullet;
			for ( var i:int = 0; i < mBulletArray.length; i++ )
			{
				curentBullet = mBulletArray[ i ];
				if ( physicsHandler_.circleCollision( curentBullet, centralArea_.collisionAreaOuter ) )
				{
					physicsHandler_.collisionRespomse( curentBullet, true, centralArea_.collisionAreaOuter, false );
					curentBullet.mHasCollided = true;
				}
			}
		}
		private function collisionEnemyCentre():void
		{
			var currentEnemy:DJEnemy;
			for ( var i:int = 0; i < mEnemyArray.length; i++ )
			{
				currentEnemy = mEnemyArray[ i ];
				if ( physicsHandler_.circleCollision( currentEnemy, centralArea_.collisionArea ) )
				{
					currentEnemy.mHasCollided = true;
				}
			}
		}
		private function collisionsEnemyBullets():void
		{
			var currentBullet:Bullet;
			var currentEnemy:DJEnemy;
			for ( var k:int = 0; k < mBulletArray.length; k++ )
			{
				currentBullet = mBulletArray[ k ];
				for ( var l:int = 0; l < mEnemyArray.length; l++ )
				{
					currentEnemy = mEnemyArray[ l ];
					if ( currentEnemy.mIsHostile )
					{
						if ( !currentBullet.mHasCollided )
						{
							if ( physicsHandler_.circleCollision( currentBullet, currentEnemy ) )
							{
								physicsHandler_.collisionRespomse( currentBullet, true, currentEnemy, true );
								currentEnemy.changeHostility( false );
								currentBullet.mHasCollided = true;
								score += ( BASE_SCORE * bonus );
								var enemyPopSoundIndex:int = (int)(Math.random() * 3);
								enemyPopSoundArray[enemyPopSoundIndex].play();
								if ( currentEnemy.mDrops )
								{
									var item:Item = new Item;
									this.addChild( item );
									if( userInterface_ )
										this.setChildIndex( item, this.getChildIndex( userInterface_ ) );
									item.translate( currentEnemy.mOrigin.x, currentEnemy.mOrigin.y );
									item.resetOrigin( item.sprite_ );
									mItemArray.push( item );
								}
							}
						}
					}
				}		
			}
		}
		private function setupScreen():void
		{
			background_ = new BackgroundImage();
			this.addChild( background_ );
			background_.width *= mScalingFactor;
			background_.height *= mScalingFactor;
			
			petrieDish_ = new PetrieDishImage();
			this.addChild( petrieDish_ );
			petrieDish_.width *= mScalingFactor;
			petrieDish_.height *= mScalingFactor;
			
			
			gameOver_ = new GameOverpng();
			gameOver_.width *= SCALING_FACTOR;
			gameOver_.height *= SCALING_FACTOR;
			
			buttonMainMenu_.mAnimArray = animationSets_.mMainMenuButtonAnimSet;
			buttonRetry_.mAnimArray = animationSets_.mRetryButtonAnimSet;
			
		}
		
		public function getButton():int
		{
			return mButtonClickedID;
		}
		private function spawnEnemies():void
		{
			//private const FRAMES_PER_SECOND:int = 24;
			//private var mFrameCounter:int = 0;
			//private var mSecondsUntilSpawn:int = 5;
			//private var mMaxEnemies:int = 0;
			
			if ( ( mFrameCounter++ ) >= ( mSecondsUntilSpawn * FRAMES_PER_SECOND ) )
			{
				mFrameCounter = 0;
				mMaxEnemies += mEnemySpawnIncrement;
				trace( mMaxEnemies );
			
			}
			if ( mEnemyArray.length < mMaxEnemies )
			{
				addEnemies( ( mMaxEnemies - mEnemyArray.length ), 600 );
			}
			
			//if ( input_.mKeys[ 49 ] == true )	// 1
			//{
			//	addEnemies( 1, 600 );
			//}
		}
		private function introSequence():void
		{
			var tempPW:int;
			var tempPH:int;
			var tempBW:int;
			var tempBH:int;
			var scaleDown:Number = ( 1 + ( ( introCounter - 1 ) * ( 1.8 / INTRO_SPEED ) ) );
			var scaleUp:Number = ( 1 + ( introCounter * ( 1.8 / INTRO_SPEED ) ) );
			introCounter++;
			// Horrible double calculation scales it back down before scaling it up and uses old and new widths
			// to calculate new position
			background_.width /= scaleDown;
			background_.height /= scaleDown;
			petrieDish_.width /= scaleDown;
			petrieDish_.height /= scaleDown;
			
			tempPH = petrieDish_.height;
			tempPW = petrieDish_.width;
			tempBH = background_.height;
			tempBW = background_.width;
			
			background_.width *= scaleUp;
			background_.height *= scaleUp
			background_.x = -( ( ( background_.width - tempBW )/2 ) );
			background_.y = -( ( background_.height - tempBH )/2 );
			petrieDish_.width *= scaleUp;
			petrieDish_.height *= scaleUp;
			petrieDish_.x = -( ( petrieDish_.width - tempPW )/2 );
			petrieDish_.y = -( ( petrieDish_.height - tempPH ) / 2 );
			
			if ( introCounter == INTRO_SPEED )
			{
				introFinished = true;
				
				
				
				player_ = new Player();
				centralArea_ = new DJCentralArea();
				this.addChild( centralArea_ );
				
				
				bulletRing_ = new BuletRingpng();
				bulletRing_.width = centralArea_.collisionAreaOuter.mSpriteWidth;
				bulletRing_.height = centralArea_.collisionAreaOuter.mSpriteHeight;
				bulletRing_.x = (SCREEN_WIDTH - bulletRing_.width ) * 0.5;
				bulletRing_.y = (SCREEN_HEIGHT - bulletRing_.height ) * 0.5;
				this.addChild( bulletRing_ );
				
				this.addChild( player_ );
				
				userInterface_ = new UIImage();
				this.addChild( userInterface_ );
				userInterface_.width *= mScalingFactor;
				userInterface_.height *= mScalingFactor;
				
				var format :TextFormat = new TextFormat();
				format.font = "myFont";
				format.size = 100;
				format.color = 0xFFFFFF;
				
				scoreText.embedFonts = true;
				scoreText.defaultTextFormat = format;
				scoreText.y = 75;
				scoreText.selectable = false;
				scoreText.width = SCORE_WIDTH;
				scoreText.height = SCORE_HEIGHT;

				bonusText.embedFonts = true;
				bonusText.defaultTextFormat = format;
				bonusText.y = 75;
				bonusText.selectable = false;
				bonusText.width = SCORE_WIDTH;
				bonusText.height = SCORE_HEIGHT;
				bonusText.x = SCREEN_WIDTH - bonusText.width;
				
				finalScoreText.embedFonts = true;
				finalScoreText.defaultTextFormat = format;
				finalScoreText.x = 425;
				finalScoreText.y = 257;
				finalScoreText.selectable = false;
				finalScoreText.width = SCORE_WIDTH;
				finalScoreText.height = SCORE_HEIGHT;
				
				this.addChild( scoreText );
				this.addChild( bonusText );
				cursor_ = new CursorImage();
				this.addChild ( cursor_ );
				cursor_.width *= CURSOR_SCALE;
				cursor_.height *= CURSOR_SCALE;
				this.removeChild( background_ );
			}
		}
		
		private function gameOver():void
		{
			mgameOver = true;
			this.addChild( gameOver_ );
			this.setChildIndex( gameOver_, this.getChildIndex( cursor_ ) );
			finalScoreText.text = "" + score;
			this.addChild( finalScoreText );
			this.setChildIndex( finalScoreText, this.getChildIndex( cursor_ ) );
			this.addChild( buttonMainMenu_.sprite_ = new Bitmap( buttonMainMenu_.mAnimArray[0] ) );
			this.setChildIndex( buttonMainMenu_.sprite_, this.getChildIndex( cursor_ ) );
			buttonMainMenu_.scale(SCALING_FACTOR, SCALING_FACTOR);
			buttonMainMenu_.translate(400, 350);
			
			this.addChild( buttonRetry_.sprite_ = new Bitmap( buttonRetry_.mAnimArray[0] ) );
			this.setChildIndex( buttonRetry_.sprite_, this.getChildIndex( cursor_ ) );
			buttonRetry_.scale(SCALING_FACTOR, SCALING_FACTOR);
			buttonRetry_.translate(400, 350 + buttonMainMenu_.sprite_.height + 15);
			
			addEventListener( MouseEvent.MOUSE_DOWN, mouseDownEvent );
			addEventListener( MouseEvent.MOUSE_UP, mouseUpEvent );	
			
		}
		
		
		private function mouseDownEvent( event:MouseEvent ):void
		{
			mTarget = false;
			if ( cursor_.hitTestObject( buttonRetry_.sprite_ ) )
			{
				mTarget = true;
				buttonRetry_.setAnimFrame( BUTTON_DOWN );
			}
			if ( cursor_.hitTestObject( buttonMainMenu_.sprite_ ) )
			{
				mTarget = true;
				buttonMainMenu_.setAnimFrame( BUTTON_DOWN );
			}
		}
		
		private function mouseUpEvent( event:MouseEvent ):void
		{
			mTarget = false;
			if ( cursor_.hitTestObject( buttonRetry_.sprite_ ) )
			{
				
				onExit();
				init();
			}
			if ( cursor_.hitTestObject( buttonMainMenu_.sprite_ ) )
			{
				mButtonClickedID = 1;
			}
			
		}
		
		private function UpdateHover():void
		{
			if ( cursor_.hitTestObject( buttonRetry_.sprite_ ) )
				buttonRetry_.setAnimFrame( BUTTON_HOVER );
				
				if ( cursor_.hitTestObject( buttonMainMenu_.sprite_ ) )
				buttonMainMenu_.setAnimFrame( BUTTON_HOVER );
		}
		
		

	}
}