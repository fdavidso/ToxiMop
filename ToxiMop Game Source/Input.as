package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author DigitalJanitors
	 */
	public class Input extends MovieClip
	{
		public var mKeys:Array = new Array();
		public var mMouseDown:Boolean = false;
		
		public function Input() 
		{
			if ( stage )
				init();
			else
				addEventListener( Event.ADDED_TO_STAGE, init );
		}
		private function init( event:Event = null ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, init );
			
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			stage.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			
			var i:int;
			for ( i = 0; i < 256; i++ )
			{
				mKeys[ i ] = false;
			}
		}
		private function onMouseDown( event:MouseEvent ):void
		{
			mMouseDown = true;
		}
		private function onMouseUp( event:MouseEvent ):void
		{
			mMouseDown = false;
		}
		private function onKeyDown( event:KeyboardEvent ):void
		{
			mKeys[ event.keyCode ] = true;
		}
		private function onKeyUp( event:KeyboardEvent ):void
		{
			mKeys[ event.keyCode ] = false;
		}
	}

}