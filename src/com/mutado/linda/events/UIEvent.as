package com.mutado.linda.events
{
	import com.mutado.linda.core.linda_ns;
	
	import flash.events.Event;
	
	use namespace linda_ns;
	
	public class UIEvent extends Event
	{
		
		// ==================================================================================
		// EVENT TYPE
		// ==================================================================================
		
		public static const SHOW : String			= "UIControlsEvent_show";
		public static const HIDE : String			= "UIControlsEvent_hide";
		public static const CLOSE : String			= "UIControlsEvent_close";
		public static const CLOSING : String		= "UIControlsEvent_closing";
		public static const CHANGE : String			= "UIControlsEvent_change";
		public static const SELECT : String			= "UIControlsEvent_select";
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function UIEvent( type : String )
		{
			super( type );
		}
		
	}
}