package com.mutado.linda.controls.OverlayMenu
{
	import com.mutado.linda.core.linda_ns;
	import com.mutado.linda.interfaces.IUILindaComp;
	
	import flash.filters.DropShadowFilter;
	
	import mx.containers.BoxDirection;
	import mx.containers.Panel;
	
	use namespace linda_ns;
	
	// ==================================================================================
	// STYLES
	// ==================================================================================
		
	include "../../../../../../metadata/styles/ShadowStyles.as"
	
	public class UIOverlayMenu extends Panel implements IUILindaComp
	{
		
		// ==================================================================================
		// VARIABLES
		// ==================================================================================
		
		// ==================================================================================
		// CONSTRUCTOR
		// ==================================================================================
		
		public function UIOverlayMenu()
		{
			super();
			_init();
		}
		
		// ==================================================================================
		// PRIVATE
		// ==================================================================================
		
		private function _init() : void
		{
			layout = BoxDirection.VERTICAL;
		}
		
		// ==================================================================================
		// PROTECTED
		// ==================================================================================
		
		override protected function commitProperties() : void
		{
			super.commitProperties();
			
			var shadow : DropShadowFilter = new DropShadowFilter();
			shadow.blurX = 18;
			shadow.blurY = 18;
			shadow.angle = 45;
			shadow.quality = 3;
			shadow.distance = 0;
			shadow.color = getStyle("customShadowColor");
			shadow.alpha = getStyle("customShadowAlpha");
			filters = [ shadow ];
		}
		
		// ==================================================================================
		// PUBLIC
		// ==================================================================================
		
		public function propagateProperties() : void
		{
			//
		}
		
		// ==================================================================================
		// PROPERTIES
		// ==================================================================================
		
	}
}