package com.mutado.linda.controls.ColorPicker
{
	import flash.events.Event;

	public class ColorPickerBoxEvent extends Event
	{
		
		public static const CHANGE : String				= "colorpicker_box_change";
		public static const CLOSE : String				= "colorpicker_box_close";
		
		public function ColorPickerBoxEvent( type : String, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			super( type, bubbles, cancelable );
		}
		
	}
}