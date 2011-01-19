package com.mutado.linda.controls.ColorPicker
{
	import flash.events.Event;

	public class EyeDropperEvent extends Event
	{
		
		public static const COLOR_DROPPED : String		= "eyedropper_color_dropped";
		public static const CLOSE : String				= "eyedropper_close";
		
		public function EyeDropperEvent( type : String, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			super( type, bubbles, cancelable );
		}
		
	}
}