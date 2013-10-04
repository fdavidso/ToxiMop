package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Digital Janitors
	 * Created: 09/09/2013
	 */
	public class DJPhysicsHandler extends MovieClip
	{
		
		public function DJPhysicsHandler() 
		{
			if ( stage )
				init();
			else
				addEventListener( Event.ADDED_TO_STAGE, init );
		}
		private function init( event:Event = null ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, init );
		}
		public function circleCollision( objA:*, objB:* ):Boolean
		{
			var a:GameObject = objA;
			var b:GameObject = objB;
			var xOffset:Number = b.mOrigin.x - a.mOrigin.x
			var yOffset:Number = b.mOrigin.y - a.mOrigin.y
			var sumOfRadii:Number = a.mSpriteWidth/2 + b.mSpriteWidth/2
			
			if ( ( xOffset * xOffset +  yOffset * yOffset ) <= ( sumOfRadii * sumOfRadii ) )
				return true;
			
			return false;
		}
		public function collisionRespomse( objA:*, moveA:Boolean, objB:*, moveB:Boolean ):void
		{
			var a:GameObject = objA;
			var b:GameObject = objB;
			var newVelXA:Number = a.mVelocity.x;
			var newVelYA:Number = a.mVelocity.y;
			var newVelXB:Number = b.mVelocity.x;
			var newVelYB:Number = b.mVelocity.y;
			
			newVelXA = (a.mVelocity.x * (a.mMass - b.mMass) + (2 * b.mMass * b.mVelocity.x)) / (a.mMass + b.mMass);
			newVelYA = (a.mVelocity.y * (a.mMass - b.mMass) + (2 * b.mMass * b.mVelocity.y)) / (a.mMass + b.mMass);
			newVelXB = (b.mVelocity.x * (b.mMass - a.mMass) + (2 * a.mMass * a.mVelocity.x)) / (a.mMass + b.mMass);
			newVelYB = (b.mVelocity.y * (b.mMass - a.mMass) + (2 * a.mMass * a.mVelocity.y)) / (a.mMass + b.mMass);
			
			if (moveA)
			{
				a.mVelocity.x = newVelXA;
				a.mVelocity.y = newVelYA;
			}
			if (moveB)
			{
				b.mVelocity.x = newVelXB;
				b.mVelocity.y = newVelYB;
			}
			
			
		}
	}

}