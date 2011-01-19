package com.mutado.linda.util
{	
	public class UISelection
	{
		
		[Embed(source="../../../../assets/assets.swf", symbol="linda.selection.Dashed")]
		public static const DASHED : Class;
		
		[Embed(source="../../../../assets/assets.swf", symbol="linda.selection.Handler")]
		public static const HANDLER : Class;
		
		[Embed(source="../../../../assets/assets.swf", symbol="linda.selection.HandlerRounded")]
		public static const HANDLER_ROUNDED : Class;
		
		[Embed(source="../../../../assets/assets.swf", symbol="linda.selection.Half")]
		public static const HALF : Class;	
		
		public static const PAN_NORMAL_STEP 	: uint			= 1;
		public static const PAN_SHIFT_STEP 		: uint 			= 10;
		
	}
}